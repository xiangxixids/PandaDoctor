//
//  UtilTool.h
//  PandaDoctor
//
//  Created by xiangxixids on 14/6/30.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *PHONE = @"phone";
static NSString *TEMPNAME = @"temp.jpg";
static NSString *LOGIN = @"login";
static NSInteger TIMEOUTFORNETWORK = 15.0;

@interface UtilTool : NSObject

+(NSString *)getRootPath;
+(NSString *)getDocumentPath;

+(Boolean)fileExistInDocument:(NSString *)fileName;
+(Boolean)fileExist:(NSString *)fileName;

+(Boolean)saveFileToPath:(NSString *)fileName path:(NSString *)filePath content:(NSData *)content;
+(NSData *)readFile:(NSString *)fileName path:(NSString *)filePath;

+(Boolean)saveFileInDocument:(NSString *)fileName content:(NSData *)content;
+(NSData *)readFileInDocument:(NSString *)fileName;

+(void)deleteFile:(NSString *)path;
+(NSString*)getImagePath:(NSString *)imageName;

+(BOOL)validateMobile:(NSString *)mobileNum;

+(void)globalDataSave:(NSString *)value forKey:(NSString *)key;
+(NSString*)globalDataGet:(NSString *)key;
+(NSData*)globalImageDataGet:(NSString *)name;
+(BOOL)globalImageDataSave:(NSData *)imageData forName:(NSString *)name;
+(NSString*)createImageName:(NSString *)phone checkItem:(NSInteger)checkItem result:(NSString*)result;
+ (NSString*)createImageNameByDate:(NSString*)date phone:(NSString *)phone checkItem:(NSInteger)checkItem result:(NSString*)result;

@end
