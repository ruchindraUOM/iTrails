//
//  HomeModel.m
//  myFirstIApp
//
//  Created by Ruchindra Vithanage on 7/25/15.
//  Copyright (c) 2015 Ruchindra Vithanage. All rights reserved.
//

#import "HomeModel.h"
#import "Location.h"

@interface HomeModel()
{
    NSMutableData *_downloadedData;
}
@end

@implementation HomeModel

- (void)downloadItems
{
    // Download the json file
    NSURL *jsonFileUrl = [NSURL URLWithString:@"http://localhost:8888/Iphone/Service.php"];
    
    // Create the request
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:jsonFileUrl];
    
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
        newLocation.name = jsonElement[@"userID"];
        newLocation.latitude=jsonElement[@"latitude"];
        newLocation.longitude=jsonElement[@"longitude"];
        newLocation.speed=jsonElement[@"speed"];
        
        NSLog(@"%@",jsonElement[@"userID"]);
        NSLog(@"%@",jsonElement[@"latitude"]);
        NSLog(@"%@",jsonElement[@"longitude"]);
        NSLog(@"%@",jsonElement[@"speed"]);
        NSLog(@"%@",jsonElement[@"altitude"]);
        
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
