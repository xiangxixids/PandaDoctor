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
#import "PandaNotification.h"

@interface PandaOCRResultViewController ()

@end

@implementation PandaOCRResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    _webView.delegate = self;
//    
    NSString *content = [[NSString alloc]initWithData:_data encoding:NSUTF8StringEncoding];
//    
//    [_webView loadHTMLString:content baseURL:nil];
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGFloat screen_width  = rect.size.width;
    CGFloat screen_height = rect.size.height;
    UIWebView *m_webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 68, screen_width, screen_height-68)];
    m_webView.delegate = self;
    [m_webView loadHTMLString:content baseURL:nil];
    [self.view addSubview:m_webView];
    
//    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingMutableContainers error:nil];
//    
//    NSArray *ind_result_dict = [dict valueForKey:IND_RESULT]; //indResult
//    
//    NSMutableString *show_result = [[NSMutableString alloc]initWithCapacity:3];
//    
//    for (int i=0; i<ind_result_dict.count; i++) {
//        NSDictionary *dict = [ind_result_dict objectAtIndex:i];
//        NSString *strTemp = [NSString stringWithFormat:@"%d. %@\r\n\r\n",i+1,[dict valueForKey:RST_DESC]];
//        [show_result appendString:strTemp];
//    }
//    
//    [show_result appendString:@"综合分析:\r\n\r\n"];
//    NSArray *complex_result_array = [dict valueForKey:COMPLEXRESULT];
//    for (int i=0; i<complex_result_array.count; i++) {
//        NSDictionary *dict = [complex_result_array objectAtIndex:i];
//        if ([dict valueForKey:RST_DESC]) {// 结果有可能不存在的.
//            NSString *strTemp = [NSString stringWithFormat:@"%@\r\n\r\n", [dict valueForKey:RST_DESC]];
//            [show_result appendString:strTemp];
//        }else{
//            [show_result appendString:@"暂无结果\r\n\r\n"];
//        }
//        [show_result appendString:@"熊猫医生建议:\r\n\r\n"];
//        if ([dict valueForKey:SUGGESTION]) {// 结果有可能不存在的.
//            NSString *strTemp = [NSString stringWithFormat:@"%@\r\n\r\n", [dict valueForKey:SUGGESTION]];
//            [show_result appendString:strTemp];
//        }else{
//            [show_result appendString:@"暂无建议\r\n\r\n"];
//        }
//    }
//    
//    
//    
//    
//    _resultTextView.text = show_result;
    
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
    // 提交结果成功, 无论是否能保存成功图片, 都必须要保证tableview 结果要刷新.
    
    [[NSNotificationCenter defaultCenter]postNotificationName:HISTORY_TABLEVIEW_UPDATE object:nil];
    
    NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"string = %@", string);
    if ([string isEqualToString:@"true"]) {
        
        if ([[UtilTool globalDataGet:[NSString stringWithFormat:@"%d",_checkItemId]] isEqualToString:@"1"]) // can ocr , here we can save the img
        {
            NSLog(@"this item can ocr ");
            // 从服务器找到我们存储的result 生成的时间是什么, 时间+phone+result 组成jpg 的名字.
            PandaRPCInterface *rpcInterface = [[PandaRPCInterface alloc]init];
            NSString *phone = [UtilTool globalDataGet:PHONE];
            NSMutableData *data = [rpcInterface getUserHistory:phone];
            if (data==nil) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"网络错误"
                                                               message:@"联网错误, 请检查您的网络连接是否正常"
                                                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                return;
            }
            NSString *datastr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            _dataList = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSDictionary *dict = [_dataList objectAtIndex:0];
            NSString *date = [dict valueForKey:GMTCREATE];
            //_ocrImageName = [UtilTool createImageName:phone checkItem:_checkItemId result:result];
            _ocrImageName = [UtilTool createImageNameByDate:date phone:phone checkItem:_checkItemId result:result];
            
            NSData *imgData = UIImageJPEGRepresentation(_ocrImage, 1);
            if ([UtilTool saveFileInDocument:_ocrImageName content:imgData]) {
                NSLog(@"save %@ success",_ocrImageName);
            }else
            {
                NSLog(@"save failed");
            }
            
//            if (![UtilTool fileExistInDocument:_ocrImageName]) {
//                NSLog(@"we can save this image");
//                NSFileManager *defaultManager = [NSFileManager defaultManager];
//                NSString *realPath = [NSString stringWithFormat:@"%@/%@",[UtilTool getDocumentPath],_ocrImageName];
//                NSString *tempPath = [NSString stringWithFormat:@"%@/%@",[UtilTool getDocumentPath],TEMPNAME];
//                if ([defaultManager moveItemAtPath:tempPath toPath:realPath error:nil])
//                {
//                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"OCR 图片保存失败"
//                                                                       message:@"无法保存到手机中"
//                                                                      delegate:nil cancelButtonTitle:@"OK"
//                                                             otherButtonTitles:nil, nil];
//                    [alert show];
//                }
//            }else
//            {
//                NSLog(@"result image should not saved");
//            }
        }else{
            NSLog(@"this item can not ocr ");
        }
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"病历保存"
                                                       message:@"成功"
                                                      delegate:self
                                             cancelButtonTitle:@"返回首页"
                                             otherButtonTitles:@"留在这里", nil];
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"alertview click");
    if (buttonIndex == 0) {
        NSLog(@"back to root page");
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    if (buttonIndex == 1) {
        NSLog(@"stay here");
    }
}

- (void)saveImage:(NSString *)imageName
{
    NSData *data = UIImageJPEGRepresentation(_ocrImage, 1);
    if ([UtilTool saveFileInDocument:imageName content:data]) {
        NSLog(@"save temp.jpg success");
    }else
    {
        NSLog(@"save failed");
    }
    
}

- (IBAction)back:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
