//
//  PandaBingLiHistoryViewController.h
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/7/23.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PandaBingLiHistoryTableViewCell.h"

@interface PandaBingLiHistoryViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)back:(UIBarButtonItem *)sender;
@end
