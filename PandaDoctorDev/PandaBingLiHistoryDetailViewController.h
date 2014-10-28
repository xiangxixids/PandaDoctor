//
//  PandaBingLiHistoryDetailViewController.h
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/7/24.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PandaBingLiHistoryDetailTableViewCell.h"
#import "PandaBingLiHistoryDetailResultViewController.h"

@interface PandaBingLiHistoryDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property PandaBingLiHistoryDetailResultViewController *bingliHistoryResultViewController;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property NSString *checkItem; // checkItem
@property NSString *result; //  0,0,1,0,1,0,0,0,0,0,0,0,0

@property NSArray *tableViewDataList;

@property NSArray *checkArray; //[result replace by ,]

- (IBAction)showResult:(UIBarButtonItem *)sender;

- (IBAction)back:(UIBarButtonItem *)sender;
@end
