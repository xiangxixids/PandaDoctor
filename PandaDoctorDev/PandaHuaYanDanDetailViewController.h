//
//  PandaHuaYanDanDetailViewController.h
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/8/5.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PandaBingLiHistoryTableViewCell.h"
#import "PandaTakePhotoPreviewViewController.h"

@interface PandaHuaYanDanDetailViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

@property (weak, nonatomic) IBOutlet UILabel *meaningTitle;

@property (weak, nonatomic) IBOutlet UITextView *description;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property PandaTakePhotoPreviewViewController *takePhotoPreviewViewController;


- (IBAction)back:(UIBarButtonItem *)sender;

- (IBAction)takePhoto:(UIBarButtonItem *)sender;


@end
