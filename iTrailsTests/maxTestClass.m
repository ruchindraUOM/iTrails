//
//  maxTestClass.m
//  iTrails
//
//  Created by Ruchindra Vithanage on 9/9/15.
//  Copyright (c) 2015 Ruchindra Vithanage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "SummeryViewController.h"

@interface maxTestClass : XCTestCase
    @property (nonatomic) SummeryViewController *vcToTest;
 
@end

@implementation maxTestClass

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.vcToTest = [[SummeryViewController alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}



- (void)testExample {
    // This is an example of a functional test case.
    double array[]={2,3,5,4,6};
    double max=[self.vcToTest getMaxSpeed:array andSize : 5];
    double expectedMax=6;
    
    XCTAssertEqual(expectedMax,max, @"Pass");
                          
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
