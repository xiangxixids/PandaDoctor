//
//  PandaOCRResultViewController.m
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/10/1.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import "PandaOCRResultViewController.h"

@interface PandaOCRResultViewController ()

@end

@implementation PandaOCRResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _resultTextView.text = _datastr;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveResult:(UIBarButtonItem *)sender {
}

- (IBAction)back:(UIBarButtonItem *)sender {
}
@end
