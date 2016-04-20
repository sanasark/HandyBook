//
//  TextManager.h
//  HandyBook
//
//  Created by User on 4/19/16.
//  Copyright © 2016 ACA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextManager : NSObject

@property (nonatomic, copy) NSString *epubText;
@property (nonatomic ,strong) NSMutableArray *pageRanges;
@property (nonatomic, assign) NSInteger numberOfPages;

+ (instancetype)sharedManager;

@end
