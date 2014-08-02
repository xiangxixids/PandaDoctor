//
//  PandaHealthJiangTangViewController.h
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/8/2.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollTableViewCell.h"
#import "PandaShareTableViewCell.h"
#import "PandaHealthJiangTangDetailViewController.h"

@interface PandaHealthJiangTangViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *switchSegment;

@property PandaHealthJiangTangDetailViewController *jiangtangDetailViewController;



@end
