//
//  SettingViewController.m
//  HandyBook
//
//  Created by User on 4/13/16.
//  Copyright © 2016 ACA. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()
@property (weak, nonatomic) IBOutlet UIPickerView *leftFlag;
@property (weak, nonatomic) IBOutlet UIPickerView *rightFlag;
@property (nonatomic) NSArray *flags;
@property (nonatomic) NSArray *languages;
@property (weak, nonatomic) IBOutlet UIPickerView *interfaceFlag;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftFlag.dataSource = self;
    self.leftFlag.delegate = self;
    self.rightFlag.dataSource = self;
    self.rightFlag.delegate = self;
    self.interfaceFlag.dataSource = self;
    self.interfaceFlag.delegate = self;
    self.flags = [[NSArray alloc] initWithObjects:@"RUS", @"ENG", @"FR", nil];
    self.languages = [[NSArray alloc] initWithObjects:@"Russia", @"England", nil];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if ([pickerView isEqual:self.interfaceFlag]) {
        return 2;
    } else {
        return 3;
    }
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if ([pickerView isEqual:self.interfaceFlag]) {
        return self.languages[row];
    } else {
        return self.flags[row];
    }
}
- (IBAction)ConfirmSettings:(id)sender {
    [self myAlert:@"Complete" andMessage:@"Settings changed" andButton:@"Ok"];
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
