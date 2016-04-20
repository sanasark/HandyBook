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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    

}

- (void)viewDidLayoutSubviews {
    if ([[[TextManager sharedManager] pageRanges] count] > self.pageNumber) {
        NSArray *temp = [[[TextManager sharedManager] pageRanges] objectAtIndex:self.pageNumber];
        self.textView.text = [[[[TextManager sharedManager] epubText] substringFromIndex:[temp[0] integerValue]] substringToIndex:[temp[1] integerValue]];
        
    } else {
        
        
        
        if (self.pageNumber == 0) {
            NSInteger remainingLenght = [[[TextManager sharedManager] epubText] length];
            if ( remainingLenght > 2000 ) {
                self.textView.text = [[[TextManager sharedManager] epubText] substringToIndex:2000] ;
            } else {
                self.textView.text = [[[TextManager sharedManager] epubText] substringToIndex:remainingLenght];
            }
            
            NSNumber *pageLenght =[NSNumber numberWithInteger:[self visibleRangeOfTextView:self.textView]];
            NSArray *temp = [NSArray arrayWithObjects:@0, pageLenght, nil];
            [[[TextManager sharedManager] pageRanges] insertObject:temp atIndex:self.pageNumber];
            
        } else {
            NSInteger remainingLenght = ([[[TextManager sharedManager] epubText] length] - [[[[[TextManager sharedManager] pageRanges] objectAtIndex:(self.pageNumber -1)] objectAtIndex:1] integerValue]);
            NSArray *temp = [[[TextManager sharedManager] pageRanges] objectAtIndex:(self.pageNumber -1 )];
            NSInteger startLocation = [[temp objectAtIndex:1] integerValue];
            if ( remainingLenght > 2000 ) {
                self.textView.text = [[[[TextManager sharedManager] epubText] substringFromIndex:startLocation] substringToIndex:(startLocation + 20000)];
            } else {
                self.textView.text = [[[[TextManager sharedManager] epubText] substringFromIndex:startLocation] substringToIndex:(startLocation + remainingLenght)];
            }

            NSNumber *pageLenght =[NSNumber numberWithInteger:([self visibleRangeOfTextView:self.textView] + startLocation)];
            NSArray *temp2 = [NSArray arrayWithObjects:[NSNumber numberWithInteger:[temp[1] integerValue] ] , pageLenght, nil];
            [[[TextManager sharedManager] pageRanges] insertObject:temp2 atIndex:self.pageNumber];

        }
        
    }
    if ([[[TextManager sharedManager] epubText] length] > [[[[[TextManager sharedManager] pageRanges] objectAtIndex:self.pageNumber] objectAtIndex:1] integerValue]) {
        [TextManager sharedManager].numberOfPages++;
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


- (NSInteger)visibleRangeOfTextView:(UITextView *)textView {
    CGRect bounds = textView.bounds;
    UITextPosition *temp1 = textView.beginningOfDocument;
    UITextPosition *temp2 = textView.endOfDocument;
    UITextPosition *start = [textView characterRangeAtPoint:bounds.origin].start;
    UITextPosition *end = [textView characterRangeAtPoint:CGPointMake(bounds.size.width, bounds.size.height)].end;
    NSRange range = NSMakeRange([textView offsetFromPosition:textView.beginningOfDocument toPosition:start],
                                [textView offsetFromPosition:start toPosition:end]);
    NSLog(@"%lu", (unsigned long)range.length);
    return range.length;
}

- (void)checkTextinTextView:(UITextView *)textView checkWordComplitionHandler:(checkWordComplitionHandler)complitionHandler {
    
    if ([self.arrayOfExistingWords count]>0) {
            NSRange range = [textView.text rangeOfString:[self.arrayOfExistingWords[0] unknownWord]];
            UITextPosition *beginning = textView.beginningOfDocument;
            UITextPosition *start = [textView positionFromPosition:beginning offset:range.location];
            UITextPosition *end = [textView positionFromPosition:start offset:range.length];
            UITextRange *textRange = [textView textRangeFromPosition:start toPosition:end];
            CGRect textRect = [self textPositionWithRange:textRange inTextView:textView];
                complitionHandler([self.arrayOfExistingWords objectAtIndex:0],textRect);
                NSLog(@"%@",[[self.arrayOfExistingWords objectAtIndex:0] unknownWord]);
                [self.arrayOfExistingWords removeObjectAtIndex:0];
            
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
  // [self visibleRangeOfTextView:self.textView];
    
    UITextRange * selectionRange = [textView selectedTextRange];
    NSString *text = [NSString stringWithFormat:@"%@",[textView textInRange:selectionRange]];
    if (selectionRange && !([text isEqualToString:@""])) {
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
