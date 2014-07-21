//
//  HttpService.h
//  PandaDoctor
//
//  Created by xiangxixids on 14/6/30.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PandaResponse.h"
@interface HttpService : NSObject < NSURLConnectionDataDelegate >
{
    int method;
    int content_length;
}

#define GET     (0)
#define POST    (1)

@property (strong, nonatomic) NSString *notificationName;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) PandaResponse *response;

-(id)init;
+(id)init:(NSString *)notificationName;
-(PandaResponse *)connectPandaServer:(NSString *)url useMethod:(int)method withHeaers:(NSMutableDictionary*)headers sendBody:(NSString*)body;

@end
