//
//  PandaBingLiViewController.h
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/7/23.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PandaBingLiHistoryViewController.h"

@interface PandaBingLiViewController : UIViewController

@property PandaBingLiHistoryViewController *bingliHistoryController;


- (IBAction)showBingLiHistory:(UIButton *)sender;
@end
