//
//  UtilTool.m
//  PandaDoctor
//
//  Created by xiangxixids on 14/6/30.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import "UtilTool.h"

@implementation UtilTool


+(NSString *)getRootPath
{
    //NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return nil;
}

+(NSString *)getDocumentPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    return documentDirectory;
}

+(Boolean)fileExistInDocument:(NSString *)fileName
{
    NSString *_fileName = [[NSString alloc]initWithFormat:@"%@/%@", [self getDocumentPath],fileName];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:_fileName]) {
        NSLog(@"%@ is there!", _fileName);
        return YES;
    }else{
        NSLog(@"%@ is not exist!", _fileName);
        return NO;
    }
}

+(Boolean)fileExist:(NSString *)fileName
{
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:fileName]) {
        NSLog(@"%@ is there!", fileName);
        return YES;
    }else{
        NSLog(@"%@ is not exist!", fileName);
        return NO;
    }
}

+(Boolean)saveFileToPath:(NSString *)fileName path:(NSString *)filePath content:(NSData *)content
{
    NSString *_file = [NSString stringWithFormat:@"%@%s%@", filePath, "/", fileName];
    return [content writeToFile:_file atomically:YES];
}
+(NSData *)readFile:(NSString *)fileName path:(NSString *)filePath
{
    NSString *_file = [[NSString alloc]initWithFormat:@"%@%s%@", filePath, "/", fileName];
    if ([self fileExist:filePath]) {
        return [[NSData alloc]initWithContentsOfFile:_file];
    }else{
        return nil;
    }
    
}
+(Boolean)saveFileInDocument:(NSString *)fileName content:(NSData *)content
{
    NSString *_filename = [NSString stringWithFormat:@"%@/%@", [self getDocumentPath], fileName];
    NSLog(@"filename = %@", _filename);
    return [content writeToFile:_filename
                     atomically:YES];
}
+(NSData *)readFileInDocument:(NSString *)fileName
{
    NSString *_fileName = [[NSString alloc]initWithFormat:@"%@/%@",[self getDocumentPath],fileName];
    NSLog(@"read file from %@", _fileName);
    if ([self fileExist:_fileName]) {
        return [[NSData alloc]initWithContentsOfFile:_fileName];
    }else{
        return nil;
    }
}

+(BOOL)validateMobile:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+(void)globalDataSave:(NSString *)value forKey:(NSString *)key
{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:key];
    [defaults synchronize];//用synchronize方法把数据持久化到standardUserDefaults数据库
}
+(NSString*)globalDataGet:(NSString *)key
{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *name = [defaults objectForKey:key];//根据键值取出name
    NSLog(@"name=%@",name);
    return name;
}

@end
