//
//  PandaBingLiHistoryDetailResultViewController.m
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/7/29.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import "PandaBingLiHistoryDetailResultViewController.h"
#import "PandaRPCInterface.h"

@interface PandaBingLiHistoryDetailResultViewController ()

@end

@implementation PandaBingLiHistoryDetailResultViewController

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
    
    PandaRPCInterface *rpcInterface = [[PandaRPCInterface alloc]init];
    NSMutableData *data = [rpcInterface resultHistoryForApp:_result checkItem:_SLB_ID];
    if (data==nil) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"网络错误"
                                                       message:@"联网错误, 请检查您的网络连接是否正常"
                                                      delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"string = %@", string);
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *ind_result_dict = [dict valueForKey:IND_RESULT];
    
    NSMutableString *show_result = [[NSMutableString alloc]initWithCapacity:3];
    
    for (int i=0; i<ind_result_dict.count; i++) {
        NSDictionary *dict = [ind_result_dict objectAtIndex:i];
        NSString *strTemp = [NSString stringWithFormat:@"%d. %@\r\n\r\n",i+1,[dict valueForKey:RST_DESC]];
        [show_result appendString:strTemp];
    }
    
    [show_result appendString:@"综合分析:\r\n\r\n"];
    NSArray *complex_result_array = [dict valueForKey:COMPLEXRESULT];
    for (int i=0; i<complex_result_array.count; i++) {
        NSDictionary *dict = [complex_result_array objectAtIndex:i];
        if ([dict valueForKey:RST_DESC]) {// 结果有可能不存在的.
            NSString *strTemp = [NSString stringWithFormat:@"%@\r\n\r\n", [dict valueForKey:RST_DESC]];
            [show_result appendString:strTemp];
        }else{
            [show_result appendString:@"暂无结果\r\n\r\n"];
        }
        [show_result appendString:@"熊猫医生建议:\r\n\r\n"];
        if ([dict valueForKey:SUGGESTION]) {// 结果有可能不存在的.
            NSString *strTemp = [NSString stringWithFormat:@"%@\r\n\r\n", [dict valueForKey:SUGGESTION]];
            [show_result appendString:strTemp];
        }else{
            [show_result appendString:@"暂无建议\r\n\r\n"];
        }
    }
    
    _resultView.text = show_result;
    
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
@end
