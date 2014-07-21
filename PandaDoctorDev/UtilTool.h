//
//  UtilTool.h
//  PandaDoctor
//
//  Created by xiangxixids on 14/6/30.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UtilTool : NSObject

+(NSString *)getRootPath;
+(NSString *)getDocumentPath;

+(Boolean)fileExistInDocument:(NSString *)fileName;
+(Boolean)fileExist:(NSString *)fileName;

+(Boolean)saveFileToPath:(NSString *)fileName path:(NSString *)filePath content:(NSData *)content;
+(NSData *)readFile:(NSString *)fileName path:(NSString *)filePath;

+(Boolean)saveFileInDocument:(NSString *)fileName content:(NSData *)content;
+(NSData *)readFileInDocument:(NSString *)fileName;

@end
