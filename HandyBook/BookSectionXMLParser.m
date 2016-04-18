//
//  BookSectionXMLParser.m
//  HandyBook
//
//  Created by User on 4/18/16.
//  Copyright © 2016 ACA. All rights reserved.
//

#import "BookSectionXMLParser.h"

@interface BookSectionXMLParser()

@property NSXMLParser *parser;
@property NSString *element;
@property NSDictionary *attribute;

@property NSString *file;

@end

@implementation BookSectionXMLParser

- (id)initWithFile:(NSString *)file {
    if (self = [super init]) {
        self.file = file;
        self.sectionContent = [@"" mutableCopy];
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
    if ([self.element isEqualToString:@"h1"] ||
        [self.element isEqualToString:@"h2"] ||
        [self.element isEqualToString:@"h3"] ||
        [self.element isEqualToString:@"p"]) {
        
        [self.sectionContent appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
    if ([self.element isEqualToString:@"body"]) {
        [self.parser abortParsing];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    if (!self.sectionContent) {
        //invalid epub;
    }
}

@end
