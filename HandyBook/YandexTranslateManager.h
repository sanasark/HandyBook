//
//  YandexTranslateManager.h
//  HandyBook
//
//  Created by User on 4/7/16.
//  Copyright © 2016 ACA. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^TranslateCompletionHandler)(NSString *, NSError *);


@interface YandexTranslateManager : NSObject

+ (instancetype)sharedManager;

- (NSString *)translateText:(NSString *)text toLanguage:(NSString *)language completionHandler:(TranslateCompletionHandler)completionHandler;



@end
