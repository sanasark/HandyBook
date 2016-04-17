//
//  ContainerXMLParser.h
//  HandyBook
//
//  Created by User on 4/17/16.
//  Copyright © 2016 ACA. All rights reserved.
//

#import "EpubXMLFilesParser.h"

@interface ContainerXMLParser : EpubXMLFilesParser

@property NSString *rootFile;

- (id)initWithFile:(NSString *)file;
- (void)parseXMLFile;

@end
