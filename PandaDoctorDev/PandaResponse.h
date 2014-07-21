//
//  PandaResponse.h
//  PandaDoctor
//
//  Created by xiangxixids on 14/6/30.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PandaHttpErrorCode.h"

@interface PandaResponse : NSObject

@property(strong, nonatomic) NSMutableData *body; // there should be raw data, can not change it to string directly
@property(strong, nonatomic) NSMutableDictionary *headers;
@property NSInteger *error_code;
@property Boolean success;
@property NSInteger reason;
@property NSInteger content_length;
@property double loading_rate;
@property Boolean finished;

-(id)init;
-(NSInteger*)getErrorCode;
-(NSString*)getPandaResponseBody;
-(NSDictionary*)getPandaResponseHeaders;
-(int)getPandaResponseErroCode;

@end
