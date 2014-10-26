//
//  PandaBingLiHistoryOCRViewController.m
//  PandaDoctorDev
//
//  Created by xiangxixids on 10/23/14.
//  Copyright (c) 2014 xiangxixids. All rights reserved.
//

#import "PandaBingLiHistoryOCRViewController.h"
#import "PandaBingLiHistoryDetailResultViewController.h"
#import "PandaRPCInterface.h"

@interface PandaBingLiHistoryOCRViewController ()

@end

@implementation PandaBingLiHistoryOCRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSLog(@"checkItem = %@", _checkItem);
    NSLog(@"result = %@", _result);
    
    _ocrImageView.image = _ocrImage;
    _webView.delegate = self;
    
    _dateTime.text = [_dateTimeString stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    _huaYanDanName.text = _huaYanDanNameString;
    
    PandaRPCInterface *rpcInterface = [[PandaRPCInterface alloc]init];
    NSMutableData *data = [rpcInterface resultHistoryForApp:_result checkItem:_checkItem];
    if (data==nil) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"网络错误"
                                                       message:@"联网错误, 请检查您的网络连接是否正常"
                                                      delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    //[self saveTempImage];
    NSString *datastr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    
    [_webView loadHTMLString:datastr baseURL:nil];
    
    
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
