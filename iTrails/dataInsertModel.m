//
//  dataInsertModel.m
//  iTrails
//
//  Created by Ruchindra Vithanage on 9/6/15.
//  Copyright (c) 2015 Ruchindra Vithanage. All rights reserved.
//

#import "Location.h"
#import "dataInsertModel.h"

@implementation dataInsertModel

void insertData(Location *locationData){

    NSLog(@"Inserting data");
    NSString *noteDataString = [NSString stringWithFormat:@"ID=%@&lat=%@&long=%@&speed=%@&altitude=%@",locationData.name,locationData.latitude,locationData.longitude,locationData.speed,locationData.altitude];
    //NSString *noteDataString = [NSString stringWithFormat:@"Name='res'&Mail='hfh'"];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:@"http://localhost:8888/Iphone/ServiceInsert.php"];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[noteDataString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog(@"%@",[noteDataString dataUsingEncoding:NSUTF8StringEncoding]);
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *dataRaw, NSURLResponse *header, NSError *error) {
        NSDictionary *json = [NSJSONSerialization
                              JSONObjectWithData:dataRaw
                              options:kNilOptions error:&error];
        NSString *status = json[@"status"];
        
        if([status isEqual:@"1"]){
            //Success
            NSLog(@"Success %@",status);
            
        } else {
            //Error
            NSLog(@"Error %@",status);
            
        }
    }];
    
    [dataTask resume];
}

@end
