//
//  TranslationViewController.m
//  HandyBook
//
//  Created by User on 4/15/16.
//  Copyright © 2016 ACA. All rights reserved.
//

#import "TranslationViewController.h"

@interface TranslationViewController ()

@property (weak, nonatomic) IBOutlet UILabel *translationLabel;

@end

@implementation TranslationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.translationLabel.text =[NSString stringWithFormat:@"%@   ===   %@",self.word.unknownWord,self.word.translation];
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
