//
//  Constants.h
//  HandyBook
//
//  Created by User on 4/13/16.
//  Copyright © 2016 ACA. All rights reserved.
//

#ifndef Constants_h
#define Constants_h
#import "Word.h"


typedef void(^wordInfoComplitionHandler) (Word *);
typedef void(^dictWordsComplitionHandler) (NSArray *);


static NSString *const kEntityNameWord = @"Word";
static NSString *const kEntityNameBook = @"Book";

#endif /* Constants_h */
