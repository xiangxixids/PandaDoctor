//
//  HttpService.m
//  PandaDoctor
//
//  Created by xiangxixids on 14/6/30.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import "HttpService.h"

@implementation HttpService

-(id)init
{
    if (self == [super init])
    {
        
    }
    return self;
}

-(PandaResponse *)connectPandaServer:(NSString *)url useMethod:(int)method withHeaers:(NSMutableDictionary*)headers sendBody:(NSString*)body
{
    _response = [[PandaResponse alloc]init];
    
    if ( url == nil ) {
        NSLog(@"url is empty, connect failed");
        return nil;
    }else if ( method != 0 && method != 1 ){
        NSLog(@"method is not GET and POST, connect failed");
        return nil;
    }
    NSURL *pandaURL = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[pandaURL standardizedURL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:100.0];
    
    if (method == 0)
    {
        [request setHTTPMethod:@"GET"];
    }else if(method == 1){
        [request setHTTPMethod:@"POST"];
    }
    
    if (headers != nil)
    {
        NSArray *keys = [headers allKeys];
        for (NSString *key in keys) {
            [request setValue:[headers valueForKey:key] forKey:key];
        }
    }
    
    if (body != nil)
    {
        [request setHTTPBody:[body dataUsingEncoding:(NSUTF8StringEncoding)]];
    }
    
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    //[connection scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    //[connection start];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSLog(@"connect created");
    return _response;
}



/*
 NSURLConnectionDataDelegate implement
 */

// this function only get the status code and all header failed
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    NSLog(@"status code = %ld", (long)[httpResponse statusCode]);
    NSDictionary *headers = [httpResponse allHeaderFields];
    for (NSString *key in [headers allKeys])
    {
        NSLog(@"%@:%@", key, [headers objectForKey:key]);
    }
    _response.headers = [[NSMutableDictionary alloc]initWithDictionary:headers];
    _response.error_code = (NSInteger *)[httpResponse statusCode];
    _response.content_length = (int)[httpResponse expectedContentLength];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
//    NSMutableString *str = [[NSMutableString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    [_response.body appendData:data];
    NSLog(@"didReceiveData");
    _response.loading_rate += (double)data.length /(double)_response.content_length;
    
    [[NSNotificationCenter defaultCenter]postNotificationName:_notificationName object:_response];
    
}

- (void)connection:(NSURLConnection *)connection   didSendBodyData:(NSInteger)bytesWritten
 totalBytesWritten:(NSInteger)totalBytesWritten
totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"connectionDidFinishLoading ...");
    _response.finished = YES;
    [[NSNotificationCenter defaultCenter]postNotificationName:_notificationName object:_response];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError.");
    _response.error_code = -1;
    [[NSNotificationCenter defaultCenter ]postNotificationName:_notificationName object:_response];
}

@end
