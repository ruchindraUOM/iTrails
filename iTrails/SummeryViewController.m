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
    NSArray *_filteredFeedItems;
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
                 
                 int count=0;
                 for (int i = 0; i < _feedItems.count; i++)
                 {
                     NSLog(@"%@",[[_feedItems objectAtIndex: i] altitude]);
                     //NSLog(@"fetched user:%@", [result objectForKey:@"name"] );
                     
                     if([[result objectForKey:@"name"] isEqualToString:[[_feedItems objectAtIndex: i] name]] ){
                         
                         //[_filteredFeedItems addObject:[NSNumber numberWithDouble:0.12345]];
                         count++;
                         
                         
                     }
                     
                 }
                 
                 int iteration=0;
                 double speedArray[count];
                 double altitudeArray[count];
                 double latitudeArray[count];
                 double longitudeArray[count];
                 
                 for (int i = 0; i < _feedItems.count; i++)
                 {
                     //NSLog(@"%@",[[_feedItems objectAtIndex: i] name]);
                     //NSLog(@"fetched user:%@", [result objectForKey:@"name"] );
                     
                     if([[result objectForKey:@"name"] isEqualToString:[[_feedItems objectAtIndex: i] name]] ){
                         self.nameLabel.text=[result objectForKey:@"name"];
                         speedArray[iteration]=[[_feedItems objectAtIndex: i] currentSpeed].doubleValue;
                         altitudeArray[iteration]=[[_feedItems objectAtIndex: i] altitude].doubleValue;
                         latitudeArray[iteration]=[[_feedItems objectAtIndex: i] latitude].doubleValue;
                         longitudeArray[iteration]=[[_feedItems objectAtIndex: i] longitude].doubleValue;
                         
                         iteration++;
                     }
                     
                 }
                 NSLog(@"Maximum speed %f",[self getMaxSpeed:speedArray andSize:count]);
                 
                 self.maxSpeedLabel.text=[NSString stringWithFormat:@"%.2f ms", [self getMaxSpeed:speedArray andSize:count]];
                 ;
                 self.altitudeLabel.text=[NSString stringWithFormat:@"%.2f m", [self getPositiveltitude:altitudeArray andSize:count]];
                 ;
                 self.minSpeedLabel.text=[NSString stringWithFormat:@"%.2f ms", [self getMinSpeed:speedArray andSize:count]];
                 ;
                 
             }
         }];
    }

}

-(double) getMaxSpeed:(double []) input andSize:(int) size
{
    int    i;
    double max=0;
    
    
    for (i = 0; i < size; ++i)
    {
        if(input[i]>=max){
            max=input[i];
        }
    }
    
    return max;
}

-(double) getMinSpeed:(double []) input andSize:(int) size
{
    int    i;
    double min=1000;
    
    
    for (i = 0; i < size; ++i)
    {
        if(input[i]<=min){
            min=input[i];
        }
    }
    
    return min;
}


-(double) getPositiveltitude:(double []) input andSize:(int) size
{
    int    i;
    double altitude=0;
    
    
    for (i = 0; i < size; ++i)
    {
        altitude=altitude+input[i];
    }
    
    return altitude;
}

@end
