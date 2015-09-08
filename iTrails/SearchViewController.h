//
//  SearchViewController.h
//  iTrails
//
//  Created by Ruchindra Vithanage on 9/7/15.
//  Copyright (c) 2015 Ruchindra Vithanage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
#import "Location.h"
#import <MapKit/MapKit.h>

@interface SearchViewController : UIViewController <HomeModelProtocol>
@property (strong, nonatomic) Location *selectedLocation;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
