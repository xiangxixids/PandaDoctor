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

@end
