//
//  PandaHuaYanDanRadioCheckViewController.h
//  PandaDoctorDev
//
//  Created by xiangxixids on 10/18/14.
//  Copyright (c) 2014 xiangxixids. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PandaHuaYanDanRadioCheckViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSInteger checkItemId;
@property NSArray *dataList;
@property NSMutableArray *postArray;


- (IBAction)back:(UIBarButtonItem *)sender;

- (IBAction)confirm:(UIBarButtonItem *)sender;
- (IBAction)confirmByBtn:(UIButton *)sender;

@end
