//
//  PandaHuaYanDanXiangMuListViewController.h
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/8/3.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PandaConstantData.h"
#import "PandaTableViewBaseCell.h"
#import "PandaHuaYanDanDetailViewController.h"

@interface PandaHuaYanDanXiangMuListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSInteger itemId;
@property NSMutableArray *tableViewItemList;

@property NSString *titleString;

@property PandaConstantData *huaYanDanConstData;

@property PandaHuaYanDanData *currentData;
@property PandaHuaYanDanDetailViewController *huaYanDanDetailViewController;


- (IBAction)back:(UIBarButtonItem *)sender;

@end
