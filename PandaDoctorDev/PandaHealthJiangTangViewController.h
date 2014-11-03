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
#import "PullRefreshTableViewController.h"
@interface PandaHealthJiangTangViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
//@interface PandaHealthJiangTangViewController : PullRefreshTableViewController<UITableViewDataSource, UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *switchSegment;

@property NSArray *articleList;
@property NSArray *itemList;

@property NSMutableArray *tech;
@property NSMutableArray *cure;
@property NSMutableArray *expert;
@property NSMutableArray *life;
@property NSMutableArray *news;

@property PandaHealthJiangTangDetailViewController *jiangtangDetailViewController;


- (IBAction)switchArticle:(UISegmentedControl *)sender;

@end
