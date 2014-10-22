//
//  PandaSBBingLiHistoryViewController.h
//  PandaDoctorDev
//
//  Created by xiangxixids on 10/22/14.
//  Copyright (c) 2014 xiangxixids. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PandaBingLiHistoryDetailViewController.h"

@interface PandaSBBingLiHistoryViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property PandaBingLiHistoryDetailViewController *bingliDetailViewController;

@property NSArray *dataList;



@end
