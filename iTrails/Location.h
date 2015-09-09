//
//  Location.h
//  myFirstIApp
//
//  Created by Ruchindra Vithanage on 7/25/15.
//  Copyright (c) 2015 Ruchindra Vithanage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject

@property (nonatomic, strong) NSDecimalNumber *latitude;
@property (nonatomic, strong) NSDecimalNumber *longitude;
@property (nonatomic, strong) NSDecimalNumber *altitude;
@property (nonatomic, strong) NSDecimalNumber *currentSpeed;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *time;

@end
