//
//  homeMapViewController.m
//  iTrails
//
//  Created by Ruchindra Vithanage on 9/5/15.
//  Copyright (c) 2015 Ruchindra Vithanage. All rights reserved.
//

#import "homeMapViewController.h"
#import "Location.h"
#import "dataInsertModel.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface homeMapViewController ()

@end

@implementation homeMapViewController

double lattitude;
double longitude;
double altitude;
double speed;
dataInsertModel *dataModelInsert;

NSTimer *timer;
MKPointAnnotation *pin;

- (void)viewDidLoad {
    [super viewDidLoad];
    pin = [[MKPointAnnotation alloc] init];
    dataModelInsert=[[dataInsertModel alloc] init];
    
    // Do any additional setup after loading the view.
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)timerFired{
    [timer invalidate];
    timer = nil;
    [self.locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    [self.mapView removeAnnotation:pin];
    if (currentLocation != nil) {
        NSLog(@"%f",currentLocation.coordinate.latitude);
        NSLog(@"%f",currentLocation.coordinate.longitude);
        
        // Create coordinates from location lat/long
        CLLocationCoordinate2D poiCoodinates;
        poiCoodinates = currentLocation.coordinate;
        
        // Zoom to region
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(poiCoodinates, 0, 0);
        
        [self.mapView setRegion:viewRegion animated:YES];
        
        // Plot pin
        
        pin.coordinate = poiCoodinates;
        [self.mapView addAnnotation:pin];
    
        Location *LocationData;
        
    
            LocationData= [[Location alloc] init];
            
            if ([FBSDKAccessToken currentAccessToken]) {
                [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
                 startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                              id result, NSError *error) {
                     if (!error) {
                         NSLog(@"fetched user:%@", [result objectForKey:@"name"] );
                         LocationData.name=[result objectForKey:@"name"];
                         NSLog(@"name of the user %@",LocationData.name);
                         
                         
                         LocationData.longitude=(NSDecimalNumber *)[NSDecimalNumber numberWithDouble:[currentLocation coordinate].longitude ];
                         LocationData.latitude=(NSDecimalNumber *)[NSDecimalNumber numberWithDouble:[currentLocation coordinate].latitude ];
                         LocationData.speed=(NSDecimalNumber *)[NSDecimalNumber numberWithDouble:currentLocation.speed ];
                         LocationData.altitude=(NSDecimalNumber *)[NSDecimalNumber numberWithDouble:currentLocation.altitude ];
                         
                         
                         //[dataModelInsert insertData:LocationData];
                         
                         NSLog(@"Inserting data");
                         NSString *noteDataString = [NSString stringWithFormat:@"ID=%@&lat=%@&long=%@&speed=%@&altitude=%@",LocationData.name,LocationData.latitude,LocationData.longitude,LocationData.speed,LocationData.altitude];
                         
                         NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
                         NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
                         
                         NSURL * url = [NSURL URLWithString:@"http://localhost:8888/Iphone/insert.php"];
                         NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url];
                         [urlRequest setHTTPMethod:@"POST"];
                         [urlRequest setHTTPBody:[noteDataString dataUsingEncoding:NSUTF8StringEncoding]];
                         
                         //NSLog(@"%@",[noteDataString dataUsingEncoding:NSUTF8StringEncoding]);
                         
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
                 }];
            }

        
        

        }
    
        [self.locationManager stopUpdatingLocation];
        timer = [NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(timerFired) userInfo:nil repeats:NO];
}


// Location Manager Delegate Methods


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
