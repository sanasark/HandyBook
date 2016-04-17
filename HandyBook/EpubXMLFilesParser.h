//
//  EpubXMLFilesParser.h
//  HandyBook
//
//  Created by User on 4/14/16.
//  Copyright © 2016 ACA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EpubXMLFilesParser : NSObject<NSXMLParserDelegate>

- (id)initWithFile:(NSString *)file;
- (void)parseXMLFile;

@end
