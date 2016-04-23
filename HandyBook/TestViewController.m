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
@property NSInteger forRand;
@property NSInteger forIncorrectRand;
@property NSString *rightWord;
@property NSUInteger rightAnswers;
@property (weak, nonatomic) IBOutlet UILabel *Question;
@property (weak, nonatomic) IBOutlet UIButton *buttonOne;
@property (weak, nonatomic) IBOutlet UIButton *buttonTwo;
@property (weak, nonatomic) IBOutlet UIButton *buttonThree;
@property (weak, nonatomic) IBOutlet UIButton *buttonFour;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

@implementation TestViewController //Сделать Test и озеленение

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self myAlert:@"Sorry, You don't have enough words in the dictionary" andMessage:@"Come back later" andButton:@"Ok"];
    //    [self dismissViewControllerAnimated:YES completion:^{
    //        [self dismissViewControllerAnimated:YES completion:nil];
    //    }];
    self.resultLabel.text = @"0 from 10";
    [self test];
}


- (id)init {
    self = [super init];
    if (self) {
        _rightAnswers = 0;
    }
    return self;
}

- (IBAction)buttonAction:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:self.rightWord]) {
        [self test];
        self.rightAnswers = self.rightAnswers + 1;
        self.resultLabel.text = [NSString stringWithFormat:@"%ld from 10", (long)self.rightAnswers];
        if (self.rightAnswers == 10) {
            [self dismissViewControllerAnimated:YES completion:^{
                [self myAlert:@"You win!" andMessage:@"Congratulations" andButton:@"Ok"];
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
            self.rightAnswers = 0;
        }
    } else {
        [self myAlert:@"Fail" andMessage:@"Try again" andButton:@"Ok"];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
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

- (void)test {
    [[DataManager sharedManager] dictionaryWordsWithComplitionHandler:^(NSArray *myArray) {
        if ([myArray count] == 0) {
            [self dismissViewControllerAnimated:YES completion:nil];
            [self myAlert:@"Sorry" andMessage:@"You don't have enough words in dictionary" andButton:@"Ok"];
        } else if ([myArray count] >= 8) {
        self.forRand = 0 + rand()%[myArray count];
        self.rightWord = [[myArray objectAtIndex:self.forRand] translation];
        self.Question.text = [[myArray objectAtIndex:self.forRand] unknownWord];
        self.forRand = 0 + rand()%4;
        if (self.forRand == 0 || self.forRand == 1) {
            
            [self.buttonOne setTitle:self.rightWord forState:UIControlStateNormal];
        } else {
            self.forIncorrectRand = 0 + rand()%[myArray count];
            [self.buttonOne setTitle:[[myArray objectAtIndex:self.forIncorrectRand] translation] forState:UIControlStateNormal];
        }
        if (self.forRand == 2) {
            
            [self.buttonTwo setTitle:self.rightWord forState:UIControlStateNormal];
        } else {
            self.forIncorrectRand = 0 + rand()%[myArray count];
            [self.buttonTwo setTitle:[[myArray objectAtIndex:self.forIncorrectRand] translation] forState:UIControlStateNormal];
        }
        if (self.forRand == 3) {
            
            [self.buttonThree setTitle:self.rightWord forState:UIControlStateNormal];
        } else {
            self.forIncorrectRand = 0 + rand()%[myArray count];
            [self.buttonThree setTitle:[[myArray objectAtIndex:self.forIncorrectRand] translation] forState:UIControlStateNormal];
        }
        if (self.forRand == 4) {
            
            [self.buttonFour setTitle:self.rightWord forState:UIControlStateNormal];
        } else {
            self.forIncorrectRand = 0 + rand()%[myArray count];
            [self.buttonFour setTitle:[[myArray objectAtIndex:self.forIncorrectRand] translation] forState:UIControlStateNormal];
        }
        
        }
    }];
}

@end