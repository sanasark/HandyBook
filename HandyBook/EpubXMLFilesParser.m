//
//  EpubXMLFilesParser.m
//  HandyBook
//
//  Created by User on 4/14/16.
//  Copyright © 2016 ACA. All rights reserved.
//

#import "EpubXMLFilesParser.h"

@interface EpubXMLFilesParser()

@property NSXMLParser *parser;
@property NSString *element;
@property NSDictionary *attribute;

@property NSString *file;

@end

@implementation EpubXMLFilesParser

- (id)initWithFile:(NSString *)file {
    if (self = [super init]) {
        self.file = file;
    }
    return self;
}

- (void)parseXMLFile {
    NSString *containerXMLPath = self.file;
    self.parser = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL fileURLWithPath:containerXMLPath]];
    self.parser.delegate = self;
    [self.parser parse];
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict {
    self.element = elementName;
    self.attribute = attributeDict;
}

- (void)parser:(NSXMLParser *)parser
foundCharacters:(NSString *)string {
    
    if ([self.element isEqualToString:@"rootfile"]) {//&&
        self.rootFile = [self.attribute valueForKey:@"full-path"];
    } else {
        //epub is invalid
    }
}

@end
