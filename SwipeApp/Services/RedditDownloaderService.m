//
//  RedditDownloaderService.m
//  SwipeApp
//
//  Created by Daniel Judd on 3/11/15.
//  Copyright (c) 2015 swipe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RedditDownloaderService.h"

@interface RedditDownloaderService ()

@end

@implementation RedditDownloaderService

+ (NSArray*) downloadMessagesFromReddit {
    NSArray *results = [[NSArray alloc] init];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.reddit.com/r/pics.json"]];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:urlRequest
                                          returningResponse:&response
                                                      error:&error];
    
    if (error == nil)
    {
        NSError* error;
        NSDictionary* jsonDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                             options:kNilOptions
                                                               error:&error];
        NSArray *itemsToParseAndDownload = [[jsonDictionary objectForKey:@"data"] objectForKey:@"children"];
        for 
        NSLog (itemsToParseAndDownload.description);
    }
    
    
    return results;
}
@end

