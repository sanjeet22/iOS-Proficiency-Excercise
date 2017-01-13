//
//  FactsRow.m
//  iOS Proficiency Excercise
//
//  Created by Sanjeet on 1/11/17.
//  Copyright © 2017 Sanjeet. All rights reserved.
//

#import "FactsRow.h"

@implementation FactsRow

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        if(![self setPropertiesWithDictionary:dictionary]) {
            self = nil;
        }
    }
    return self;
}

- (BOOL)setPropertiesWithDictionary:(NSDictionary *)dictionary {
    
    // This check was added to detect NSNull
    if (![dictionary isKindOfClass:[NSDictionary class]]) {
        return NO;
    }
    
    if ([dictionary valueForKey:@"title"] != [NSNull null] &&
        [dictionary valueForKey:@"title"] != nil) {
        self.titleText = [dictionary valueForKey:@"title"];
    }
    else {
        self.titleText = @"";
    }
    
    if ([dictionary valueForKey:@"description"] != [NSNull null] &&
        [dictionary valueForKey:@"description"] != nil) {
        self.descriptionText = [dictionary valueForKey:@"description"];
    }
    else {
        self.descriptionText = @"";
    }
    
    if ([dictionary valueForKey:@"imageHref"] != [NSNull null] &&
        [dictionary valueForKey:@"imageHref"] != nil) {
        self.imageUrl = [dictionary valueForKey:@"imageHref"];
    }
    else {
        self.imageUrl = @"";
    }
    
    return YES;
}

@end
