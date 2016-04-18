//
//  ContentXMLParser.h
//  HandyBook
//
//  Created by User on 4/18/16.
//  Copyright © 2016 ACA. All rights reserved.
//

#import "EpubXMLFilesParser.h"

@interface ContentXMLParser : EpubXMLFilesParser

@property NSString *coverImagePath;
@property NSString *bookTitle;
@property NSString *bookCreator;
@property NSString *bookLanguage;
@property NSMutableString *bookDescription;
@property NSMutableArray *bookContentFilePaths;


@end
