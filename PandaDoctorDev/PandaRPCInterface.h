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
static NSString *SLB_ID = @"SLB_ID";
static NSString *ITEM_NM = @"ITEM_NM";
static NSString *SIGNIFICANCE = @"significance";

static NSString *VALUE = @"VALUE";
static NSString *UNIT = @"UNIT";
static NSString *REF_LOW = @"ref_low";
static NSString *REF_HIGH = @"ref_high";
static NSString *GMTCREATE = @"gmtCreate";
static NSString *RESULT = @"result";

static NSString *COMPLEXRESULT = @"complexResult";
static NSString *CNDT_VAL = @"CNDT_VAL";
static NSString *RST_DESC = @"RST_DESC";
static NSString *SLD_ID = @"SLD_ID";
static NSString *CONCLUSTION = @"conclusion";
static NSString *SUGGESTION = @"suggestion";
static NSString *FLAG = @"flag";
static NSString *IND_RESULT = @"indResult";
static NSString *DEGR_NM = @"DEGR_NM";
static NSString *RF_ID = @"RF_ID";
static NSString *RSVAL_CEL = @"RSVAL_CEL";
static NSString *RSVAL_FLR = @"RSVAL_FLR";
static NSString *USERCOMPLEXRESULTLIST = @"userComplexResultList";


@interface PandaRPCInterface : NSObject


- (NSMutableData*)paperSortForApp;
- (NSMutableData*)paperForApp:(int)item;
- (NSMutableData*)checkItemsForApp:(int)item;
- (NSMutableData*)resultForApp:(int)item checkItemIds:(NSArray*)postData;
- (NSMutableData*)registerForAPP:(NSString *)phone passwd:(NSString *)passwd confirm:(NSString *)confirmPasswd;
- (NSMutableData*)loginForAPP:(NSString *)phone passwd:(NSString *)passwd;
- (NSMutableData*)insertUserHistory:(NSString *)phone resultList:(NSString *)result checkItem:(NSString *)check_id;
- (NSMutableData*)getUserHistory:(NSString*)phone;
- (NSMutableData*)resultHistoryForApp:(NSString*)result checkItem:(NSString*)check_id;
- (NSMutableData*)getAllAriticle;
- (NSMutableData*)getArticleByIdForApp:(NSString*)article_id;


@end
