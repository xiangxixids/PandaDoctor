//
//  PandaRegisterViewController.h
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/7/21.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UtilTool.h"

@interface PandaRegisterViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *phoneNumber;
@property (strong, nonatomic) IBOutlet UITextField *passwd;
@property (strong, nonatomic) IBOutlet UITextField *confirmPasswd;

@property (strong, nonatomic) IBOutlet UIButton *getVerifyCodeBtn;
@property (strong, nonatomic) IBOutlet UILabel *receiveVerifyCodeInfo;



- (IBAction)Back:(UIBarButtonItem *)sender;
- (IBAction)getVerifyCodeAction:(UIButton *)sender;
- (IBAction)getPandaDoctorProtocl:(UIButton *)sender;
- (IBAction)submitRegister:(UIButton *)sender;
- (IBAction)backToLogin:(UIButton *)sender;
- (IBAction)backByButton:(UIButton *)sender;

@end
