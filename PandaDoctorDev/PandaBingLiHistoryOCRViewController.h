//
//  PandaBingLiHistoryOCRViewController.h
//  PandaDoctorDev
//
//  Created by xiangxixids on 10/23/14.
//  Copyright (c) 2014 xiangxixids. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PandaBingLiHistoryOCRViewController : UIViewController<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *ocrImageView;

@property NSString *checkItem; // checkItem
@property NSString *result; // 0,0,1,0,1,0,0,0,0,0,0,0,0
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property NSString *dateTimeString;
@property NSString *huaYanDanNameString;

@property (weak, nonatomic) IBOutlet UILabel *huaYanDanName;
@property (weak, nonatomic) IBOutlet UILabel *dateTime;


@property UIImage *ocrImage;


- (IBAction)showResult:(UIBarButtonItem *)sender;

- (IBAction)back:(UIBarButtonItem *)sender;

@end
