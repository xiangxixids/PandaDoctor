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
    _dataList = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
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
    NSString *checkItemStr = [[_dataList objectAtIndex:indexPath.row] valueForKey:SLB_NM];
    cell.date.text = dateStr;
    cell.item.text = checkItemStr;
    
    return cell;
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
    NSString *data = [[dict valueForKey:GMTCREATE] componentsSeparatedByString:@"T"][0];
    controller.SLB_ID = slb_id;
    controller.result = result;
    NSString *phone = [UtilTool globalDataGet:PHONE];
    if ([[UtilTool globalDataGet:slb_id] isEqualToString:@"1"]) {
        NSLog(@"show ocr image");
        NSString *ocrImageName = [UtilTool createImageName:phone checkItem:[slb_id intValue] result:result];
        NSLog(@"%@", ocrImageName);
        if ([UtilTool fileExistInDocument:ocrImageName]) {
            NSLog(@"file exits!!!");
        }else
        {
            NSLog(@"file not there!!!");
        }
    }else
    {
        NSLog(@"no ocr image");
    }
    
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

@end
