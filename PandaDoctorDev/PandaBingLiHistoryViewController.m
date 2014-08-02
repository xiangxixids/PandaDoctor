//
//  PandaBingLiHistoryViewController.m
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/7/23.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import "PandaBingLiHistoryViewController.h"

@interface PandaBingLiHistoryViewController ()

@end

@implementation PandaBingLiHistoryViewController

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
    [_tableView registerClass:[PandaBingLiHistoryTableViewCell class] forCellReuseIdentifier:@"cell"];
//    _tableView.sectionHeaderHeight = 0;
//    _tableView.sectionFooterHeight = 0;
//    [_tableView.tableHeaderView setHidden:YES];
//    [_tableView.tableFooterView setHidden:YES];
//    _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 115, 320, 1)];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (PandaBingLiHistoryTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellname = @"cell";
    PandaBingLiHistoryTableViewCell *cell = nil;//= (PandaBingLiHistoryTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellname];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PandaBingLiHistoryTableViewCell" owner:self options:nil] objectAtIndex:0];
        
    }
    
    cell.date.text = @"2014/7/7";
    cell.item.text = @"检查项目";
    
    return cell;
}

// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"select %d", indexPath.row);
    
    _bingliDetailViewController = [[PandaBingLiHistoryDetailViewController alloc] initWithNibName:nil bundle:nil];
    
    [self.navigationController pushViewController:_bingliDetailViewController animated:YES];
    
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
