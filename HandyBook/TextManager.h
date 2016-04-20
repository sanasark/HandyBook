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

+ (instancetype)sharedManager;

@end
