//
//  Word.h
//  HandyBook
//
//  Created by User on 4/13/16.
//  Copyright © 2016 ACA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Book;

@interface Word : NSManagedObject

@property (nullable, nonatomic, retain) NSNumber *askedTimes;
@property (nullable, nonatomic, retain) NSNumber *numberOfRightAnsers;
@property (nullable, nonatomic, retain) NSString *translation;
@property (nullable, nonatomic, retain) NSString *unknownWord;
@property (nullable, nonatomic, retain) NSSet<Book *> *containingBooks;


- (void)addContainingBooksObject:(Book *)value;
- (void)removeContainingBooksObject:(Book *)value;
- (void)addContainingBooks:(NSSet<Book *> *)values;
- (void)removeContainingBooks:(NSSet<Book *> *)values;

@end
