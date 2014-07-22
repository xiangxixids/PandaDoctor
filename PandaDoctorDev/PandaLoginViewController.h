//
//  PandaLoginViewController.h
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/7/21.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PandaRegisterViewController.h"
#import "PandaTabViewController.h"

@interface PandaLoginViewController : UIViewController

@property PandaRegisterViewController *registerViewController;
@property PandaTabViewController *tabViewController;

- (IBAction)showRegisterView:(UIButton *)sender;
- (IBAction)goToTabBiew:(UIButton *)sender;
@end
