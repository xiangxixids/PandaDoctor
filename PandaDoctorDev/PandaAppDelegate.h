//
//  PandaAppDelegate.h
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/7/13.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PandaViewController.h"
#import "PandaLoginViewController.h"

@interface PandaAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) PandaViewController *mainViewController;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) PandaLoginViewController *loginViewController;

@end
