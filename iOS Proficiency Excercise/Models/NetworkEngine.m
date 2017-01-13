//
//  NetworkEngine.m
//  iOS Proficiency Excercise
//
//  Created by Sanjeet on 1/11/17.
//  Copyright © 2017 Sanjeet. All rights reserved.
//

#import "NetworkEngine.h"

NSString *NE_FectsUrl = @"https://dl.dropboxusercontent.com/u/746330/facts.json";

@implementation NetworkEngine

+ (void)fetchDataWithCompletion:(NE_CompletionBlock)completionBlock
{
    NSURL *URL = [NSURL URLWithString:NE_FectsUrl]; //
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL]; // represent a URL load request
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration]; // Returns a newly created default session configuration object.
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config]; //Creates a session with the specified session configuration.
    
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSString *isoEncoding = [[NSString alloc] initWithData:data encoding:NSISOLatin1StringEncoding]; // NSISOLatin1StringEncoding-give the well result for character code of "ö"
        NSData *utfEncoding = [isoEncoding dataUsingEncoding:NSUTF8StringEncoding];   // encoding can the bytes of the NSData be interpreted as a valid string
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:utfEncoding options:NSJSONReadingMutableContainers error:&error];
                
        completionBlock(jsonDict, error);
    }];
    [dataTask resume];
}

@end
