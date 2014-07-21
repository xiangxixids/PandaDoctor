//
//  PandaViewController.h
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/7/13.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PandaViewController : UIViewController

@property (strong, nonatomic)UIToolbar *toolbar;
//@property (strong, nonatomic)
@property (strong, nonatomic)UINavigationBar *bar;

-(IBAction)action:(UIBarButtonItem *)sender;

@end
