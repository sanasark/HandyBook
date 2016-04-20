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

@property (nullable, nonatomic, retain) NSString *bookPath;
@property (nullable, nonatomic, retain) NSSet<Word *> *unkowndWords;
@property (nullable, nonatomic, strong) NSString *bookContent;
@property (nullable, nonatomic, strong) NSString *coverImagePath;
@property (nullable, nonatomic, strong) NSString *title;
@property (nullable, nonatomic, strong) NSString *author;
@property (nullable, nonatomic, strong) NSString *bookDescription;
- (void)setPath:(nullable NSString *)bookPath
    bookContent:(nullable NSString *)bookContent
 coverImagePath:(nullable NSString *)coverImagePath
          title:(nullable NSString *)title
         author:(nullable NSString *)author
bookDescription:(nullable NSString *)bookDescription;

//- (void)addUnkowndWordsObject:(Word * _Nullable)value;
//- (void)removeUnkowndWordsObject:(nullable Word *)value;
//- (void)addUnkowndWords:(nullable NSSet<Word *> *)values;
//- (void)removeUnkowndWords:(nullable NSSet<Word *> *)values;

@end



