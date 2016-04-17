//
//  TestViewController.m
//  HandyBook
//
//  Created by User on 4/13/16.
//  Copyright © 2016 ACA. All rights reserved.
//

#import "TestViewController.h"
#import "YandexTranslateManager.h"
#import "DataManager.h"

@interface TestViewController ()
@property NSInteger *forRand;
@property NSInteger *forIncorrectRand;
@property (weak, nonatomic) IBOutlet UILabel *Question;
@property (weak, nonatomic) IBOutlet UIButton *buttonOne;
@property (weak, nonatomic) IBOutlet UIButton *buttonTwo;
@property (weak, nonatomic) IBOutlet UIButton *buttonThree;
@property (weak, nonatomic) IBOutlet UIButton *buttonFour;

@end

@implementation TestViewController //Сделать Test и озеленение

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self myAlert:@"Sorry, You don't have enough words in the dictionary" andMessage:@"Come back later" andButton:@"Ok"];
    //    [self dismissViewControllerAnimated:YES completion:^{
    //        [self dismissViewControllerAnimated:YES completion:nil];
    //    }];
    [[DataManager sharedManager] dictionaryWordsWithComplitionHandler:^(NSArray *myArray) {
        NSLog(@"%lu", (unsigned long)[myArray count]);
        _forRand = 0 + rand()%[myArray count];
        NSString *word = [[myArray objectAtIndex:_forRand] translation];
        self.Question.text = [[myArray objectAtIndex:_forRand] unknownWord];
        _forRand = 0 + rand()%4;
        NSLog(@"%i", _forRand);
        if (_forRand == 0 || _forRand == 1) {
            
            [_buttonOne setTitle:word forState:UIControlStateNormal];
        } else {
            _forIncorrectRand = 0 + rand()%[myArray count];
            [_buttonOne setTitle:[[myArray objectAtIndex:_forIncorrectRand]translation] forState:UIControlStateNormal];
        }
        if (_forRand == 2) {
            
            [_buttonTwo setTitle:word forState:UIControlStateNormal];
        } else {
            _forIncorrectRand = 0 + rand()%[myArray count];
            [_buttonTwo setTitle:[[myArray objectAtIndex:_forIncorrectRand]translation] forState:UIControlStateNormal];
        }
        if (_forRand == 3) {
            
            [_buttonThree setTitle:word forState:UIControlStateNormal];
        } else {
            _forIncorrectRand = 0 + rand()%[myArray count];
            [_buttonThree setTitle:[[myArray objectAtIndex:_forIncorrectRand]translation] forState:UIControlStateNormal];
        }
        if (_forRand == 4) {
            
            [_buttonFour setTitle:word forState:UIControlStateNormal];
        } else {
            _forIncorrectRand = 0 + rand()%[myArray count];
            [_buttonFour setTitle:[[myArray objectAtIndex:_forIncorrectRand]translation] forState:UIControlStateNormal];
        }
        
        
    }];//
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)BreakTest:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)myAlert:(NSString*)alertTitle andMessage:(NSString*)message andButton:(NSString*)button {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:alertTitle
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:button style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}


@end
