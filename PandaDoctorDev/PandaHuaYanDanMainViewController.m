//
//  PandaHuaYanDanMainViewController.m
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/8/2.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import "PandaHuaYanDanMainViewController.h"
#import "PandaRPCInterface.h"
#import "PandaLoginViewController.h"

@interface PandaHuaYanDanMainViewController ()
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
    Boolean _keyboardIsVisible;
}
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
    sanDaChangGuiList=[NSArray arrayWithObjects:@"三大常规1",@"三大常规2",@"三大常规3", nil];
    ganZangXiangMuList=[NSArray arrayWithObjects:@"肝脏项目1",@"肝脏项目2",@"肝脏项目3",nil];
    xueTangXueZhiList=[NSArray arrayWithObjects:@"血糖血脂1",@"血糖血脂2",@"血糖血脂3", nil];
    shenZangXiangMuList=[NSArray arrayWithObjects:@"肾脏项目1",@"肾脏项目2",@"肾脏项目3", nil];
    jiaZhuangXianList=[NSArray arrayWithObjects:@"甲状腺1",@"甲状腺2",@"甲状腺3",nil];
    zhongLiuXiangMuList=[NSArray arrayWithObjects:@"肿瘤项目1",@"肿瘤项目2",@"肿瘤项目3",nil];
    youShengXiangMuList=[NSArray arrayWithObjects:@"优生项目1",@"优生项目2",@"优生项目3", nil];
    fuKeXiangMuList=[NSArray arrayWithObjects:@"妇科项目1",@"妇科项目2",@"妇科项目3",nil];
    otherXiangMuList=[NSArray arrayWithObjects:@"其他项目1",@"其他项目2" ,nil];
    
    NSArray *imageList = [NSArray arrayWithObjects:
                          _sanDaChangGuiImage,
                          _ganZangXiangMuImage,
                          _xueTangXueZhiImage,
                          _shenZangXiangMuImage,
                          _jiaZhuangXianImageView,
                          _zhongLiuImageView,
                          _youShengXiangMuImage,
                          _fuKeImage,
                          _otherImage,
                          nil];
    
    PandaRPCInterface *rpcInterface = [[PandaRPCInterface alloc]init];
    NSMutableData *data = [rpcInterface paperSortForApp];
    if (data==nil) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"网络错误"
                                                       message:@"联网错误, 请检查您的网络连接是否正常"
                                                      delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    NSString *datastr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    NSArray *jsonList = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    for (int i=0; i<jsonList.count; i++) {
        
        NSDictionary *dict = [jsonList objectAtIndex:i];
        NSLog(@"dict name = %@", [dict valueForKey:ENG_NM]);
        NSLog(@"dict rcedid= %@", [dict valueForKey:RCRD_ID]);
        
        PandaTapGestureRecognizer *singleTap=[[PandaTapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)];
        singleTap.mid = [[dict valueForKey:RCRD_ID] intValue];
        singleTap.title = [dict valueForKey:ENG_NM];
        [[imageList objectAtIndex:i] setUserInteractionEnabled:YES];
        [[imageList objectAtIndex:i] addGestureRecognizer:singleTap];
    }
    
    
    
    
    // add tap gesture recongnizer for each image
//    PandaTapGestureRecognizer *singleTap1=[[PandaTapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)];
//    singleTap1.mid = 1;
//    singleTap1.itemList = sanDaChangGuiList;
//    singleTap1.title = @"三大常规";
//    _sanDaChangGuiImage.userInteractionEnabled = YES;
//    [_sanDaChangGuiImage addGestureRecognizer:singleTap1];
//    
//    PandaTapGestureRecognizer *singleTap2=[[PandaTapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)];
//    singleTap2.mid = 2;
//    singleTap2.itemList = ganZangXiangMuList;
//    singleTap2.title = @"肝脏项目";
//    _ganZangXiangMuImage.userInteractionEnabled = YES;
//    [_ganZangXiangMuImage addGestureRecognizer:singleTap2];
//    
//    PandaTapGestureRecognizer *singleTap3=[[PandaTapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)];
//    singleTap3.mid = 3;
//    singleTap3.title = @"血糖血脂";
//    singleTap3.itemList = xueTangXueZhiList;
//    _xueTangXueZhiImage.userInteractionEnabled = YES;
//    [_xueTangXueZhiImage addGestureRecognizer:singleTap3];
//    
//    PandaTapGestureRecognizer *singleTap4=[[PandaTapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)];
//    singleTap4.mid = 4;
//    singleTap4.title = @"肾脏项目";
//    singleTap4.itemList = shenZangXiangMuList;
//    _shenZangXiangMuImage.userInteractionEnabled = YES;
//    [_shenZangXiangMuImage addGestureRecognizer:singleTap4];
//    
//    PandaTapGestureRecognizer *singleTap5=[[PandaTapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)];
//    singleTap5.mid = 5;
//    singleTap5.title = @"甲状腺功能";
//    singleTap5.itemList = jiaZhuangXianList;
//    _jiaZhuangXianImageView.userInteractionEnabled = YES;
//    [_jiaZhuangXianImageView addGestureRecognizer:singleTap5];
//    
//    PandaTapGestureRecognizer *singleTap6=[[PandaTapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)];
//    singleTap6.mid = 6;
//    singleTap6.title = @"肿瘤项目";
//    singleTap6.itemList = zhongLiuXiangMuList;
//    _zhongLiuImageView.userInteractionEnabled = YES;
//    [_zhongLiuImageView addGestureRecognizer:singleTap6];
//    
//    PandaTapGestureRecognizer *singleTap7=[[PandaTapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)];
//    singleTap7.mid = 7;
//    singleTap7.title = @"优生项目";
//    singleTap7.itemList = youShengXiangMuList;
//    _youShengXiangMuImage.userInteractionEnabled = YES;
//    [_youShengXiangMuImage addGestureRecognizer:singleTap7];
//    
//    PandaTapGestureRecognizer *singleTap8=[[PandaTapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)];
//    singleTap8.mid = 8;
//    singleTap8.title = @"妇科项目";
//    singleTap8.itemList = fuKeXiangMuList;
//    _fuKeImage.userInteractionEnabled = YES;
//    [_fuKeImage addGestureRecognizer:singleTap8];
//    
//    PandaTapGestureRecognizer *singleTap9=[[PandaTapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTap:)];
//    singleTap9.mid = 9;
//    singleTap9.title = @"其他项目";
//    singleTap9.itemList = otherXiangMuList;
//    _otherImage.userInteractionEnabled = YES;
//    [_otherImage addGestureRecognizer:singleTap9];
//    
//    _huaYanDanConstData = [[PandaConstantData alloc]init];
//    [_huaYanDanConstData initData];
    
    
    // 这里记录键盘是否有弹出
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardDidShow)  name:UIKeyboardDidShowNotification  object:nil];
    [center addObserver:self selector:@selector(keyboardDidHide)  name:UIKeyboardWillHideNotification object:nil];
    _keyboardIsVisible = NO;
    
}

// 这几个函数, 会指明当前键盘的状态, 判断后, 用[self.view endEditing:YES] 结束隐藏键盘, 结束所有的编辑状态.
- (void)keyboardDidShow
{
    _keyboardIsVisible = YES;
}

- (void)keyboardDidHide
{
    _keyboardIsVisible = NO;
}

- (BOOL)keyboardIsVisible
{
    return _keyboardIsVisible;
}

- (void)imageTap:(PandaTapGestureRecognizer*)sender
{
    NSLog(@"imageTap id: %d", sender.mid);
    NSLog(@"itemlist: %@", sender.itemList);
    if ([self keyboardIsVisible]) {
        [self.view endEditing:YES];
        return;
    }
    _huaYanDanXiangMuListViewController = [[PandaHuaYanDanXiangMuListViewController alloc]initWithNibName:nil bundle:nil];
    //_huaYanDanXiangMuListViewController.tableViewItemList = sender.itemList;
    
    _huaYanDanXiangMuListViewController.titleString = sender.title;
    _huaYanDanXiangMuListViewController.itemId = sender.mid;
    _huaYanDanXiangMuListViewController.huaYanDanConstData = _huaYanDanConstData;
    
    [self.navigationController pushViewController:_huaYanDanXiangMuListViewController animated:YES];
    
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

- (IBAction)logOut:(UIBarButtonItem *)sender
{
    [UtilTool globalDataSave:@"0" forKey:LOGIN];
    
    PandaLoginViewController *loginViewController = [[PandaLoginViewController alloc]initWithNibName:nil bundle:nil];
    
    self.view.window.rootViewController = loginViewController;
    
}

- (IBAction)touchDown:(UIControl *)sender {
    NSLog(@"touch down!");
    [self.view endEditing:YES];
}
@end
