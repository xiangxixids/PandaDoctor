//
//  PandaBingLiViewController.m
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/7/23.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import "PandaBingLiViewController.h"

@interface PandaBingLiViewController ()

@end

@implementation PandaBingLiViewController

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
    // Do any additional setup after loading the view.
    NSLog(@"PandaBingLiViewController view did load");
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

- (IBAction)showDataGram:(UIButton *)sender {
    
    _datagramController = [[PandaDatagramViewController alloc]initWithNibName:nil bundle:nil];
    _datagramController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:_datagramController animated:YES];
    
}

- (IBAction)showBingLiHistory:(UIButton *)sender {
    
    _bingliHistoryController = [[PandaBingLiHistoryViewController alloc]initWithNibName:nil bundle:nil];
    _bingliHistoryController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:_bingliHistoryController animated:YES];
    
    
    
}

- (IBAction)personalSetting:(UIButton *)sender {
    
    _personalSettingController = [[PandaPersonalSettingViewController alloc]initWithNibName:nil bundle:nil];
    _personalSettingController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:_personalSettingController animated:YES];
    
}

- (IBAction)modifyPassword:(UIButton *)sender {
    
    _modifyPasswordController = [[PandaModifyPasswordViewController alloc]initWithNibName:nil bundle:nil];
    _modifyPasswordController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:_modifyPasswordController animated:YES];
    
}
@end
