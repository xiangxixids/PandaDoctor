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
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

@property NSString *ariticle_id;
@property NSString *titleString;

@property NSString *author;
@property NSString *date;


- (IBAction)back:(UIBarButtonItem *)sender;




@end
