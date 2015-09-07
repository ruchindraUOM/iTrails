//
//  HistoryViewController.h
//  iTrails
//
//  Created by Ruchindra Vithanage on 9/5/15.
//  Copyright (c) 2015 Ruchindra Vithanage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
#import <MapKit/MapKit.h>


@interface HistoryViewController : UIViewController <HomeModelProtocol>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
