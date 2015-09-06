//
//  SummeryViewController.m
//  iTrails
//
//  Created by Ruchindra Vithanage on 9/6/15.
//  Copyright (c) 2015 Ruchindra Vithanage. All rights reserved.
//

#import "SummeryViewController.h"

@interface SummeryViewController ()

@end

@implementation SummeryViewController

NSString *name=@"Ruchindra";
NSString *mail=@"roxz";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Save:(id)sender {
    NSLog(@"Button clicked");
    
    NSString *noteDataString = [NSString stringWithFormat:@"Name=%@&Mail=%@", name, mail];
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
