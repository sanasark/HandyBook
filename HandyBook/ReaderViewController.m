//
//  ReaderViewController.m
//  HandyBook
//
//  Created by User on 4/17/16.
//  Copyright © 2016 ACA. All rights reserved.
//

#import "ReaderViewController.h"
#import "TranslatePopoverViewController.h"
#import "YandexTranslateManager.h"


@interface ReaderViewController ()  <UIPopoverPresentationControllerDelegate, UIAdaptivePresentationControllerDelegate, UITextViewDelegate>

@end

@implementation ReaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    
    UITextRange * selectionRange = [textView selectedTextRange];
    if (selectionRange) {
        NSString *text = [NSString stringWithFormat:@"%@",[textView textInRange:selectionRange]];
        
        CGRect selectionStartRect = [textView caretRectForPosition:selectionRange.start];
        CGRect selectionEndRect = [textView caretRectForPosition:selectionRange.end];
        CGRect sourceRect = CGRectMake(selectionStartRect.origin.x, selectionStartRect.origin.y, selectionEndRect.origin.x - selectionStartRect.origin.x, selectionStartRect.size.height);
        
        
        TranslatePopoverViewController *popoverVC = [self.storyboard instantiateViewControllerWithIdentifier:@"translatiePopover"];
        popoverVC.modalPresentationStyle = UIModalPresentationPopover;
        UIPopoverPresentationController *pop = [popoverVC popoverPresentationController];
        pop.permittedArrowDirections = UIPopoverArrowDirectionAny;
        pop.sourceView = textView.viewForFirstBaselineLayout;
        pop.sourceRect = sourceRect ;
        pop.delegate = self;
        
        [[YandexTranslateManager sharedManager] translateText:text toLanguage:@"ru" completionHandler:^(NSString *translation, NSError *error) {
            
            popoverVC.translation = translation;
            popoverVC.word = text;
            [self presentViewController:popoverVC animated:YES completion:nil];
        }];
    }
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}


@end
