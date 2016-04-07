//
//  YandexTranslateManager.m
//  HandyBook
//
//  Created by User on 4/7/16.
//  Copyright © 2016 ACA. All rights reserved.
//

#import "YandexTranslateManager.h"


@interface YandexTranslateManager ()

@property (nonatomic, strong) NSURLSession *session;

@end

@implementation YandexTranslateManager

+ (instancetype)sharedManager {
    static YandexTranslateManager *instance;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        instance = [[YandexTranslateManager alloc] init];
    });
    return instance;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    return self;
}

- (NSString *)translateText:(NSString *)text toLanguage:(NSString *)language completionHandler:(TranslateCompletionHandler)completionHandler {
    
    NSMutableString *urlStr = [NSMutableString stringWithFormat:@"https://translate.yandex.net/api/v1.5/tr.json/translate"];
    
    NSString *key = @"trnsl.1.1.20160405T150622Z.a33c10976a82939b.c48e75dcad431a994c97a71051c071d81b19e57c";
    
    [urlStr appendString:[NSString stringWithFormat:@"?key=%@&text=%@&lang=%@&option=1",key,[text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]],language]];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLSessionDataTask *task = [self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse * response, NSError *error) {
        NSDictionary *dict = nil;
        if (!error) {
            switch ([(NSHTTPURLResponse *)response statusCode]) {
                case 200:
                {
                    dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    break;
                    
                }
                default:
                    break;
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler([[dict objectForKey:@"text"] objectAtIndex:0],nil);
        });
    }];
    [task resume];
    return nil;
    
}




@end
