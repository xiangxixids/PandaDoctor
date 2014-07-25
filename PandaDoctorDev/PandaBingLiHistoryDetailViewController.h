//
//  PandaBingLiHistoryDetailViewController.h
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/7/24.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PandaBingLiHistoryDetailTableViewCell.h"

@interface PandaBingLiHistoryDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
