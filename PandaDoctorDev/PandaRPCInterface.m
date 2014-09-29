//
//  PandaRPCInterface.m
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/9/25.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import "PandaRPCInterface.h"

static NSString *url = @"192.168.2.109:8080";
static NSString *paperSortForApp = @"paperSortForApp.html";
static NSString *paperForApp = @"paperForApp.html";
static NSString *checkItemsForApp = @"checkItemsForApp.html";
static NSString *resultForApp = @"resultForApp.html";
static NSString *registForApp = @"registForAPP.html";
static NSString *loginForAPP = @"loginForAPP.html";

//?tel=13679084298&passWord=test

@implementation PandaRPCInterface


- (NSMutableData*)paperSortForApp
{
    NSMutableData *data;
    NSURLResponse *response;
    NSError *error;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    NSString *string = [NSString stringWithFormat:@"http://%@/%@", url, paperSortForApp];
    NSURL *url = [NSURL URLWithString:string];
    
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    return data;
}

- (NSMutableData*)paperForApp:(int)item
{
    NSMutableData *data;
    NSURLResponse *response;
    NSError *error;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    NSString *string = [NSString stringWithFormat:@"http://%@/%@?SBT_ID=%d", url, paperForApp,item];
    NSURL *url = [NSURL URLWithString:string];
    
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    return data;
}
- (NSMutableData*)checkItemsForApp:(int)item
{
    NSMutableData *data;
    NSURLResponse *response;
    NSError *error;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    NSString *string = [NSString stringWithFormat:@"http://%@/%@?SLB_ID=%d", url, checkItemsForApp,item];
    NSURL *url = [NSURL URLWithString:string];
    
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    return data;
}
- (NSMutableData*)resultForApp:(int)item checkItemIds:(NSArray*)item_list ItemIds:(NSArray *)id_list
{
    return nil;
}
- (NSMutableData*)registerForAPP:(NSString *)phone passwd:(NSString *)passwd confirm:(NSString *)confirmPasswd
{
    NSMutableData *data;
    NSURLResponse *response;
    NSError *error;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    NSString *string = [NSString stringWithFormat:@"http://%@/%@?tel=%@&passWord=%@&rePassword=%@", url, registForApp,phone,passwd, confirmPasswd];
    NSURL *url = [NSURL URLWithString:string];
    
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    return data;
}

- (NSMutableData*)loginForAPP:(NSString *)phone passwd:(NSString *)passwd{
    NSMutableData *data;
    NSURLResponse *response;
    NSError *error;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    NSString *string = [NSString stringWithFormat:@"http://%@/%@?tel=%@&passWord=%@", url, loginForAPP,phone,passwd];
    NSURL *url = [NSURL URLWithString:string];
    
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    return data;
}


@end
