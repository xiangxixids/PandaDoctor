//
//  PandaViewController.m
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/7/13.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import "PandaViewController.h"

@interface PandaViewController ()

@end

@implementation PandaViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"PandaViewController view did load");
//    UIBarButtonItem *leftbutton = [[UIBarButtonItem alloc]initWithTitle:@"back"
//                                                                  style:UIBarButtonItemStyleBordered target:self action:@selector(action)];
//    self.navigationController.navigationItem.leftBarButtonItem = leftbutton;
    
//    self.toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
//    self.toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    [self.navigationController.navigationBar setHidden:NO];
//    [self.navigationController.navigationBar insertSubview:self.toolbar aboveSubview:0];
//    self.navigationController.navigationBar.tintColor = [UIColor redColor];
//    self.navigationController.navigationItem.title = @"熊猫医生";
//    
    self.bar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0,0,320,64)];
    [self.view addSubview:self.bar];
    
    UINavigationItem *barItem = [[UINavigationItem alloc]initWithTitle:@"title111"];
    
    barItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"abc"
                                                                style:UIBarButtonItemStyleBordered target:self action:nil];
    barItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"efg" style:UIBarButtonItemStyleBordered target:self action:nil];
    
    
    [self.bar pushNavigationItem:barItem animated:NO];
    
//    CGFloat h = 64.0f;
//    CGRect frame = CGRectMake(0, 0, 320.0f, h);
//    [self.bar setFrame:frame];
//    [self.bar updateConstraints];
//    [self.view addSubview:self.bar];
    
    
    
    
}

- (IBAction)action:(UIBarButtonItem*)sender{
    NSLog(@"action is called");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
