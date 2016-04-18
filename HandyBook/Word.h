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

// есть number of right answers, числом является, если равно 3, hasLearnt bool == YES


//- (void)addContainingBooksObject:(Book *_Nullable)value;
//- (void)removeContainingBooksObject:(Book *_Nullable)value;
//- (void)addContainingBooks:(NSSet<Book *> *_Nullable)values;
//- (void)removeContainingBooks:(NSSet<Book *> *_Nullable)values;

@end
