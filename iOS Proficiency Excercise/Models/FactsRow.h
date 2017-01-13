//
//  FactsRow.h
//  iOS Proficiency Excercise
//
//  Created by Sanjeet on 1/11/17.
//  Copyright © 2017 Sanjeet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FactsRow : NSObject

@property (strong, nonatomic) NSString *titleText;
@property (strong, nonatomic) NSString *descriptionText;
@property (strong, nonatomic) NSString *imageUrl;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
