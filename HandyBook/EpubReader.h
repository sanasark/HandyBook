//
//  EpubReader.h
//  HandyBook
//
//  Created by User on 4/18/16.
//  Copyright © 2016 ACA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EpubReader : NSObject

@property NSString *epubPath;
@property NSMutableString *epubContent;
@property NSString *epubCoverImagePath;
@property NSString *epubName;

- (id)initWithEpub:(NSString *)file;
- (void)readEpub;

@end
