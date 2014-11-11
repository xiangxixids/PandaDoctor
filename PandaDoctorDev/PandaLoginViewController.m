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
    
    dispatch_queue_t queue = dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _indicatorPopup.hidden = NO;
    _hiddenView.hidden = NO;
    [_indicatorPopup startAnimating];
    [_indicatorPopup setHidesWhenStopped:YES];
    dispatch_async(queue, ^{
        NSLog(@"test result");
        // do network job
        
        PandaRPCInterface *rpcInterface = [[PandaRPCInterface alloc]init];
        _data = [rpcInterface loginForAPP:_account.text passwd:_passwd.text];
        
        // tell the main thread when job done
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"main thread start");
            [_indicatorPopup stopAnimating];
            _hiddenView.hidden = NO;
            if (_data==nil) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"网络错误"
                                                                message:@"联网错误, 请检查您的网络连接是否正常"
                                                                delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                return;
            }
            NSString *result = [[NSString alloc]initWithData:_data encoding:NSUTF8StringEncoding];
        
            if ([result  isEqualToString: @"true"]) {
                NSLog(@"login successful");
        
                [UtilTool globalDataSave:_account.text forKey:PHONE];
                [UtilTool globalDataSave:@"1" forKey:LOGIN];
                UIStoryboard *storyBorad = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                self.view.window.rootViewController = [storyBorad instantiateInitialViewController];
            }else{
                NSLog(@"login failed");
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"登录失败" message:@"请检查用户名和密码是否正确" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [_indicatorPopup stopAnimating];
                _hiddenView.hidden = YES;
                [alert show];
            }
            
            
        });
    });
    
    
//    PandaRPCInterface *rpcInterface = [[PandaRPCInterface alloc]init];
//    NSMutableData *data = [rpcInterface loginForAPP:_account.text passwd:_passwd.text];
//    
//    if (data==nil) {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"网络错误"
//                                                       message:@"联网错误, 请检查您的网络连接是否正常"
//                                                      delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//        return;
//    }
//    NSString *result = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    
//    if ([result  isEqualToString: @"true"]) {
//        NSLog(@"login successful");
//        
//        [UtilTool globalDataSave:_account.text forKey:PHONE];
//        [UtilTool globalDataSave:@"1" forKey:LOGIN];
//        UIStoryboard *storyBorad = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        self.view.window.rootViewController = [storyBorad instantiateInitialViewController];
//    }else{
//        NSLog(@"login failed");
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"登录失败" message:@"请检查用户名和密码是否正确" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [_indicatorPopup stopAnimating];
//        _hiddenView.hidden = YES;
//        [alert show];
//    }
    
}

- (void)loginActionSY
{
    
    PandaRPCInterface *rpcInterface = [[PandaRPCInterface alloc]init];
    
    NSMutableData *data = [rpcInterface loginForAPP:_account.text passwd:_passwd.text];
    if (data==nil) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"网络错误"
                                                       message:@"联网错误, 请检查您的网络连接是否正常"
                                                      delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    NSString *result = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    [_indicatorPopup stopAnimating];
    
    if ([result  isEqualToString: @"true"]) {
        NSLog(@"login successful");
        [UtilTool globalDataSave:_account.text forKey:PHONE];
        [UtilTool globalDataSave:@"1" forKey:LOGIN];
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
    [UtilTool globalDataSave:@"1" forKey:LOGIN];
    UIStoryboard *storyBorad = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.view.window.rootViewController = [storyBorad instantiateInitialViewController];
    
}
////// 修改输入法弹框
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
//    int offset = frame.origin.y+32 - (_loginView.frame.size.height - 250.0);//键盘高度250
    int offset = frame.origin.y+frame.size.height - (_loginView.frame.size.height - 250);//键盘高度250
    offset = 250 + frame.size.height - (_loginView.frame.size.height - frame.origin.y);
    offset = frame.origin.y + frame.size.height - 230;
    offset = 250 - (_loginView.frame.size.height - (frame.origin.y+frame.size.height));
    //offset = 2;
    NSLog(@"offset is %d",offset);
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
    {
        _loginView.frame = CGRectMake(0.0f, -offset, _loginView.frame.size.width, _loginView.frame.size.height);
    }
        //self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
        //_loginView.frame = CGRectMake(0.0f, -offset, _loginView.frame.size.width, _loginView.frame.size.height);
    
    
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
