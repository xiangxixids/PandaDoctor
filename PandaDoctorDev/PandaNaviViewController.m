//
//  PandaNaviViewController.m
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/11/2.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import "PandaNaviViewController.h"

@interface PandaNaviViewController ()

@end

@implementation PandaNaviViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"navi controller loaded");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
    
}

- (BOOL)shouldAutorotate
{
    
    return NO;
    
}

- (NSUInteger)supportedInterfaceOrientations

{
    
    return UIInterfaceOrientationMaskPortrait;//只支持这一个方向(正常的方向)
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
