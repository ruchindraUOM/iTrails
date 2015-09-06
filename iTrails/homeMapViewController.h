//
//  homeMapViewController.h
//  iTrails
//
//  Created by Ruchindra Vithanage on 9/5/15.
//  Copyright (c) 2015 Ruchindra Vithanage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface homeMapViewController : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property(nonatomic, retain) CLLocationManager *locationManager;

@end
