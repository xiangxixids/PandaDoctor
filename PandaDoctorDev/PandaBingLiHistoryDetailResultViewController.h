//
//  PandaBingLiHistoryDetailResultViewController.h
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/7/29.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PandaBingLiHistoryDetailResultViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *resultView;

@property NSData *data;
@property NSString *SLB_ID;
@property NSString *result;

- (IBAction)back:(UIBarButtonItem *)sender;
@end
