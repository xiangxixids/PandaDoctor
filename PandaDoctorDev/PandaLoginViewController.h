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

@property (strong, nonatomic) IBOutlet UITextField *account;
@property (strong, nonatomic) IBOutlet UITextField *passwd;

@property (strong, nonatomic) IBOutlet UIButton *tabviewBtn;

- (IBAction)loginAction:(UIButton *)sender;

- (IBAction)showRegisterView:(UIButton *)sender;
- (IBAction)goToTabBiew:(UIButton *)sender;
@end
