//
//  PandaHuaYanDanMainViewController.m
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/8/2.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import "PandaHuaYanDanMainViewController.h"

@interface PandaHuaYanDanMainViewController ()

@end

@implementation PandaHuaYanDanMainViewController

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
    
    // add tap gesture recongnizer for each image
    PandaTapGestureRecognizer *singleTap1=[[PandaTapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)];
    singleTap1.mid = 1;
    _sanDaChangGuiImage.userInteractionEnabled = YES;
    [_sanDaChangGuiImage addGestureRecognizer:singleTap1];
    
    PandaTapGestureRecognizer *singleTap2=[[PandaTapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)];
    singleTap2.mid = 2;
    _ganZangXiangMuImage.userInteractionEnabled = YES;
    [_ganZangXiangMuImage addGestureRecognizer:singleTap2];
    
    PandaTapGestureRecognizer *singleTap3=[[PandaTapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)];
    singleTap3.mid = 3;
    _xueTangXueZhiImage.userInteractionEnabled = YES;
    [_xueTangXueZhiImage addGestureRecognizer:singleTap3];
    
    PandaTapGestureRecognizer *singleTap4=[[PandaTapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)];
    singleTap4.mid = 4;
    _shenZangXiangMuImage.userInteractionEnabled = YES;
    [_shenZangXiangMuImage addGestureRecognizer:singleTap4];
    
    PandaTapGestureRecognizer *singleTap5=[[PandaTapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)];
    singleTap5.mid = 5;
    _jiaZhuangXianImageView.userInteractionEnabled = YES;
    [_jiaZhuangXianImageView addGestureRecognizer:singleTap5];
    
    PandaTapGestureRecognizer *singleTap6=[[PandaTapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)];
    singleTap6.mid = 6;
    _zhongLiuImageView.userInteractionEnabled = YES;
    [_zhongLiuImageView addGestureRecognizer:singleTap6];
    
    PandaTapGestureRecognizer *singleTap7=[[PandaTapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)];
    singleTap7.mid = 7;
    _youShengXiangMuImage.userInteractionEnabled = YES;
    [_youShengXiangMuImage addGestureRecognizer:singleTap7];
    
    PandaTapGestureRecognizer *singleTap8=[[PandaTapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)];
    singleTap8.mid = 8;
    _fuKeImage.userInteractionEnabled = YES;
    [_fuKeImage addGestureRecognizer:singleTap8];
    
    PandaTapGestureRecognizer *singleTap9=[[PandaTapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)];
    singleTap9.mid = 9;
    _otherImage.userInteractionEnabled = YES;
    [_otherImage addGestureRecognizer:singleTap9];
    
}

- (void)imageTap:(PandaTapGestureRecognizer*)sender
{
    NSLog(@"imageTap id: %d", sender.mid);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellname=@"cell";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellname];
    
    cell.textLabel.text = @"haha";
    
    
    return cell;
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
