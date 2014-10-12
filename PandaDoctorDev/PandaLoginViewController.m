//
//  PandaLoginViewController.m
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/7/21.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import "PandaLoginViewController.h"
#import "PandaRPCInterface.h"
#import "UtilTool.h"

@interface PandaLoginViewController ()

@end

@implementation PandaLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
    _account.delegate = self;
    _passwd.delegate = self;
    _passwd.secureTextEntry = YES;
    
    _tabviewBtn.hidden = YES;
    
    _hiddenView.hidden = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginAction:(UIButton *)sender {
    
//    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(loginActionSY) object:nil];
//    _hiddenView.hidden = NO;
//    [_indicatorPopup startAnimating];
//    [thread start];
    PandaRPCInterface *rpcInterface = [[PandaRPCInterface alloc]init];
    NSMutableData *data = [rpcInterface loginForAPP:_account.text passwd:_passwd.text];
    NSString *result = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    if ([result  isEqualToString: @"true"]) {
        NSLog(@"login successful");
        
        [UtilTool globalDataSave:_account.text forKey:PHONE];
        
        UIStoryboard *storyBorad = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.view.window.rootViewController = [storyBorad instantiateInitialViewController];
    }else{
        NSLog(@"login failed");
        
    }
    
}

- (void)loginActionSY
{
    
    PandaRPCInterface *rpcInterface = [[PandaRPCInterface alloc]init];
    
    NSMutableData *data = [rpcInterface loginForAPP:_account.text passwd:_passwd.text];
    
    NSString *result = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    [_indicatorPopup stopAnimating];
    
    if ([result  isEqualToString: @"true"]) {
        NSLog(@"login successful");
        [UtilTool globalDataSave:_account.text forKey:PHONE];
        UIStoryboard *storyBorad = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            self.view.window.rootViewController = [storyBorad instantiateInitialViewController];
    }else{
        NSLog(@"login failed");
        [self performSelectorOnMainThread:@selector(loginActionFinish) withObject:nil waitUntilDone:YES];
    }
}

- (void)loginActionFinish
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"登录失败" message:@"请检查用户名和密码是否正确" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [_indicatorPopup stopAnimating];
    _hiddenView.hidden = YES;
    [alert show];
    
}

- (IBAction)showRegisterView:(UIButton *)sender {
    _registerViewController = [[PandaRegisterViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:_registerViewController animated:YES];
}

- (IBAction)goToTabBiew:(UIButton *)sender {
    
//    _tabViewController = [[PandaTabViewController alloc]initWithNibName:nil bundle:nil];
//    [self.navigationController pushViewController:_tabViewController animated:YES];
    
    UIStoryboard *storyBorad = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.view.window.rootViewController = [storyBorad instantiateInitialViewController];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y+32 - (self.view.frame.size.height - 250.0);//键盘高度250
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

@end
