//
//  AppDelegate.h
//  HandyBook
//
//  Created by User on 4/7/16.
//  Copyright © 2016 ACA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#include "HBConstants.h"

@class AppDelegate;

@interface UIApplication (Additions)

+ (AppDelegate *)appDelegate;

@end



@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;




@end