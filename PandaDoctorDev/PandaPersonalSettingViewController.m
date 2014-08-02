//
//  PandaPersonalSettingViewController.m
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/7/29.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import "PandaPersonalSettingViewController.h"

@interface PandaPersonalSettingViewController ()

@end

@implementation PandaPersonalSettingViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)back:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)saveSetting:(UIBarButtonItem *)sender {
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"保存" message:@"保存成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alertView show];
    
}
@end
