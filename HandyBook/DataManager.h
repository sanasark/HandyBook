//
//  DataManager.h
//  HandyBook
//
//  Created by User on 4/13/16.
//  Copyright © 2016 ACA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface DataManager : NSObject


+ (instancetype)sharedManager;

- (void)insertWordInCoreData:(NSString *)word withTranslation:(NSString *)Translation;
- (void)infoForWord:(NSString *)word complitionHandler:(wordInfoComplitionHandler)complitionHandler;
- (void)deleteWord:(Word *)word;
- (void)dictionaryWordsWithComplitionHandler:(dictWordsComplitionHandler)complitionHandler;
- (void)insertBookWithName:(NSString *)name text:(NSString *)text coverImage:(UIImage *)image;
@end
