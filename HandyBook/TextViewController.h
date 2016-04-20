//
//  textViewController.h
//  HandyBook
//
//  Created by User on 4/19/16.
//  Copyright © 2016 ACA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HBtextView.h"

@interface textViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *textArray;

@property (weak, nonatomic) IBOutlet HBtextView *textView;
@property (nonatomic, assign) BOOL checkIsOn;
@property (nonatomic, assign) NSInteger pageNumber;

@end
