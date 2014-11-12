//
//  PandaHuaYanDanMainViewController.h
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/8/2.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PandaTapGestureRecognizer.h"
#import "PandaHuaYanDanXiangMuListViewController.h"
#import "PandaConstantData.h"

@interface PandaHuaYanDanMainViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *sanDaChangGuiImage;
@property (weak, nonatomic) IBOutlet UIImageView *ganZangXiangMuImage;
@property (weak, nonatomic) IBOutlet UIImageView *xueTangXueZhiImage;
@property (weak, nonatomic) IBOutlet UIImageView *shenZangXiangMuImage;
@property (weak, nonatomic) IBOutlet UIImageView *jiaZhuangXianImageView;
@property (weak, nonatomic) IBOutlet UIImageView *zhongLiuImageView;
@property (weak, nonatomic) IBOutlet UIImageView *youShengXiangMuImage;
@property (weak, nonatomic) IBOutlet UIImageView *fuKeImage;
@property (weak, nonatomic) IBOutlet UIImageView *otherImage;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorPop;

@property dispatch_source_t timer;
@property Boolean ayncThreadStop;
@property NSTimer *showTimer;
@property NSMutableData *data;

@property PandaConstantData *huaYanDanConstData;

- (IBAction)logOut:(UIBarButtonItem *)sender;

- (IBAction)touchDown:(UIControl *)sender;

@property PandaHuaYanDanXiangMuListViewController *huaYanDanXiangMuListViewController;


@end
