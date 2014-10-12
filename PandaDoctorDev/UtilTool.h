//
//  UtilTool.h
//  PandaDoctor
//
//  Created by xiangxixids on 14/6/30.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *PHONE = @"phone";

@interface UtilTool : NSObject

+(NSString *)getRootPath;
+(NSString *)getDocumentPath;

+(Boolean)fileExistInDocument:(NSString *)fileName;
+(Boolean)fileExist:(NSString *)fileName;

+(Boolean)saveFileToPath:(NSString *)fileName path:(NSString *)filePath content:(NSData *)content;
+(NSData *)readFile:(NSString *)fileName path:(NSString *)filePath;

+(Boolean)saveFileInDocument:(NSString *)fileName content:(NSData *)content;
+(NSData *)readFileInDocument:(NSString *)fileName;

+(BOOL)validateMobile:(NSString *)mobileNum;

+(void)globalDataSave:(NSString *)value forKey:(NSString *)key;
+(NSString*)globalDataGet:(NSString *)key;

@end
