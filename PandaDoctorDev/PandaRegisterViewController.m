//
//  PandaRegisterViewController.m
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/7/21.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import "PandaRegisterViewController.h"
#import "PandaRPCInterface.h"

@interface PandaRegisterViewController ()

@end

@implementation PandaRegisterViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController.navigationBar setHidden:YES];
    
    _phoneNumber.delegate = self;
    _passwd.delegate = self;
    _confirmPasswd.delegate = self;
    
    _getVerifyCodeBtn.hidden = YES;
    _receiveVerifyCodeInfo.hidden = YES;
    
    [self useSecurityEntry:YES];
    
    
}

- (void)useSecurityEntry:(Boolean)use
{
    if (use) {
        _passwd.secureTextEntry = YES;
        _confirmPasswd.secureTextEntry = YES;
    }else{
        _passwd.secureTextEntry = NO;
        _confirmPasswd.secureTextEntry = NO;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y+32 - (self.view.frame.size.height - 216.0);//键盘高度216
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Back:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)getVerifyCodeAction:(UIButton *)sender {
}

- (IBAction)getPandaDoctorProtocl:(UIButton *)sender {
}

- (IBAction)submitRegister:(UIButton *)sender {
    NSLog(@"passwd = %@", _passwd.text);
    NSLog(@"confirm passwd = %@",_confirmPasswd.text);
    NSLog(@"phone = %@", _phoneNumber.text);
    if ([UtilTool validateMobile:_phoneNumber.text]) {
        NSLog(@"yes phone number");
    }else{
        NSLog(@"no!!!!");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"手机号输入错误"
                                                       message:@"请输入正确的手机号码"
                                                      delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    if (_passwd.text.length>19 || _passwd.text.length<6) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"密码输入错误"
                                                       message:@"密码长度错误"
                                                      delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if (_confirmPasswd.text.length>19 || _confirmPasswd.text.length<6) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"密码输入错误"
                                                       message:@"密码长度错误"
                                                      delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if (![_passwd.text isEqualToString:_confirmPasswd.text]  ) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"密码输入错误"
                                                       message:@"两次密码输入不同" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    PandaRPCInterface *rpcInterface = [[PandaRPCInterface alloc]init];
    NSMutableData *data = [rpcInterface registerForAPP:_phoneNumber.text passwd:_passwd.text confirm:_confirmPasswd.text];
    if (data==nil) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"网络错误"
                                                       message:@"联网错误, 请检查您的网络连接是否正常"
                                                      delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    NSString *result = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    if ([result  isEqualToString: @"true"]) {
        NSLog(@"register successful");
        UIStoryboard *storyBorad = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.view.window.rootViewController = [storyBorad instantiateInitialViewController];
    }else{
        NSLog(@"register failed");
        
    }
    
}

- (IBAction)backToLogin:(UIButton *)sender {
}
@end
