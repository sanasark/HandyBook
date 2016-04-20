//
//  TextManager.m
//  HandyBook
//
//  Created by User on 4/19/16.
//  Copyright © 2016 ACA. All rights reserved.
//

#import "TextManager.h"

@implementation TextManager



+ (instancetype)sharedManager {
    static TextManager *instance;
    static dispatch_once_t token2;
    dispatch_once(&token2, ^{
        instance = [[TextManager alloc] init];
    });
    return instance;
}

@end
