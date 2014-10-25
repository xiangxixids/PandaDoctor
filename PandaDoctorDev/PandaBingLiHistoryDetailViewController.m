//
//  PandaBingLiHistoryDetailViewController.m
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/7/24.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import "PandaBingLiHistoryDetailViewController.h"
#import "PandaRPCInterface.h"

@interface PandaBingLiHistoryDetailViewController ()

@end

@implementation PandaBingLiHistoryDetailViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[PandaBingLiHistoryDetailTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    NSLog(@"checkItem = %@", _checkItem);
    NSLog(@"result = %@", _result);
    
    PandaRPCInterface *rpcInterface = [[PandaRPCInterface alloc]init];
    NSMutableData *data = [rpcInterface checkItemsForApp:[_checkItem intValue]];
    if (data==nil) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"网络错误"
                                                       message:@"联网错误, 请检查您的网络连接是否正常"
                                                      delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    NSString *datastr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    _tableViewDataList = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@", _tableViewDataList);
    
    _checkArray = [_result componentsSeparatedByString:@","];
    
    NSLog(@"checkarray: %@", _checkArray);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tableViewDataList.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (PandaBingLiHistoryDetailTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PandaBingLiHistoryDetailTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"PandaBingLiHistoryDetailTableViewCell" owner:self options:nil] objectAtIndex:0];
    NSDictionary *dict = [_tableViewDataList objectAtIndex:indexPath.row];
    cell.name.text = [dict objectForKey:ITEM_NM];
    if ([[_checkArray objectAtIndex:indexPath.row] isEqualToString:@"1"]) {
        cell.result.text = @"+";
    }else
    {
        cell.result.text = @"-";
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 33;
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

- (IBAction)showResult:(UIBarButtonItem *)sender {
    
    _bingliHistoryResultViewController = [[PandaBingLiHistoryDetailResultViewController alloc]initWithNibName:nil bundle:nil];
    
    _bingliHistoryResultViewController.result = _result;
    _bingliHistoryResultViewController.SLB_ID = _checkItem;
    
    [self.navigationController pushViewController:_bingliHistoryResultViewController animated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)back:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
