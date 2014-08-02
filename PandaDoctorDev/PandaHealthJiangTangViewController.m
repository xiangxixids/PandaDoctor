//
//  PandaHealthJiangTangViewController.m
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/8/2.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import "PandaHealthJiangTangViewController.h"

@interface PandaHealthJiangTangViewController ()

@end

@implementation PandaHealthJiangTangViewController

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
    // Do any additional setup after loading the view.
    NSLog(@"PandaHealthJiangTangViewController view did load");
    [self.navigationController.navigationBar setHidden:YES];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellName = @"cell";
    if (indexPath.row == 0) {
        ScrollTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"ScrollTableViewCell" owner:self options:nil] objectAtIndex:0];
        return cell;
    }else{
        
        PandaShareTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"PandaShareTableViewCell" owner:self options:nil] objectAtIndex:0];
        cell.titleLabel.text = @"宝宝如何防止近视呢?";
        cell.hintLabel.text = @"2014-08-00";
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 130;
    }else{
        return 65;
    }
}

// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"select cell %d", indexPath.row);
    
    _jiangtangDetailViewController = [[PandaHealthJiangTangDetailViewController alloc]initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:_jiangtangDetailViewController animated:YES];
    
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

@end
