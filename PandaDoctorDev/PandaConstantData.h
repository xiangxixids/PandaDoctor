//
//  PandaConstantData.h
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/8/3.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PandaHuaYanDanData.h"

@interface PandaConstantData : NSObject

#define SANDACHANGGUI           1
#define GANZANGXIANGMU          2
#define XUETANGXUEZHI           3
#define SHENZANGXIANGMU         4
#define JIAZHUANGXIANGONGNENG   5
#define ZHONGLIUXIANGMU         6
#define YOUSHENGXIANGMU         7
#define FUKEXIANGMU             8
#define OTHERXIANGMU            9

@property PandaHuaYanDanData *sanDaChangGui;
@property PandaHuaYanDanData *ganZangXiangMu;
@property PandaHuaYanDanData *xueTangXueZhi;
@property PandaHuaYanDanData *shenZangXiangMu;
@property PandaHuaYanDanData *jiaZhuangXianGongNeng;
@property PandaHuaYanDanData *zhongLiuXiangMu;
@property PandaHuaYanDanData *youShengXiangMu;
@property PandaHuaYanDanData *fuKeXiangMu;
@property PandaHuaYanDanData *otherXiangMu;

-(void)initData;

@end
