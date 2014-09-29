//
//  PandaHuaYanDanXiangMuListViewController.m
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/8/3.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import "PandaHuaYanDanXiangMuListViewController.h"
#import "PandaRPCInterface.h"

@interface PandaHuaYanDanXiangMuListViewController ()
{
    NSArray *sanDaChangGuiList;
    NSArray *ganZangXiangMuList;
    NSArray *xueTangXueZhiList;
    NSArray *shenZangXiangMuList;
    NSArray *jiaZhuangXianList;
    NSArray *zhongLiuXiangMuList;
    NSArray *youShengXiangMuList;
    NSArray *fuKeXiangMuList;
    NSArray *otherXiangMuList;
}
@end

@implementation PandaHuaYanDanXiangMuListViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)initTableViewItems{
//    sanDaChangGuiList=[NSArray arrayWithObjects:@"三大常规1",@"三大常规2",@"三大常规3", nil];
//    ganZangXiangMuList=[NSArray arrayWithObjects:@"肝脏项目1",@"肝脏项目2",@"肝脏项目3",nil];
//    xueTangXueZhiList=[NSArray arrayWithObjects:@"血糖血脂1",@"血糖血脂2",@"血糖血脂3", nil];
//    shenZangXiangMuList=[NSArray arrayWithObjects:@"肾脏项目1",@"肾脏项目2",@"肾脏项目3", nil];
//    jiaZhuangXianList=[NSArray arrayWithObjects:@"甲状腺1",@"甲状腺2",@"甲状腺3",nil];
//    zhongLiuXiangMuList=[NSArray arrayWithObjects:@"肿瘤项目1",@"肿瘤项目2",@"肿瘤项目3",nil];
//    youShengXiangMuList=[NSArray arrayWithObjects:@"优生项目1",@"优生项目2",@"优生项目3", nil];
//    fuKeXiangMuList=[NSArray arrayWithObjects:@"妇科项目1",@"妇科项目2",@"妇科项目3",nil];
//    otherXiangMuList=[NSArray arrayWithObjects:@"其他项目1",@"其他项目2" ,nil];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController.navigationBar setHidden:YES];
    [self initTableViewItems];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    UINavigationItem *item = [_navigationBar.items objectAtIndex:0];
    item.title = _titleString;
    
    
    //_currentData = [self getHuaYanDanData:_itemId];
    _tableViewItemList = [self getHuaYanDanData:_itemId];
    
    
    
}

- (NSArray *)getHuaYanDanData:(int)mid{
    PandaRPCInterface *rpcInterface = [[PandaRPCInterface alloc]init];
    NSMutableData *data = [rpcInterface paperForApp:mid];
    NSString *datastr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSArray *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@", jsonData);
    return jsonData;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tableViewItemList.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellname = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellname];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
    }
    
    NSDictionary *dict = [_tableViewItemList objectAtIndex:indexPath.row];
    cell.textLabel.text = [dict valueForKey:SLB_NM];
//    cell.huaYanDanData = _currentData;
//    cell.mid = indexPath.row;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"select id: %d",  (int)indexPath.row);
    
    _huaYanDanDetailViewController = [[PandaHuaYanDanDetailViewController alloc]initWithNibName:nil bundle:nil];
    _huaYanDanDetailViewController.hidesBottomBarWhenPushed = YES;
    _huaYanDanDetailViewController.checkItemId = [[[_tableViewItemList objectAtIndex:indexPath.row] valueForKey:RCRD_ID] intValue];
    
    [self.navigationController pushViewController:_huaYanDanDetailViewController animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)back:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
