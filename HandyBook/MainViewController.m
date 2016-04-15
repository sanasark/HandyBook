//
//  MainViewController.m
//  HandyBook
//
//  Created by User on 4/7/16.
//  Copyright © 2016 ACA. All rights reserved.
//

#import "MainViewController.h"
#import "YandexTranslateManager.h"
#import "EpubXMLFilesParser.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[YandexTranslateManager sharedManager] translateText:@"Hello" toLanguage:@"fr" completionHandler:^(NSString *translation, NSError *error) {
        
        NSLog(@"%@",translation);
        
    }];
    
    EpubXMLFilesParser *parser = [[EpubXMLFilesParser alloc] initWithFile:[NSString stringWithFormat:@"%@/META-INF/container.xml", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]] ];
    [parser parseXMLFile];
    
    
}
- (IBAction)goToDictionary:(id)sender {
    MainViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Dictionary"];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
