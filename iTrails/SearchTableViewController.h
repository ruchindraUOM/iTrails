//
//  SearchTableViewController.h
//  iTrails
//
//  Created by Ruchindra Vithanage on 9/7/15.
//  Copyright (c) 2015 Ruchindra Vithanage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "searchModel.h"

@interface SearchTableViewController : UITableViewController <SearchModelProtocol>
@property (strong, nonatomic) IBOutlet UITableView *listTableView;

@end
