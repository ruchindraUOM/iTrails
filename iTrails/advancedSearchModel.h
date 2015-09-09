//
//  advancedSearchModel.h
//  iTrails
//
//  Created by Ruchindra Vithanage on 9/8/15.
//  Copyright (c) 2015 Ruchindra Vithanage. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SearchModelProtocol <NSObject>
- (void)itemsDownloaded:(NSArray *)items;
@end

@interface advancedSearchModel : NSObject

@property (nonatomic, weak) id<SearchModelProtocol> delegate;

- (void)downloadItems;


@end
