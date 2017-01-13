//
//  NetworkEngine.h
//  iOS Proficiency Excercise
//
//  Created by Sanjeet on 1/11/17.
//  Copyright © 2017 Sanjeet. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^NE_CompletionBlock)(NSDictionary * response, NSError *error);

@interface NetworkEngine : NSObject

+ (void)fetchDataWithCompletion:(NE_CompletionBlock)completionBlock;

@end
