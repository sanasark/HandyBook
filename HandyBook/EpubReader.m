//
//  EpubReader.m
//  HandyBook
//
//  Created by User on 4/18/16.
//  Copyright © 2016 ACA. All rights reserved.
//

#import "EpubReader.h"
#import "ZipArchive.h"
#import "ContainerXMLParser.h"
#import "ContentXMLParser.h"

@interface EpubReader()

@property NSString *booksDirectory;

@end

@implementation EpubReader

- (id)initWithEpub:(NSString *)path {
    if (self = [super init]) {
        self.epubPath = path;
        self.epubName = [[self.epubPath lastPathComponent] stringByDeletingPathExtension];
        NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        self.booksDirectory = [documentsDirectory stringByAppendingString:[NSString stringWithFormat:@"/%@", self.epubName]];
    }
    return self;
}

- (void)readEpub {
    [self unZipEpub];
    //parse Container.xml to get content.opf path
    ContainerXMLParser *containerParser = [[ContainerXMLParser alloc] initWithFile:[self.booksDirectory stringByAppendingString:@"/META-INF/container.xml"]];
    [containerParser parseXMLFile];
    //parse Content.opf
    ContentXMLParser *contentOpfParser = [[ContentXMLParser alloc] initWithFile:[self.booksDirectory stringByAppendingFormat:@"/%@", containerParser.rootFile]];
    [contentOpfParser parseXMLFile];
    
}

- (void)unZipEpub {
    NSLog(@"%@", self.booksDirectory);
    //Created the book directory
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    [fileManager createDirectoryAtPath:self.booksDirectory
           withIntermediateDirectories:NO
                            attributes:nil
                                 error:nil];
    
    ZipArchive* za = [[ZipArchive alloc] init];
    if ([za UnzipOpenFile:self.epubPath]) {
        BOOL ret = [za UnzipFileTo:self.booksDirectory overWrite:YES];
        if(ret == NO) {
            NSLog(@"error while unzipping epub");
        }
        [za UnzipCloseFile];
    }
}

@end
