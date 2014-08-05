//
//  PandaHuaYanDanData.h
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/8/3.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PandaHuaYanDanData : NSObject

@property NSInteger mid;
@property NSString *itemName;
@property NSArray *itemList;
@property NSString *shuoMing;
@property NSArray *checkItems;
@property NSMutableDictionary *itemMeaning; // [NSString pandahuayandandata]

- (void)setShuoMing:(NSString *)shuoMing;

@end
