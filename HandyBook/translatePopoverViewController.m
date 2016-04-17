//
//  TranslatePopoverViewController.m
//  HandyBook
//
//  Created by User on 4/17/16.
//  Copyright © 2016 ACA. All rights reserved.
//

#import "TranslatePopoverViewController.h"
#import "DataManager.h"

@interface TranslatePopoverViewController ()

@property (weak, nonatomic) IBOutlet UILabel *translationLabel;
@end

@implementation TranslatePopoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.translationLabel.adjustsFontSizeToFitWidth = YES;
    self.translationLabel.text =self.translation;
    
}
- (IBAction)addButtonAction:(id)sender {
    [[DataManager sharedManager] insertWordInCoreData:self.word withTranslation:self.translation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
