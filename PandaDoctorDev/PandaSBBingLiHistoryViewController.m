//
//  PandaSBBingLiHistoryViewController.m
//  PandaDoctorDev
//
//  Created by xiangxixids on 10/22/14.
//  Copyright (c) 2014 xiangxixids. All rights reserved.
//

#import "PandaSBBingLiHistoryViewController.h"
#import "PandaRPCInterface.h"
#import "PandaBingLiHistoryTableViewCell.h"
#import "UtilTool.h"
#import "PandaBingLiHistoryOCRViewController.h"
#import "PandaBingLiHistoryDetailViewController.h"
#import "PandaNotification.h"

@interface PandaSBBingLiHistoryViewController ()

@end

@implementation PandaSBBingLiHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[PandaBingLiHistoryTableViewCell class] forCellReuseIdentifier:@"cell"];
    //    _tableView.sectionHeaderHeight = 0;
    //    _tableView.sectionFooterHeight = 0;
    //    [_tableView.tableHeaderView setHidden:YES];
    //    [_tableView.tableFooterView setHidden:YES];
    //    _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 115, 320, 1)];
    
    PandaRPCInterface *rpcInterface = [[PandaRPCInterface alloc]init];
    NSString *phone = [UtilTool globalDataGet:PHONE];
    NSMutableData *data = [rpcInterface getUserHistory:phone];
    if (data==nil) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"网络错误"
                                                       message:@"联网错误, 请检查您的网络连接是否正常"
                                                      delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    NSString *datastr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    _tableViewList = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    _dataList = _tableViewList;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadTableViewData:)
                                                 name:HISTORY_TABLEVIEW_UPDATE
                                               object:nil];
    
    
}

- (void)reloadTableViewData:(NSNotification*)notification
{
    if (notification != nil && [notification.name isEqualToString:HISTORY_TABLEVIEW_UPDATE]) {
        NSLog(@"history tableview update...");
        PandaRPCInterface *rpcInterface = [[PandaRPCInterface alloc]init];
        NSString *phone = [UtilTool globalDataGet:PHONE];
        NSMutableData *data = [rpcInterface getUserHistory:phone];
        if (data==nil) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"网络错误"
                                                           message:@"联网错误, 请检查您的网络连接是否正常"
                                                          delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        NSString *datastr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        _dataList = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        [_tableView reloadData];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataList.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (PandaBingLiHistoryTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellname = @"cell";
    PandaBingLiHistoryTableViewCell *cell = nil;//= (PandaBingLiHistoryTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellname];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PandaBingLiHistoryTableViewCell" owner:self options:nil] objectAtIndex:0];
        
    }
    NSString *dateStr = [[_dataList objectAtIndex:indexPath.row] valueForKey:GMTCREATE];
    dateStr = [dateStr stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    //dateStr = [dateStr componentsSeparatedByString:@"T"][0];
    NSString *checkItemStr = [[_dataList objectAtIndex:indexPath.row] valueForKey:SLB_NM];
    NSString *flag = [NSString stringWithFormat:@"%@", [[_dataList objectAtIndex:indexPath.row] valueForKey:FLAG]];
    if (_switchController.selectedSegmentIndex == 0) {
        dateStr = [dateStr componentsSeparatedByString:@" "][0];
        if ( [flag isEqualToString:@"1"] ) {
            cell.date.text = dateStr;
        }
        cell.item.text = checkItemStr;
    }else if (_switchController.selectedSegmentIndex == 1){
        if ( [flag isEqualToString:@"1"] ) {
            cell.date.text = checkItemStr;
        }
        cell.item.text = dateStr;
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"select %d", indexPath.row);
    //
    //    _bingliDetailViewController = [[PandaBingLiHistoryDetailViewController alloc] initWithNibName:nil bundle:nil];
    //
    //    [self.navigationController pushViewController:_bingliDetailViewController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    PandaBingLiHistoryDetailResultViewController *controller = [[PandaBingLiHistoryDetailResultViewController alloc]initWithNibName:nil bundle:nil];
    NSDictionary *dict = [_dataList objectAtIndex:indexPath.row];
    NSString *slb_id = [dict valueForKey:SLB_ID];
    NSString *result = [dict valueForKey:RESULT];
    NSString *slb_name = [dict valueForKey:SLB_NM];
    //NSString *date = [[dict valueForKey:GMTCREATE] componentsSeparatedByString:@"T"][0];
    NSString *date = [dict valueForKey:GMTCREATE];// no need remove the "T"
    controller.SLB_ID = slb_id;
    controller.result = result;
    NSString *phone = [UtilTool globalDataGet:PHONE];
    if ([[UtilTool globalDataGet:slb_id] isEqualToString:@"1"]) {
    //if (1){
        NSLog(@"show ocr image");
        //NSString *ocrImageName = [UtilTool createImageName:phone checkItem:[slb_id intValue] result:result];
        NSString *ocrImageName = [UtilTool createImageNameByDate:date phone:phone checkItem:[slb_id intValue] result:result];
        NSLog(@"%@", ocrImageName);
        if ([UtilTool fileExistInDocument:ocrImageName]) {
            NSLog(@"file exits!!!");
            PandaBingLiHistoryOCRViewController *controller = [[PandaBingLiHistoryOCRViewController alloc]initWithNibName:nil bundle:nil];
            controller.checkItem = slb_id;
            controller.result = result;
            controller.dateTimeString = date;
            controller.huaYanDanNameString = slb_name;
            NSString *imgPath = [NSString stringWithFormat:@"%@/%@", [UtilTool getDocumentPath], ocrImageName];
            UIImage *imgFromUrl3=[[UIImage alloc]initWithContentsOfFile:imgPath];
            controller.default_img = NO;
            controller.ocrImage = imgFromUrl3;
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
            return;
        }else
        {
            NSLog(@"file not there!!!");
            PandaBingLiHistoryOCRViewController *controller = [[PandaBingLiHistoryOCRViewController alloc]initWithNibName:nil bundle:nil];
            controller.checkItem = slb_id;
            controller.result = result;
            controller.dateTimeString = date;
            controller.huaYanDanNameString = slb_name;
            NSString *imgPath = [NSString stringWithFormat:@"%@/%@", [UtilTool getDocumentPath], ocrImageName];
            UIImage *imgFromUrl3=[[UIImage alloc]initWithContentsOfFile:imgPath];
            controller.default_img = YES;
            controller.ocrImage = [UIImage imageNamed:@"Logo.png"];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
            return;
        }
    }else
    {
        NSLog(@"no ocr image");
    }
    
    PandaBingLiHistoryDetailViewController *controller1 = [[PandaBingLiHistoryDetailViewController alloc]initWithNibName:nil bundle:nil];
    controller1.checkItem = slb_id;
    controller1.result = result;
    [self.navigationController pushViewController:controller1 animated:YES];

    return;
    
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSArray *)sortByHuaYanDanType:(NSArray*)orignalList
{
    NSLog(@"sort by huayandan type");
    NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:3];
    
    // find key list
    NSMutableDictionary *keyDict = [[NSMutableDictionary alloc]initWithCapacity:3];
    for (int i=0; i<orignalList.count; i++) {
        NSString *checkItemStr = [[orignalList objectAtIndex:i] valueForKey:SLB_NM];
        [keyDict setObject:@"0" forKey:checkItemStr];
    }
    NSLog(@"%@", [keyDict allKeys]);
    
    // find values from the key , keep the first value flag == 1 and other else flag == 0
    NSArray *keyList = [keyDict allKeys];
    for (int i=0; i<keyList.count; i++) {
        NSString *key = [keyList objectAtIndex:i];
        NSInteger k = 0;
        for (int j=0; j<orignalList.count; j++) {
            NSDictionary *dict = [orignalList objectAtIndex:j];
            NSString *checkItemStr = [dict valueForKey:SLB_NM];
            NSLog(@"item = %@", checkItemStr);
            if ([key isEqualToString:checkItemStr]) {
                if (k==0) {
                    [dict setValue:@"1" forKey:FLAG];
                }else{
                    [dict setValue:@"0" forKey:FLAG];
                }
                [array addObject:dict];
                k++;
            }
            
        }
    }
    return array;
}

- (IBAction)switchHistoryList:(UISegmentedControl *)sender {
    
    NSLog(@"switch histroy list, %d", sender.selectedSegmentIndex);
    NSInteger number = sender.selectedSegmentIndex;
    if (number == 0) {
        _labelOne.text = @"检查时间";
        _labelTwo.text = @"检查项目";
        _dataList = _tableViewList;
        [_tableView reloadData];
    }else if (number == 1){
        _labelOne.text = @"检查项目";
        _labelTwo.text = @"检查时间";
        _dataList = [self sortByHuaYanDanType:_tableViewList];
        [_tableView reloadData];
    }
}
@end
