//
//  BookCollectionViewCell.h
//  HandyBook
//
//  Created by User on 4/21/16.
//  Copyright © 2016 ACA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *bookCell;
@property (weak, nonatomic) IBOutlet UIImageView *coverImage;

@end
