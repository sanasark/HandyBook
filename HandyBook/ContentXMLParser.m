//
//  ContentXMLParser.m
//  HandyBook
//
//  Created by User on 4/18/16.
//  Copyright © 2016 ACA. All rights reserved.
//

#import "ContentXMLParser.h"

@interface ContentXMLParser()

@property NSXMLParser *parser;
@property NSString *element;
@property NSDictionary *attribute;

@property NSString *file;

@property NSMutableDictionary *bookContentFilePathsWithOrder;
@property NSMutableArray *bookContentOrder;

@end

@implementation ContentXMLParser

- (id)initWithFile:(NSString *)file {
    if (self = [super init]) {
        self.file = file;
        self.bookContentFilePaths = [[NSMutableArray alloc] init];
        self.bookContentFilePathsWithOrder = [[NSMutableDictionary alloc] init];
        self.bookDescription = [@"" mutableCopy];
        self.bookContentOrder = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void)parseXMLFile {
    NSString *contentXMLPath = self.file;
    self.parser = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL fileURLWithPath:contentXMLPath]];
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

    if ([self.element isEqualToString:@"dc:title"] && !self.bookTitle) {
        self.bookTitle = string;
    } else if ([self.element isEqualToString:@"dc:creator"] && !self.bookCreator) {
        self.bookCreator = string;
    } else if ([self.element isEqualToString:@"dc:language"] && !self.bookLanguage) {
        self.bookLanguage = string;
    } else if ([self.element isEqualToString:@"dc:description"]) {
        
        [self.bookDescription appendString:string];
    }  else if ([self.element isEqualToString:@"item"]) {
        NSString *idValue = [self.attribute valueForKey:@"id"];
        if ([idValue isEqualToString:@"cover.jpg"]) {
            self.coverImagePath = [self.attribute valueForKey:@"href"];
        } else if (![idValue isEqualToString:@"cover"] &&
                    ![idValue isEqualToString:@"title"] &&
                    [[self.attribute valueForKey:@"media-type"] isEqualToString:@"application/xhtml+xml"]) {
            [self.bookContentFilePathsWithOrder setValue:[self.attribute valueForKey:@"href"]
                                                  forKey:[self.attribute valueForKey:@"id"]];
        }
    } else if ([self.element isEqualToString:@"itemref"] &&
               ![[self.attribute valueForKey:@"idref"] isEqualToString:@"cover"] &&
               ![[self.attribute valueForKey:@"idref"] isEqualToString:@"title"]) {
        [self.bookContentOrder addObject:[self.attribute valueForKey:@"idref"]];
    }
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {

    if ([self.element isEqualToString:@"spine"]) {
        [parser abortParsing];
    }
}
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    if (!self.coverImagePath) {
        //set some default path
    }
    if (!self.bookCreator || !self.bookTitle) {
        //invalid epub
    } else {
        for (NSString *bookOrderID in self.bookContentOrder) {
            [self.bookContentFilePaths addObject:[self.bookContentFilePathsWithOrder valueForKey:bookOrderID]];
        }
    }
}

@end
