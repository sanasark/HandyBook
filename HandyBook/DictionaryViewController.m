//
//  DictionaryViewController.m
//  HandyBook
//
//  Created by User on 4/13/16.
//  Copyright © 2016 ACA. All rights reserved.
//

#import "DictionaryViewController.h"
#import "MainViewController.h"

@interface DictionaryViewController ()

@end

@implementation DictionaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backToDictionary:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)backToMainPage:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
