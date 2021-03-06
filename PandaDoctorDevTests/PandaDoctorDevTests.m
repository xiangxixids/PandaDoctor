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

-(void)testResultForapp
{
    rpcInterface = [[PandaRPCInterface alloc]init];
    NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:3];
    
    for (int i=1; i<6; i++) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithCapacity:3];
        [dict setValue:@"0" forKey:RESULT];
        if (i==1) {
            [dict setValue:@"1" forKey:RCRD_ID];
        }
        if (i==2) {
            [dict setValue:@"2" forKey:RCRD_ID];
        }
        if (i==3) {
            [dict setValue:@"3" forKey:RCRD_ID];
        }
        if (i==4) {
            [dict setValue:@"4" forKey:RCRD_ID];
        }
        if (i==5) {
            [dict setValue:@"5" forKey:RCRD_ID];
        }
//        [dict setValue:[[_dataList objectAtIndex:i] valueForKey:RCRD_ID] forKey:RCRD_ID];
//        [dict setValue:@"0" forKey:RESULT];
        [array addObject:dict];
    }
    [rpcInterface resultForApp:1 checkItemIds:array];
    
    
}

- (void)testContains
{
    NSString *string1 = @"this is hello world!";
    NSString *string2 = @"iso";
    if ([self containString:string1 contains:string2]) {
        NSLog(@"contain");
    }else{
        NSLog(@"not contain");
    }
}

- (Boolean)containString:(NSString *)orignal contains:(NSString*)string
{
    NSRange range = [orignal rangeOfString:string];
    if (range.location != NSNotFound) {
        return true;
    }
    if (range.length > 0) {
        return true;
    }else{
        return false;
    }
    return false;
}

- (void)testinsertUserHistory
{
    rpcInterface = [[PandaRPCInterface alloc]init];
    NSMutableData *data = [rpcInterface insertUserHistory:@"15928807881" resultList:@"1,0,0,0,0,0,0,0,0,0,0,0,0" checkItem:@"5"];
    NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"string = %@", string);
}

- (void)testgetUserHistory
{
    rpcInterface = [[PandaRPCInterface alloc]init];
    NSMutableData *data = [rpcInterface getUserHistory:@"15928807881"];
    NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"string = %@", string);
    //result: [{"ENG_NM":"Liver_Function","SLB_ID":"5","SLB_NM":"肝功能","gmtCreate":"2014-10-12T11:01:00","id":1,"result":"0,0,0,0,0,0,0,0,0,0,0,0,0","tel":"13679084298"}]
}

- (void)testresltHistoryForApp
{
    rpcInterface = [[PandaRPCInterface alloc]init];
    NSMutableData *data = [rpcInterface resultHistoryForApp:@"0,0,0,0,0,0,0,0,0,0,0,0,0" checkItem:@"5"];
    NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"string = %@", string);
}

- (void)testgetallariticle
{
    rpcInterface = [[PandaRPCInterface alloc]init];
    NSMutableData *data = [rpcInterface getAllAriticle];
    NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"string = %@", string);
}

- (void)testgetArticleByIdForApp
{
    rpcInterface = [[PandaRPCInterface alloc]init];
    NSMutableData *data = [rpcInterface getArticleByIdForApp:@"1"];
    NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"string = %@", string);
}
//- (NSMutableData*)getArticleByIdForApp:(NSString*)article_id;

- (void)testSaveData
{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *name =@"test122222";
    [defaults setObject:name forKey:@"name"];
    [defaults synchronize];//用synchronize方法把数据持久化到standardUserDefaults数据库
}

- (void)testGetdata
{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *name = [defaults objectForKey:@"name"];//根据键值取出name
    NSLog(@"name=%@",name);
}
- (void)testCreateImageName
{
    //NSLog([self createImageName:@"15928807881" checkItem:@"5" result:@"0,1,0,0,1,1,1,1"]);
}
@end
