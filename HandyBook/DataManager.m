//
//  DataManager.m
//  HandyBook
//
//  Created by User on 4/13/16.
//  Copyright © 2016 ACA. All rights reserved.
//

#import "DataManager.h"
#import "Word.h"
#import "Book.h"

@interface DataManager ()


@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic) dispatch_queue_t queue;

@end


@implementation DataManager

+ (instancetype)sharedManager {
    static DataManager *instance;
    static dispatch_once_t token2;
    dispatch_once(&token2, ^{
        instance = [[DataManager alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.context = [[UIApplication appDelegate] managedObjectContext];
        self.queue = dispatch_queue_create("contextQueue", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}


- (void)insertBookWithName:(NSString *)name
                      text:(NSString *)text
                coverImage:(UIImage *)image {
    
}


- (void)insertWordInCoreData:(NSString *)word
             withTranslation:(NSString *)Translation {
    
    dispatch_async(self.queue, ^{
        
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:kEntityNameWord];
        [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"unknownWord == %@", word]];
        if ([self.context countForFetchRequest:fetchRequest error:nil] == 0) {
            
            Word *unknownWord = [NSEntityDescription insertNewObjectForEntityForName:kEntityNameWord
                                                              inManagedObjectContext:self.context];
            unknownWord.unknownWord = word;
            unknownWord.translation = Translation;
            
        }
        
        [[UIApplication appDelegate] saveContext];
        
    });
    
}

- (void)deleteWord:(Word *)word {
    dispatch_async(self.queue, ^{
        [self.context deleteObject:word];
        [[UIApplication appDelegate] saveContext];
    });
}


- (void)infoForWord:(NSString *)word
  complitionHandler:(wordInfoComplitionHandler)complitionHandler {
    dispatch_async(self.queue, ^{
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:kEntityNameWord];
        [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"unknownWord == %@", word]];
        Word *word = [self.context executeFetchRequest:fetchRequest error:nil][0];
        dispatch_async(dispatch_get_main_queue(), ^{
            complitionHandler(word);
        });
    });
}


- (void)dictionaryWordsWithComplitionHandler:(dictWordsComplitionHandler)complitionHandler {
    dispatch_async(self.queue, ^{
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:kEntityNameWord];
        [fetchRequest setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"unknownWord" ascending:YES]]];
        NSArray *words = [self.context executeFetchRequest:fetchRequest error:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            complitionHandler(words);
        });

    });
}


@end
