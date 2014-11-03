//
//  PandaHealthJiangTangDetailViewController.m
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/8/2.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import "PandaHealthJiangTangDetailViewController.h"
#import "PandaRPCInterface.h"
@interface PandaHealthJiangTangDetailViewController ()

@end

@implementation PandaHealthJiangTangDetailViewController

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
    
    
    UINavigationItem *item = [_navigationBar.items objectAtIndex:0];
    item.title = _titleString;
    
    PandaRPCInterface *rpc = [[PandaRPCInterface alloc]init];
    NSMutableData *data = [rpc getArticleByIdForApp:_ariticle_id];
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
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
//    _webView.delegate = self;
//    [_webView loadHTMLString:content baseURL:nil];
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGFloat screen_width  = rect.size.width;
    CGFloat screen_height = rect.size.height;
    UIWebView *m_webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 68, screen_width, screen_height-68)];
    m_webView.delegate = self;
    NSMutableString *content_modify = [[NSMutableString alloc]initWithCapacity:3];
    [content_modify appendFormat:@"<p>文章来源: %@</p>", _author];
    [content_modify appendFormat:@"<p>时间: %@</p>", _date];
    [content_modify appendFormat:@"%@", content];
    [m_webView setScalesPageToFit:NO];// YES 超级难看.
    [m_webView loadHTMLString:content_modify baseURL:nil];
    [self.view addSubview:m_webView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"webviewDidStartLoad");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"finish webViewDidFinishLoad");
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    NSLog(@"load error");
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
