//
//  Book.h
//  HandyBook
//
//  Created by User on 4/13/16.
//  Copyright © 2016 ACA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Word;


@interface Book : NSManagedObject

@property (nullable, nonatomic, retain) NSString *path;
@property (nullable, nonatomic, retain) NSSet<Word *> *unkowndWords;
@property (nullable, nonatomic, strong) NSString *text;
@property (nullable, nonatomic, strong) NSData *coverImage;
@property (nullable, nonatomic, strong) NSString *name;
@property (nullable, nonatomic, strong) NSString *author;

//- (void)addUnkowndWordsObject:(Word * _Nullable)value;
//- (void)removeUnkowndWordsObject:(nullable Word *)value;
//- (void)addUnkowndWords:(nullable NSSet<Word *> *)values;
//- (void)removeUnkowndWords:(nullable NSSet<Word *> *)values;

@end



