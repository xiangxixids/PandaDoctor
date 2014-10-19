//
//  PandaHuaYanDanRadioCheckViewController.m
//  PandaDoctorDev
//
//  Created by xiangxixids on 10/18/14.
//  Copyright (c) 2014 xiangxixids. All rights reserved.
//

#import "PandaHuaYanDanRadioCheckViewController.h"
#import "PandaRadioTableViewCell.h"
#import "PandaRPCInterface.h"
#import "PandaOCRResultViewController.h"

@interface PandaHuaYanDanRadioCheckViewController ()

@end

@implementation PandaHuaYanDanRadioCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"PandaHuaYanDanRadioCheckViewController didload");
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    PandaRPCInterface *rpcInterface = [[PandaRPCInterface alloc]init];
    NSMutableData *data = [rpcInterface checkItemsForApp:_checkItemId];
    if (data==nil) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"网络错误"
                                                       message:@"联网错误, 请检查您的网络连接是否正常"
                                                      delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    NSString *datastr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    _dataList = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%lu", (unsigned long)_dataList.count);
    
    // init post data
    _postArray = [[NSMutableArray alloc]initWithCapacity:3];
    
    for (int i=0; i<_dataList.count; i++)
    {
        // 字典中, 存放两个值 , 一个是RCRD_ID  也就是post时, checkItemIds的内容,
        // 第二个值, 就是该项的一个化验单值 , 这个值是0,1,3, 我们给定默认值0, 在检查时, 动态修改postArray 里面的值.
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithCapacity:3];
        [dict setValue:[[_dataList objectAtIndex:i] valueForKey:RCRD_ID] forKey:RCRD_ID];
        [dict setValue:@"0" forKey:RESULT];
        [_postArray addObject:dict]; // dict 存放在array 中
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataList.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PandaRadioTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"PandaRadioTableViewCell" owner:self options:nil] objectAtIndex:0];
    
    NSDictionary *dict = [_dataList objectAtIndex:indexPath.row];
    
    cell.title.text = [dict valueForKey:ITEM_NM];
    cell.check.mid = indexPath.row;
    
    [cell.check addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    
    return cell;
    
}

- (void)switchAction:(id)sender
{
    PandaUISwitch *switchButton = (PandaUISwitch *)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        //showSwitchValue.text = @"是";
        NSLog(@"id is %d", switchButton.mid);
        NSLog(@"switch is 1");
        [self updatePostData:switchButton.mid value:1]; // 阳
    }else {
        NSLog(@"id is %d", switchButton.mid);
        NSLog(@"switch is 0");
        [self updatePostData:switchButton.mid value:0]; // 阴
    }
    
}

- (void)updatePostData:(NSInteger)mid value:(NSInteger)value
{
    // 这种情况下, 只需要修改, mid 对应的value值, 只有"-" 表示正常, "+" 表示超过
    
    NSDictionary *dict = [_postArray objectAtIndex:mid];
    NSString *result = [NSString stringWithFormat:@"%d", value];
    [dict setValue:result forKey:RESULT]; // 修改result
    [_postArray replaceObjectAtIndex:mid withObject:dict];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (IBAction)back:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)confirm:(UIBarButtonItem *)sender {
    
    NSLog(@"confirm");
    NSLog(@"%@", _dataList);
    PandaRPCInterface *rpcInterface = [[PandaRPCInterface alloc]init];
    NSMutableData *data = [rpcInterface resultForApp:_checkItemId checkItemIds:_postArray];
    if (data==nil) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"网络错误"
                                                       message:@"联网错误, 请检查您的网络连接是否正常"
                                                      delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    NSString *datastr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSArray *dataList = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%lu", (unsigned long)dataList.count);
    
    PandaOCRResultViewController *ocrResultViewController = [[PandaOCRResultViewController alloc]initWithNibName:nil bundle:nil];
    ocrResultViewController.postArray = _postArray;
    ocrResultViewController.checkItemId = _checkItemId;
    ocrResultViewController.data = data;
    
    [self.navigationController pushViewController:ocrResultViewController animated:YES];
    
}
@end
