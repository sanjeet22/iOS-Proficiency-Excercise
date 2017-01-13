//
//  Facts.h
//  iOS Proficiency Excercise
//
//  Created by Sanjeet on 1/11/17.
//  Copyright © 2017 Sanjeet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FactsRow.h"

@interface Facts : NSObject

@property (strong, nonatomic) NSString *screenTitle;
@property (strong, nonatomic) NSArray *factRows;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
