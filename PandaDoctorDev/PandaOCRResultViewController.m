//
//  PandaOCRResultViewController.m
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/10/1.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import "PandaOCRResultViewController.h"
#import "PandaRPCInterface.h"
#import "UtilTool.h"

@interface PandaOCRResultViewController ()

@end

@implementation PandaOCRResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //_resultTextView.text = _datastr;
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingMutableContainers error:nil];
    
    NSArray *ind_result_dict = [dict valueForKey:IND_RESULT]; //indResult
    
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
    
    
    
    
    
    _resultTextView.text = show_result;
    
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
    
    //NSMutableData *data = [rpcInterface insertUserHistory:@"13679084298" resultList:@"0,0,0,0,0,0,0,0,0,0,0,0,0" checkItem:@"5"];
    
    NSString *phone = [UtilTool globalDataGet:PHONE];
    NSMutableString *result = [[NSMutableString alloc]initWithCapacity:3];
    for (int i=0; i<_postArray.count; i++) {
        NSDictionary *dict = [_postArray objectAtIndex:i];
        NSString *string = [NSString stringWithFormat:@"%@",[dict valueForKey:RESULT]];
        if (i<(_postArray.count-1)) {
            [result appendString:string];
            [result appendString:@","];
        }else{
            [result appendString:string];
        }
    }
    NSString *checkItem = [NSString stringWithFormat:@"%d",_checkItemId];
    
    PandaRPCInterface *rpc = [[PandaRPCInterface alloc]init];
    NSMutableData *data = [rpc insertUserHistory:phone resultList:result checkItem:checkItem];
    if (data==nil) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"网络错误"
                                                       message:@"联网错误, 请检查您的网络连接是否正常"
                                                      delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"string = %@", string);
    if ([string isEqualToString:@"true"]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"病历保存"
                                                       message:@"成功"
                                                      delegate:nil
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil, nil];
        [alert show];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"病历保存"
                                                       message:@"失败"
                                                      delegate:nil
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil, nil];
        [alert show];
    }
    
}

- (IBAction)back:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
