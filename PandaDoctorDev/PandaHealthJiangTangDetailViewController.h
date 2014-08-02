//
//  PandaHealthJiangTangDetailViewController.h
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/8/2.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PandaHealthJiangTangDetailViewController : UIViewController<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

- (IBAction)back:(UIBarButtonItem *)sender;




@end
