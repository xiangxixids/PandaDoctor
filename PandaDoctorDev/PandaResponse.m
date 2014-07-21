//
//  PandaResponse.m
//  PandaDoctor
//
//  Created by xiangxixids on 14/6/30.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import "PandaResponse.h"

@implementation PandaResponse

-(id)init
{
    if (self == [super init]) {
        self.error_code = 0;
        self.headers = [[NSMutableDictionary alloc]init];
        self.body = [[NSMutableData alloc]initWithCapacity:3];
        self.success = YES;
        self.reason = NO_ERROR;
        self.finished = NO;
    }
    return self;
}

-(NSInteger*)getErrorCode
{
    return self.error_code;
}

-(NSString*)getPandaResponseBody
{
    return self.body;
}

-(NSDictionary*)getPandaResponseHeaders
{
    return self.headers;
}

-(int)getPandaResponseErroCode
{
    return 200;
}

@end
