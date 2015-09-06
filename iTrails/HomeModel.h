//
//  HomeModel.h
//  myFirstIApp
//
//  Created by Ruchindra Vithanage on 7/25/15.
//  Copyright (c) 2015 Ruchindra Vithanage. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HomeModelProtocol <NSObject>

- (void)itemsDownloaded:(NSArray *)items;

@end

@interface HomeModel : NSObject

@property (nonatomic, weak) id<HomeModelProtocol> delegate;

- (void)downloadItems;

@end
