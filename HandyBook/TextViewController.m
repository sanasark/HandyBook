//
//  textViewController.m
//  HandyBook
//
//  Created by User on 4/19/16.
//  Copyright © 2016 ACA. All rights reserved.
//

#import "textViewController.h"
#import "TranslatePopoverViewController.h"
#import "YandexTranslateManager.h"
#import "HBtextView.h"
#import "DataManager.h"
#import "CheckPopoverViewController.h"
#import "ContainerXMLParser.h"
#import "TextManager.h"


@interface textViewController ()   <UIPopoverPresentationControllerDelegate, UIAdaptivePresentationControllerDelegate, UITextViewDelegate>



@property (nonatomic) dispatch_queue_t searchQueue;

@property (nonatomic, strong) NSMutableArray *arrayOfExistingWords;
@property (nonatomic, assign) BOOL checkPopover;


@end

@implementation textViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIFont * theFont = [UIFont boldSystemFontOfSize:14];
    CGSize charSize = [@"A" sizeWithFont:theFont];

    NSInteger col = self.textView.frame.size.height / charSize.height;
    NSInteger row = self.textView.frame.size.width  / charSize.width;
    NSInteger numberOfCharacters = col*row;
    NSMutableString *str = [[[TextManager sharedManager] epubText] mutableCopy];
    self.textArray = [[NSMutableArray alloc] init];
    NSLog(@"%D",[str length]/numberOfCharacters);
    [self.textArray insertObject:[str substringToIndex:(numberOfCharacters)]  atIndex:0];
    
    NSMutableString *temp= [[NSMutableString alloc] init];
    for (NSInteger i = 0; i<numberOfCharacters-1; i++) {
        [temp insertString:@"i" atIndex:0];
    }
    [temp insertString:@"2" atIndex:[temp length]];
    self.textView.text = temp;
    
    NSLog(@"%@",self.textArray[0]);

    
//    self.textView.text = self.textArray[0];
    
    if (self.checkIsOn) {
        self.searchQueue =  dispatch_queue_create("search", DISPATCH_QUEUE_CONCURRENT);
        self.checkPopover = NO;
        [self searchUnknownWordsWithComplitionHandler:^{
            [self checkTextinTextView:self.textView checkWordComplitionHandler:^(Word *word, CGRect sourceRect) {
                self.checkPopover = YES;
                [self showCheckBoxPopoverInTextView:self.textView inPosition:sourceRect forCheckingWord:word];
            }];
        }];
    }
    
}



- (void)searchUnknownWordsWithComplitionHandler:(complitionHandler)complitionHandler {
    self.arrayOfExistingWords = [[NSMutableArray alloc] init];
    
    dispatch_async(self.searchQueue, ^{
        NSArray *textArray = [self.textView.text componentsSeparatedByCharactersInSet:[[NSCharacterSet letterCharacterSet] invertedSet]] ;
        textArray = [textArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];
        [[DataManager sharedManager] dictionaryWordsWithComplitionHandler:^(NSArray *wordsInTheDictionary) {
            NSMutableArray *existingWords =  [wordsInTheDictionary mutableCopy];
            BOOL wordIsFound = NO;
            for (NSString *text in textArray) {
                for (Word *existingWord in existingWords) {
                    if ([text isEqualToString:existingWord.unknownWord] ) {
                        wordIsFound = YES;
                        [self.arrayOfExistingWords insertObject:existingWord atIndex:[self.arrayOfExistingWords count]];
                    }
                }
                if (wordIsFound) {
                    wordIsFound = NO;
                    [existingWords removeObject:text];
                }
            }
            dispatch_suspend(self.searchQueue);
            complitionHandler();
        }];
    });
    
}

- (void)checkTextinTextView:(UITextView *)textView checkWordComplitionHandler:(checkWordComplitionHandler)complitionHandler {
    
    if ([self.arrayOfExistingWords count]>0) {
        dispatch_resume(self.searchQueue);
        dispatch_async(self.searchQueue, ^{
            NSRange range = [textView.text rangeOfString:[self.arrayOfExistingWords[0] unknownWord]];
            UITextPosition *beginning = textView.beginningOfDocument;
            UITextPosition *start = [textView positionFromPosition:beginning offset:range.location];
            UITextPosition *end = [textView positionFromPosition:start offset:range.length];
            UITextRange *textRange = [textView textRangeFromPosition:start toPosition:end];
            CGRect textRect = [self textPositionWithRange:textRange inTextView:textView];
            dispatch_async(dispatch_get_main_queue(), ^{
                complitionHandler([self.arrayOfExistingWords objectAtIndex:0],textRect);
                NSLog(@"%@",[[self.arrayOfExistingWords objectAtIndex:0] unknownWord]);
                [self.arrayOfExistingWords removeObjectAtIndex:0];
                
            });
            
        });
        dispatch_suspend(self.searchQueue);
    };
    
    
}

- (void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController {
    if (self.checkIsOn && self.checkPopover)  {
        [self checkTextinTextView:self.textView checkWordComplitionHandler:^(Word *word, CGRect sourceRect) {
            self.checkPopover = YES;
            [self showCheckBoxPopoverInTextView:self.textView inPosition:sourceRect forCheckingWord:word];
        }];
    }
    self.checkPopover = NO;
}

- (void)showCheckBoxPopoverInTextView:(UITextView *)textView inPosition:(CGRect)sourceRect forCheckingWord:(Word        *)word {
    CheckPopoverViewController *popoverVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CheckPopoverViewController"];
    popoverVC.modalPresentationStyle = UIModalPresentationPopover;
    UIPopoverPresentationController *pop = [popoverVC popoverPresentationController];
    pop.permittedArrowDirections = UIPopoverArrowDirectionAny;
    pop.sourceView = textView.viewForFirstBaselineLayout;
    pop.sourceRect = sourceRect ;
    pop.delegate = self;
    popoverVC.wordForCheck = word;
    [self presentViewController:popoverVC animated:YES completion:nil];
    
}

- (void)textViewDidChangeSelection:(UITextView *)textView {

    UITextRange * selectionRange = [textView selectedTextRange];
    if (selectionRange) {
        NSString *text = [NSString stringWithFormat:@"%@",[textView textInRange:selectionRange]];
        CGRect sourceRect  = [self textPositionWithRange:selectionRange inTextView:textView];
        TranslatePopoverViewController *popoverVC = [self.storyboard instantiateViewControllerWithIdentifier:@"translatiePopover"];
        popoverVC.modalPresentationStyle = UIModalPresentationPopover;
        UIPopoverPresentationController *pop = [popoverVC popoverPresentationController];
        pop.permittedArrowDirections = UIPopoverArrowDirectionAny;
        pop.sourceView = textView.viewForFirstBaselineLayout;
        pop.sourceRect = sourceRect ;
        pop.delegate = self;
        
        [[YandexTranslateManager sharedManager] translateText:text toLanguage:@"en" completionHandler:^(NSString *translation, NSError *error) {
            
            popoverVC.translation = translation;
            popoverVC.word = text;
            [self presentViewController:popoverVC animated:YES completion:nil];
        }];
    }
    
}

- (CGRect)textPositionWithRange:(UITextRange *)range inTextView:(UITextView *)textView {
    CGRect startRect = [textView caretRectForPosition:range.start];
    CGRect endRect = [textView caretRectForPosition:range.end];
    CGRect sourceRect = CGRectMake(startRect.origin.x, startRect.origin.y, endRect.origin.x - startRect.origin.x, startRect.size.height);
    return sourceRect;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
