//
//  PandaBingLiViewController.h
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/7/23.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PandaBingLiHistoryViewController.h"
#import "PandaDatagramViewController.h"
#import "PandaPersonalSettingViewController.h"
#import "PandaModifyPasswordViewController.h"

@interface PandaBingLiViewController : UIViewController

@property PandaBingLiHistoryViewController *bingliHistoryController;
@property PandaDatagramViewController *datagramController;
@property PandaPersonalSettingViewController *personalSettingController;
@property PandaModifyPasswordViewController *modifyPasswordController;

- (IBAction)showDataGram:(UIButton *)sender;
- (IBAction)showBingLiHistory:(UIButton *)sender;
- (IBAction)personalSetting:(UIButton *)sender;
- (IBAction)modifyPassword:(UIButton *)sender;

- (IBAction)LogOut:(UIBarButtonItem *)sender;


@end
