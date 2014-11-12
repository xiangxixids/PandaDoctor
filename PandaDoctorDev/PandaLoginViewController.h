//
//  PandaLoginViewController.h
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/7/21.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PandaRegisterViewController.h"


@interface PandaLoginViewController : UIViewController<UITextFieldDelegate>

@property PandaRegisterViewController *registerViewController;
@property (weak, nonatomic) IBOutlet UIView *hiddenView;

@property (strong, nonatomic) IBOutlet UITextField *account;
@property (strong, nonatomic) IBOutlet UITextField *passwd;

@property (strong, nonatomic) IBOutlet UIButton *tabviewBtn;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorPopup;

@property (strong, nonatomic) IBOutlet UIView *loginView;

@property NSMutableData *data;
@property dispatch_source_t timer;
@property Boolean ayncThreadStop;
@property NSTimer *showTimer;

- (IBAction)loginAction:(UIButton *)sender;

- (IBAction)showRegisterView:(UIButton *)sender;
- (IBAction)goToTabBiew:(UIButton *)sender;
@end
