//
//  Location.h
//  myFirstIApp
//
//  Created by Ruchindra Vithanage on 7/25/15.
//  Copyright (c) 2015 Ruchindra Vithanage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject

@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *altitude;
@property (nonatomic, strong) NSString *speed;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *address;

@end
