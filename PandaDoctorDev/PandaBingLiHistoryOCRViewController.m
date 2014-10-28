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
#import "PandaTapGestureRecognizer.h"

@interface PandaBingLiHistoryOCRViewController ()

@end

@implementation PandaBingLiHistoryOCRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSLog(@"checkItem = %@", _checkItem);
    NSLog(@"result = %@", _result);
    
    //_ocrImageView.contentMode = UIViewContentModeScaleAspectFill;
    _ocrImageView.image = _ocrImage;
    
    PandaTapGestureRecognizer *ocrSigleView = [[PandaTapGestureRecognizer alloc]initWithTarget:self action:@selector(showScrollView)];
    if (!_default_img) {
        [_ocrImageView addGestureRecognizer:ocrSigleView];
    }
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
    
    _loadingView.hidden = YES;
    [_loadingView setBackgroundColor:[UIColor blackColor]];
    _sv.delegate = self;
    _iv.image = _ocrImage;
    PandaTapGestureRecognizer *sigleTap = [[PandaTapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenScrollView)];
    [_iv addGestureRecognizer:sigleTap];
    
    // 重置UIImageView的Frame，让图片居中显示
//    CGFloat origin_x = abs(_sv.frame.size.width - _ocrImage.size.width)/2.0;
//    CGFloat origin_y = abs(_sv.frame.size.height - _ocrImage.size.height)/2.0;
//    _iv.frame = CGRectMake(origin_x, origin_y, _sv.frame.size.width, _sv.frame.size.width*_ocrImage.size.height/_ocrImage.size.width);
//    [_iv setImage:_ocrImage];
    
    CGSize  maxSize = _sv.frame.size;
    CGFloat widthRatio = maxSize.width/_ocrImage.size.width;
    CGFloat heightRatio = maxSize.height/_ocrImage.size.height;
    CGFloat initialZoom = (widthRatio > heightRatio) ? heightRatio : widthRatio;
    
    //[_sv setMinimumZoomScale:initialZoom];
    [_sv setMinimumZoomScale:1];
    [_sv setMaximumZoomScale:5];
    // 设置UIScrollView初始化缩放级别
    [_sv setZoomScale:initialZoom];
    
    // 动态隐藏加载界面，从而显示图片
//    [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationCurveLinear animations:^{
//        _loadingView.alpha = 0;
//    } completion:^(BOOL finished){
//        [_loadingView setHidden:YES];
//    }];
    
//    _loadingView.frame = CGRectMake(_ocrImageView.frame.origin.x, _ocrImageView.frame.origin.y, _ocrImageView.frame.size.width, _ocrImageView.frame.size.height);
//    _sv.frame = CGRectMake(_ocrImageView.frame.origin.x, _ocrImageView.frame.origin.y, _ocrImageView.frame.size.width, _ocrImageView.frame.size.height);
//    _iv.frame = CGRectMake(_ocrImageView.frame.origin.x, _ocrImageView.frame.origin.y, _ocrImageView.frame.size.width, _ocrImageView.frame.size.height);
    
}

- (void)hiddenScrollView
{
    NSLog(@"hidden scroll view");
//    CGRect rect = [[UIScreen mainScreen] bounds];
//    _loadingView.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
//    _sv.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
//    _iv.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
//    [UIView beginAnimations:nil context:nil];
//
//    [UIView setAnimationDuration:0.5];
//
//    _loadingView.frame = CGRectMake(_ocrImageView.frame.origin.x, _ocrImageView.frame.origin.y, _ocrImageView.frame.size.width, _ocrImageView.frame.size.height);
    
//    _loadingView.hidden = YES;
//    
//    [UIView commitAnimations];
    
    [UIView animateWithDuration:0.5 animations:^{
//        _loadingView.frame = CGRectMake(_ocrImageView.frame.origin.x, _ocrImageView.frame.origin.y, _ocrImageView.frame.size.width, _ocrImageView.frame.size.height);
//        _sv.frame = CGRectMake(_ocrImageView.frame.origin.x, _ocrImageView.frame.origin.y, _ocrImageView.frame.size.width, _ocrImageView.frame.size.height);
//        _iv.frame = CGRectMake(_ocrImageView.frame.origin.x, _ocrImageView.frame.origin.y, _ocrImageView.frame.size.width, _ocrImageView.frame.size.height);
        _loadingView.alpha = 0;
    } completion:^(BOOL finished) {
        _loadingView.hidden = YES;
    }];
    
}

- (void)showScrollView
{
    NSLog(@"show scroll view");
    
//    CGRect rect = [[UIScreen mainScreen] bounds];
//    _loadingView.frame = CGRectMake(_ocrImageView.frame.origin.x, _ocrImageView.frame.origin.y, _ocrImageView.frame.size.width, _ocrImageView.frame.size.height);
//    _sv.frame = CGRectMake(_ocrImageView.frame.origin.x, _ocrImageView.frame.origin.y, _ocrImageView.frame.size.width, _ocrImageView.frame.size.height);
//    _iv.frame = CGRectMake(_ocrImageView.frame.origin.x, _ocrImageView.frame.origin.y, _ocrImageView.frame.size.width, _ocrImageView.frame.size.height);
    
//    [UIView beginAnimations:nil context:nil];
    
//    [UIView setAnimationDuration:0.5];
    
    //    frame.origin.x += 150;
    //
    //    [img setFrame:frame];
    
//    _loadingView.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
//    _sv.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
//    _iv.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    
//    _loadingView.hidden = NO;
    
    //[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
//    [UIView commitAnimations];
    _loadingView.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        //        _loadingView.frame = CGRectMake(_ocrImageView.frame.origin.x, _ocrImageView.frame.origin.y, _ocrImageView.frame.size.width, _ocrImageView.frame.size.height);
        //        _sv.frame = CGRectMake(_ocrImageView.frame.origin.x, _ocrImageView.frame.origin.y, _ocrImageView.frame.size.width, _ocrImageView.frame.size.height);
        //        _iv.frame = CGRectMake(_ocrImageView.frame.origin.x, _ocrImageView.frame.origin.y, _ocrImageView.frame.size.width, _ocrImageView.frame.size.height);
        _loadingView.hidden = NO;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            _loadingView.alpha = 1;
        } completion:^(BOOL finished) {
            
        }];
//        _loadingView.alpha = 1;
    }];
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _iv;
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
