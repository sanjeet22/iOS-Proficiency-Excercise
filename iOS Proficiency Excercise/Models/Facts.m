//
//  Facts.m
//  iOS Proficiency Excercise
//
//  Created by Sanjeet on 1/11/17.
//  Copyright © 2017 Sanjeet. All rights reserved.
//

#import "Facts.h"

@implementation Facts

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
        self.screenTitle = [dictionary valueForKey:@"title"];
    }
    else {
        self.screenTitle = @"Fetching...";
    }
    
    if ([[dictionary valueForKey:@"rows"] isKindOfClass:[NSArray class]]) {
        NSMutableArray *arrTemp = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in [dictionary valueForKey:@"rows"]) {
            FactsRow *row = [[FactsRow alloc] initWithDictionary:dic];
            [arrTemp addObject:row];
        }
        
        self.factRows = [[NSArray alloc] initWithArray:(NSArray*)arrTemp];
    }
    else {
        
    }
    
    return YES;
}

@end
