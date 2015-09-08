//
//  SummeryViewController.m
//  iTrails
//
//  Created by Ruchindra Vithanage on 9/6/15.
//  Copyright (c) 2015 Ruchindra Vithanage. All rights reserved.
//

#import "SummeryViewController.h"
#import "Location.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>


@interface SummeryViewController (){
    HomeModel *_homeModel;
    NSArray *_feedItems;
    Location *_selectedLocation;
}


@end

@implementation SummeryViewController

NSString *name=@"Ruchindra";
NSString *mail=@"roxz";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Create array object and assign it to _feedItems variable
    NSLog(@"Counting");
    _feedItems = [[NSArray alloc] init];
    
    // Create new HomeModel object and assign it to _homeModel variable
    _homeModel = [[HomeModel alloc] init];
    
    // Set this view controller object as the delegate for the home model object
    _homeModel.delegate = self;
    
    // Call the download items method of the home model object
    [_homeModel downloadItems];

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

-(void)itemsDownloaded:(NSArray *)items
{
    // This delegate method will get called when the items are finished downloading
    
    // Set the downloaded items to the array
    _feedItems = items;
    
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                      id result, NSError *error) {
             if (!error) {
                 NSLog(@"fetched user:%@", [result objectForKey:@"name"] );
                 
                 
                 for (int i = 0; i < _feedItems.count; i++)
                 {
                     NSLog(@"%@",[[_feedItems objectAtIndex: i] name]);
                     NSLog(@"fetched user:%@", [result objectForKey:@"name"] );
                     
                     if([[result objectForKey:@"name"] isEqualToString:[[_feedItems objectAtIndex: i] name]] ){
                         
                         
                     }
                     
                 }
                 
                 
             }
         }];
    }

}

@end
