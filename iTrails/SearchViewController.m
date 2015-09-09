//
//  SearchViewController.m
//  iTrails
//
//  Created by Ruchindra Vithanage on 9/7/15.
//  Copyright (c) 2015 Ruchindra Vithanage. All rights reserved.
//

#import "SearchViewController.h"
#import "homeModel.h"
#import "Location.h"


@interface SearchViewController (){
    HomeModel *_homeModel;
    NSArray *_feedItems;
    Location *_selectedLocation;
}
@end

@implementation SearchViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        NSLog(@"Counting");
    NSLog(@"Slelected location %@",_selectedLocation.name);
    
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

-(void)itemsDownloaded:(NSArray *)items
{
    // This delegate method will get called when the items are finished downloading
    
    // Set the downloaded items to the array
    _feedItems = items;
    
    for (int i = 0; i < _feedItems.count; i++)
    {
        NSLog(@"Finally %@",[[_feedItems objectAtIndex: i] longitude]);
        NSLog(@"Finally %@",[[_feedItems objectAtIndex: i] latitude]);
        
        double latitudeDiff=(_selectedLocation.latitude).doubleValue-[[_feedItems objectAtIndex: i] latitude].doubleValue;
        double longitudeDiff=(_selectedLocation.latitude).doubleValue-[[_feedItems objectAtIndex: i] longitude].doubleValue;

        
        if(fabs(latitudeDiff)<0.05 || fabs(longitudeDiff)<0.05){
            
            MKPointAnnotation *pin;
            pin = [[MKPointAnnotation alloc] init];
            CLLocationCoordinate2D poiCoodinates;
            poiCoodinates.latitude=[[_feedItems objectAtIndex: i] latitude].doubleValue;
            poiCoodinates.longitude=[[_feedItems objectAtIndex: i] longitude].doubleValue;
            // Zoom to region
            MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(poiCoodinates,0,0);
            
            [self.mapView setRegion:viewRegion animated:YES];
            
            // Plot pin
            
            pin.coordinate = poiCoodinates;
            [self.mapView addAnnotation:pin];
        }
        
        
    }

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
