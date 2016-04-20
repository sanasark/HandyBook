//
//  Book.m
//  HandyBook
//
//  Created by User on 4/13/16.
//  Copyright © 2016 ACA. All rights reserved.
//

#import "Book.h"
#import "Word.h"

@implementation Book

@dynamic bookPath, unkowndWords, bookContent, coverImagePath, title, author, bookDescription;


- (void)setPath:(nullable NSString *)bookPath
    bookContent:(nullable NSString *)bookContent
 coverImagePath:(nullable NSString *)coverImagePath
          title:(nullable NSString *)title
         author:(nullable NSString *)author
bookDescription:(nullable NSString *)bookDescription {
    self.bookPath = bookPath;
    self.bookContent = bookContent;
    self.coverImagePath = coverImagePath;
    self.title = title;
    self.author = author;
    self.bookDescription = bookDescription;
}

@end
