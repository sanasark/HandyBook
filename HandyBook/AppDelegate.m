//
//  AppDelegate.m
//  HandyBook
//
//  Created by User on 4/7/16.
//  Copyright © 2016 ACA. All rights reserved.
//

#import "AppDelegate.h"
#import "ZipArchive.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSString *handyBook = @"/Users/user/Desktop/ios apps/HandyBook/HandyBook/prestuplenie_i_nakazanie.epub";
    
    // Unzipped file
    [self unZipEpub:handyBook];
    // Open
    //NSFileManager *fileManager = [[NSFileManager alloc] init];
    return YES;
    
}

- (void)unZipEpub:(NSString *)epub {
    NSString *currentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSLog(@"%@",currentDirectory);
    ZipArchive* za = [[ZipArchive alloc] init];
    if ([za UnzipOpenFile: epub]) {
        BOOL ret = [za UnzipFileTo:currentDirectory overWrite:YES];
        if(ret == NO) {
            NSLog(@"error");
        }
        [za UnzipCloseFile];
    }
    

}

@end
