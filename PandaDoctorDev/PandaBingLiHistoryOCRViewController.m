//
//  PandaBingLiHistoryOCRViewController.m
//  PandaDoctorDev
//
//  Created by xiangxixids on 10/23/14.
//  Copyright (c) 2014 xiangxixids. All rights reserved.
//

#import "PandaBingLiHistoryOCRViewController.h"
#import "PandaBingLiHistoryDetailResultViewController.h"

@interface PandaBingLiHistoryOCRViewController ()

@end

@implementation PandaBingLiHistoryOCRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSLog(@"checkItem = %@", _checkItem);
    NSLog(@"result = %@", _result);
    
    _ocrImageView.image = _ocrImage;
    
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

- (IBAction)showResult:(UIBarButtonItem *)sender {
    
    PandaBingLiHistoryDetailResultViewController *controller = [[PandaBingLiHistoryDetailResultViewController alloc]initWithNibName:nil bundle:nil];
    
    controller.result = _result;
    controller.SLB_ID = _checkItem;
    
    [self.navigationController pushViewController:controller animated:YES];

}

- (IBAction)back:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
