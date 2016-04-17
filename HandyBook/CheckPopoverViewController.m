//
//  CheckPopoverViewController.m
//  HandyBook
//
//  Created by User on 4/17/16.
//  Copyright © 2016 ACA. All rights reserved.
//

#import "CheckPopoverViewController.h"
#import "DataManager.h"
#import "Word.h"

@interface CheckPopoverViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;
@end

@implementation CheckPopoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)checkAction:(id)sender {

    if (self.textField.text == self.wordForCheck.translation) {
        NSLog(@"Ayo");
    } else {
        NSLog(@"Voch");
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

@end
