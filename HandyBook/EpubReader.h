//
//  EpubReader.h
//  HandyBook
//
//  Created by User on 4/18/16.
//  Copyright © 2016 ACA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Book.h"

@interface EpubReader : NSObject

- (id)initWithEpub:(NSString *)file;
- (Book *)readEpub;

@end
