//
//  PandaWebViewTestViewController.m
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/10/26.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import "PandaWebViewTestViewController.h"
#import "PandaRPCInterface.h"

@interface PandaWebViewTestViewController ()

@end

@implementation PandaWebViewTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _webView.delegate = self;
    
    PandaRPCInterface *rpc = [[PandaRPCInterface alloc]init];
    
    
    NSMutableData *data;
    NSURLResponse *response;
    NSError *error;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    NSMutableString *checkItemIds = [[NSMutableString alloc]initWithCapacity:3];
    NSMutableString *resultItemIds = [[NSMutableString alloc]initWithCapacity:3];
    
    NSString *string = @"http://www.13xm.com/resultForApp.html?SLB_ID=1&checkItemIds=1,2,3,4,5&res=0,0,1,0,0";
    NSURL *url = [NSURL URLWithString:string];
    
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (data==nil) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"网络错误"
                                                       message:@"联网错误, 请检查您的网络连接是否正常"
                                                      delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    NSString *datastr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSString *content = nil;
    if (dict != nil) {
        content = [dict valueForKey:CONTENT];
    }
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

@end
