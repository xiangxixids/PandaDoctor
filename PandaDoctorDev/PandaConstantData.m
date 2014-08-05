//
//  PandaConstantData.m
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/8/3.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import "PandaConstantData.h"

@implementation PandaConstantData

-(void)initData{
    _sanDaChangGui = [[PandaHuaYanDanData alloc]init];
    _sanDaChangGui.mid = SANDACHANGGUI;
    _sanDaChangGui.itemName = @"三大常规";
    [_sanDaChangGui setShuoMing:@"三大常规检查说明" ];
    _sanDaChangGui.itemList = [NSArray arrayWithObjects:@"三大常规1",@"三大常规2",@"三大常规3", nil];
    _sanDaChangGui.itemMeaning = [[NSMutableDictionary alloc]initWithCapacity:2];
    NSMutableDictionary *sanDaChangGuiItem1 = [[NSMutableDictionary alloc]initWithCapacity:3];
    [sanDaChangGuiItem1 setObject:@"三大常规1" forKey:@"title"];
    [sanDaChangGuiItem1 setObject:@"检查意义1" forKey:@"description"];
    [sanDaChangGuiItem1 setObject:@"描述11" forKey:@"三大常规11"];
    [sanDaChangGuiItem1 setObject:@"描述22" forKey:@"三大常规12"];
    [sanDaChangGuiItem1 setObject:@"描述33" forKey:@"三大常规13"];
    
    NSMutableDictionary *sanDaChangGuiItem2 = [[NSMutableDictionary alloc]initWithCapacity:3];
    [sanDaChangGuiItem2 setObject:@"三大常规2" forKey:@"title"];
    [sanDaChangGuiItem2 setObject:@"检查意义2" forKey:@"description"];
    [sanDaChangGuiItem2 setObject:@"描述21" forKey:@"三大常规21"];
    [sanDaChangGuiItem2 setObject:@"描述22" forKey:@"三大常规22"];
    [sanDaChangGuiItem2 setObject:@"描述23" forKey:@"三大常规23"];
    
    NSMutableDictionary *sanDaChangGuiItem3 = [[NSMutableDictionary alloc]initWithCapacity:3];
    [sanDaChangGuiItem3 setObject:@"三大常规3" forKey:@"title"];
    [sanDaChangGuiItem3 setObject:@"检查意义3" forKey:@"description"];
    [sanDaChangGuiItem3 setObject:@"描述31" forKey:@"三大常规31"];
    [sanDaChangGuiItem3 setObject:@"描述32" forKey:@"三大常规32"];
    [sanDaChangGuiItem3 setObject:@"描述33" forKey:@"三大常规33"];
    [_sanDaChangGui.itemMeaning setObject:sanDaChangGuiItem1 forKey:@"三大常规1"];
    [_sanDaChangGui.itemMeaning setObject:sanDaChangGuiItem2 forKey:@"三大常规2"];
    [_sanDaChangGui.itemMeaning setObject:sanDaChangGuiItem2 forKey:@"三大常规3"];
    
//    _ganZangXiangMu;
//    PandaHuaYanDanData * const xueTangXueZhi;
//    PandaHuaYanDanData * const shenZangXiangMu;
//    PandaHuaYanDanData * const jiaZhuangXianGongNeng;
//    PandaHuaYanDanData * const zhongLiuXiangMu;
//    PandaHuaYanDanData * const youShengXiangMu;
//    PandaHuaYanDanData * const fuKeXiangMu;
//    PandaHuaYanDanData * const otherXiangMu;
}

@end
