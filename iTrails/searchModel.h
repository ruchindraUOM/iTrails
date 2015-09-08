//
//  searchModel.h
//  iTrails
//
//  Created by Ruchindra Vithanage on 9/7/15.
//  Copyright (c) 2015 Ruchindra Vithanage. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SearchModelProtocol <NSObject>

- (void)itemsDownloaded:(NSArray *)items;

@end

@interface searchModel : NSObject

@property (nonatomic, weak) id<SearchModelProtocol> delegate;

- (void)downloadItems;

@end
