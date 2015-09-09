//
//  advancedSearchModel.m
//  iTrails
//
//  Created by Ruchindra Vithanage on 9/8/15.
//  Copyright (c) 2015 Ruchindra Vithanage. All rights reserved.
//

#import "advancedSearchModel.h"
#import "Location.h"

@interface advancedSearchModel()
{
    NSMutableData *_downloadedData;
}
@end

@implementation advancedSearchModel

- (void)downloadItems
{
    
    NSLog(@"Searching data");
    NSString *name=@"Ruchindra Vithanage";
    
    NSString *noteDataString = [NSString stringWithFormat:@"ID=%@",name];
    //NSString *noteDataString = [NSString stringWithFormat:@"Name='res'&Mail='hfh'"];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:@"http://localhost:8888/Iphone/searchTest.php"];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"GET"];
    [urlRequest setHTTPBody:[noteDataString dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Create the NSURLConnection
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
    
}

#pragma mark NSURLConnectionDataProtocol Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // Initialize the data object
    _downloadedData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the newly downloaded data
    [_downloadedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Create an array to store the locations
    NSMutableArray *_locations = [[NSMutableArray alloc] init];
    
    // Parse the JSON that came in
    NSError *error;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:_downloadedData options:NSJSONReadingAllowFragments error:&error];
    
    // Loop through Json objects, create question objects and add them to our questions array
    for (int i = 0; i < jsonArray.count; i++)
    {
        NSDictionary *jsonElement = jsonArray[i];
        
        // Create a new location object and set its props to JsonElement properties
        Location *newLocation = [[Location alloc] init];
        newLocation.name = jsonElement[@"Name"];
        newLocation.latitude=jsonElement[@"latitude"];
        newLocation.longitude=jsonElement[@"longitude"];
        
        NSLog(@"%@",jsonElement[@"Name"]);
        NSLog(@"%@",jsonElement[@"latitude"]);
        NSLog(@"%@",jsonElement[@"longitude"]);
        
        if (self.delegate)
        {
            NSLog(@"Finished");
            [self.delegate itemsDownloaded:_locations];
        }
        
        // Add this question to the locations array
        [_locations addObject:newLocation];
        
        
    }
    
}

@end
