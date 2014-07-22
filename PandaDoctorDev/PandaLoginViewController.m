//
//  PandaLoginViewController.m
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/7/21.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import "PandaLoginViewController.h"

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
@end
