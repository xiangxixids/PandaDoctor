//
//  PandaDoctorDevTests.m
//  PandaDoctorDevTests
//
//  Created by xiangxixids on 14/7/13.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PandaRPCInterface.h"

@interface PandaDoctorDevTests : XCTestCase
{
    PandaRPCInterface *rpcInterface;
}
@end

@implementation PandaDoctorDevTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPaperSortForApp
{
    rpcInterface = [[PandaRPCInterface alloc]init];
    NSMutableData *data = [rpcInterface paperSortForApp];
    NSString *datastr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@", jsonData);
}

- (void)testpaperForApp
{
    rpcInterface = [[PandaRPCInterface alloc]init];
    NSMutableData *data = [rpcInterface paperForApp:25];
    NSString *datastr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@", jsonData);
}

- (void)testcheckItemsForApp
{
    rpcInterface = [[PandaRPCInterface alloc]init];
    NSMutableData *data = [rpcInterface checkItemsForApp:1];
    NSString *datastr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@", jsonData);
}

- (void)testRegisterAction
{
    rpcInterface = [[PandaRPCInterface alloc]init];
    NSMutableData *data = [rpcInterface registerForAPP:@"13880945600" passwd:@"hahahaha" confirm:@"hahahaha"];
    NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"string = %@", string);
    
}


-(void)testParseResult
{
    NSString *result = @"湖南邵阳县城关镇医院生化检验报告单\r\n姓名：罗文 科别：门诊	性别：男	年龄：22岁 ^号：	标本类型：血		检验编号：100003 备注：	\r\n项目名称	代号	结果	参考值	单位\r\n谷草转氨酶	AST	27.2	5-40	U/L\r\n谷丙转氨酶	ALT	39.9	0-40	U/L\r\n谷草/谷丙	AST/ALT	0.7	1	1-2.5	\r\n碱性磷酸酶	ALP	165.0	1 0-100	U/L |\r\n总蛋白	TP	82.2	60-83	g/L\r\n白蛋白.	ALB	45.8	35-55	g/L\r\n球蛋白	GLB	36.4	20-40	g/L\r\n白/球比例	A/G	1.25	1-2. 5	\r\n总胆红素	TBIL	7.9	0-20. 7	umol/L\r\n直接胆红素	DBIL	3.2	0-6	umol/L\r\n间接红素 乙肝表面抗原	IBIL HBsAg	4.7 . 阳性	0-10	umol/L\r\n送检医生伍小凤	检验日期2010督05	报告日期2010-03-05 检验者刘玲玲\r\n此检验结果仅对此标本负责！";
    
}

@end
