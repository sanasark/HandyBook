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
#import "BookSectionXMLParser.h"
#import "Book.h"
#import "AppDelegate.h"
#import "TextManager.h"

@interface EpubReader()

@property NSString *epubPath;
@property NSMutableString *epubContent;
@property NSString *epubCoverImagePath;
@property NSString *epubName;

@property NSString *booksDirectory;

@end

@implementation EpubReader

- (id)initWithEpub:(NSString *)path {
    if (self = [super init]) {
        self.epubPath = path;
        self.epubName = [[self.epubPath lastPathComponent] stringByDeletingPathExtension];
        self.epubContent = [@"" mutableCopy];
        NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        self.booksDirectory = [documentsDirectory stringByAppendingString:[NSString stringWithFormat:@"/%@", self.epubName]];
    }
    return self;
}

- (Book *)readEpub {
    [self unZipEpub];
    //parse Container.xml to get content.opf path
    ContainerXMLParser *containerParser = [[ContainerXMLParser alloc] initWithFile:[self.booksDirectory stringByAppendingString:@"/META-INF/container.xml"]];
    [containerParser parseXMLFile];
    //parse Content.opf
    ContentXMLParser *contentOpfParser = [[ContentXMLParser alloc] initWithFile:[self.booksDirectory stringByAppendingFormat:@"/%@", containerParser.rootFile]];
    [contentOpfParser parseXMLFile];
    
    
    for (NSString *contentFilePath in contentOpfParser.bookContentFilePaths) {
        
        BookSectionXMLParser *sectionParser = [[BookSectionXMLParser alloc] initWithFile:[self.booksDirectory stringByAppendingFormat:@"/%@/%@", [containerParser.rootFile stringByDeletingLastPathComponent], contentFilePath]];
        [sectionParser parseXMLFile];
        [self.epubContent appendString:sectionParser.sectionContent];
    }
    
    NSManagedObjectContext *context = [[UIApplication appDelegate] managedObjectContext];
    Book *book = [NSEntityDescription insertNewObjectForEntityForName:kEntityNameBook inManagedObjectContext:context];
    
    [book setPath:self.epubPath
      bookContent:self.epubContent
   coverImagePath:[self.epubName stringByAppendingFormat:@"/%@",contentOpfParser.coverImagePath]
            title:contentOpfParser.bookTitle
           author:contentOpfParser.bookCreator
  bookDescription:contentOpfParser.bookDescription];
    
    //[TextManager sharedManager].epubText = self.epubContent;
    
    [[UIApplication appDelegate] saveContext];
    return book;
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
