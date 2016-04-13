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

- (void)addUnkowndWordsObject:(Word *)value;
- (void)removeUnkowndWordsObject:(Word *)value;
- (void)addUnkowndWords:(NSSet<Word *> *)values;
- (void)removeUnkowndWords:(NSSet<Word *> *)values;

@end



