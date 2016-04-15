//
//  DictionaryTableViewCell.h
//  HandyBook
//
//  Created by User on 4/15/16.
//  Copyright © 2016 ACA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Word.h"

@interface DictionaryTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@property (nonatomic, strong) Word *word;

@end
