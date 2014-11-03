//
//  PandaRPCInterface.m
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/9/25.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import "PandaRPCInterface.h"

//static NSString *url = @"192.168.2.103:8080";
static NSString *url = @"www.13xm.com";
static NSString *paperSortForApp = @"paperSortForApp.html";
static NSString *paperForApp = @"paperForApp.html";
static NSString *checkItemsForApp = @"checkItemsForApp.html";
static NSString *resultForApp = @"resultForApp.html";
static NSString *registForApp = @"registForAPP.html";
static NSString *loginForAPP = @"loginForAPP.html";
static NSString *insertUserHistory = @"insertUserHistory.html";
static NSString *getUserHistory = @"getUserHistory.html";
static NSString *resultHistoryForApp = @"resultHisrtoryForApp.html";
static NSString *getAllArticle = @"getAllArticle.html";
static NSString *getAllArticleByType = @"getAllArticleByType.html";
static NSString *getArticleByIdForApp = @"getArticleByIdForApp.html";


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
- (NSMutableData*)resultForApp:(int)item checkItemIds:(NSArray*)postData
{
    NSMutableData *data;
    NSURLResponse *response;
    NSError *error;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    NSMutableString *checkItemIds = [[NSMutableString alloc]initWithCapacity:3];
    NSMutableString *resultItemIds = [[NSMutableString alloc]initWithCapacity:3];
    
    for (int i=0; i<postData.count; i++) {
        NSString *str = [NSString stringWithFormat:@"%@", [[postData objectAtIndex:i] valueForKey:RCRD_ID]];
        [checkItemIds appendString:str];
        [resultItemIds appendString:[[postData objectAtIndex:i] valueForKey:RESULT]];
        if (i<(postData.count-1)) {
            [checkItemIds appendString:@","];
            [resultItemIds appendString:@","];
        }
    }
    
    NSString *string = [NSString stringWithFormat:@"http://%@/%@?SLB_ID=%d&checkItemIds=%@&res=%@", url, resultForApp,item, checkItemIds, resultItemIds];
    NSURL *url = [NSURL URLWithString:string];
    
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    return data;
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

- (NSMutableData*)insertUserHistory:(NSString *)phone resultList:(NSString *)result checkItem:(NSString *)check_id
{
    NSMutableData *data;
    NSURLResponse *response;
    NSError *error;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    NSString *string = [NSString stringWithFormat:@"http://%@/%@?tel=%@&res=%@&SLB_ID=%@", url, insertUserHistory,phone,result,check_id];
    NSURL *url = [NSURL URLWithString:string];
    
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    return data;
}
- (NSMutableData*)getUserHistory:(NSString*)phone
{
    NSMutableData *data;
    NSURLResponse *response;
    NSError *error;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    NSString *string = [NSString stringWithFormat:@"http://%@/%@?tel=%@", url, getUserHistory,phone];
    NSURL *url = [NSURL URLWithString:string];
    
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];

    return data;
}
- (NSMutableData*)resultHistoryForApp:(NSString*)result checkItem:(NSString*)check_id
{
    NSMutableData *data;
    NSURLResponse *response;
    NSError *error;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    NSString *string = [NSString stringWithFormat:@"http://%@/%@?res=%@&SLB_ID=%@", url, resultHistoryForApp,result,check_id];
    NSURL *url = [NSURL URLWithString:string];
    
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    return data;
}
- (NSMutableData*)getAllAriticle
{
    NSMutableData *data;
    NSURLResponse *response;
    NSError *error;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    NSString *string = [NSString stringWithFormat:@"http://%@/%@", url, getAllArticle];
    NSURL *url = [NSURL URLWithString:string];
    
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    return data;
}
- (NSMutableData*)getAllAriticleByType:(NSString *)type
{
    NSMutableData *data;
    NSURLResponse *response;
    NSError *error;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    NSString *string = [NSString stringWithFormat:@"http://%@/%@?articleType=%@", url, getAllArticleByType, type];
    NSURL *url = [NSURL URLWithString:string];
    
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    return data;
}

- (NSMutableData*)getArticleByIdForApp:(NSString*)article_id
{
    NSMutableData *data;
    NSURLResponse *response;
    NSError *error;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    NSString *string = [NSString stringWithFormat:@"http://%@/%@?articeId=%@", url, getArticleByIdForApp,article_id];
    NSURL *url = [NSURL URLWithString:string];
    
    [request setURL:url];
    [request setHTTPMethod:@"GET"];
    data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    return data;
}


@end
