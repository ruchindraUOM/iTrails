//
//  SummeryViewController.h
//  iTrails
//
//  Created by Ruchindra Vithanage on 9/6/15.
//  Copyright (c) 2015 Ruchindra Vithanage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

@interface SummeryViewController : UIViewController <HomeModelProtocol>
@property (weak, nonatomic) IBOutlet UILabel *minSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *altitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
- (IBAction)Save:(id)sender;
-(double)getMaxSpeed:(double []) input andSize:(int) size;

@end
