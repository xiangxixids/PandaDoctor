//
//  PandaHuaYanDanDetailViewController.h
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/8/5.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PandaBingLiHistoryTableViewCell.h"
#import "PandaHuaYanDanDetailTableViewCell.h"
#import "PandaTakePhotoPreviewViewController.h"
#import "PandaRPCInterface.h"

@interface PandaHuaYanDanDetailViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

@property (weak, nonatomic) IBOutlet UILabel *meaningTitle;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *btnTakePhoto;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barItemTakePhoto;

@property PandaTakePhotoPreviewViewController *takePhotoPreviewViewController;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorPop;
@property Boolean ayncThreadStop;
@property NSTimer *showTimer;
@property NSMutableData *data;

@property NSInteger checkItemId;
@property NSString *titleName;
@property NSString *isOCR;

@property NSArray *tableViewDataList;


- (IBAction)back:(UIBarButtonItem *)sender;

- (IBAction)takePhoto:(UIBarButtonItem *)sender;

- (IBAction)takePic:(UIButton *)sender;

@end
