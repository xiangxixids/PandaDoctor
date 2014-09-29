//
//  PandaRPCInterface.h
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/9/25.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *RCRD_ID = @"RCRD_ID";
static NSString *ENG_NM  = @"ENG_NM";
static NSString *SLB_NM  = @"SLB_NM";
static NSString *ITEM_NM = @"ITEM_NM";
static NSString *SIGNIFICANCE = @"significance";

static NSString *VALUE = @"VALUE";
static NSString *UNIT = @"UNIT";
static NSString *REF_LOW = @"ref_low";
static NSString *REF_HIGH = @"ref_high";

@interface PandaRPCInterface : NSObject


- (NSMutableData*)paperSortForApp;
- (NSMutableData*)paperForApp:(int)item;
- (NSMutableData*)checkItemsForApp:(int)item;
- (NSMutableData*)resultForApp:(int)item checkItemIds:(NSArray*)item_list ItemIds:(NSArray *)id_list;
- (NSMutableData*)registerForAPP:(NSString *)phone passwd:(NSString *)passwd confirm:(NSString *)confirmPasswd;
- (NSMutableData*)loginForAPP:(NSString *)phone passwd:(NSString *)passwd;

@end
