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
    
    dispatch_queue_t queue = dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _indicatorPop.hidden = NO;
    [_indicatorPop startAnimating];
    [_indicatorPop setHidesWhenStopped:YES];
    
    _ayncThreadStop = NO;
    _showTimer = [NSTimer scheduledTimerWithTimeInterval:TIMEOUTFORNETWORK target:self
                                                selector:@selector(mytimeout) userInfo:nil repeats:YES];
    dispatch_async(queue, ^{
        NSLog(@"test result");
        
        // do network job
        PandaRPCInterface *rpcInterface = [[PandaRPCInterface alloc]init];
        _data = [rpcInterface paperSortForApp];
        // tell the main thread when job done
        if (_ayncThreadStop == YES) {
            NSLog(@"aync thread should stop now");
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_data==nil) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"网络错误"
                                                               message:@"联网错误, 请检查您的网络连接是否正常"
                                                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                return;
            }
            [_showTimer invalidate];
            [_indicatorPop stopAnimating];
            NSString *datastr = [[NSString alloc]initWithData:_data encoding:NSUTF8StringEncoding];
            
            NSArray *jsonList = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingMutableContainers error:nil];
            
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
            
            
            // 这里记录键盘是否有弹出
            NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
            [center addObserver:self selector:@selector(keyboardDidShow)  name:UIKeyboardDidShowNotification  object:nil];
            [center addObserver:self selector:@selector(keyboardDidHide)  name:UIKeyboardWillHideNotification object:nil];
            _keyboardIsVisible = NO;
        });
    });
    
}

- (void)mytimeout{
    NSLog(@"time out");
    NSLog(@"XXXXXXXXmain thread start");
    [_indicatorPop stopAnimating];
    _ayncThreadStop = YES;
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"连接超时"
                                                   message:@"连接超时, 请检查您的网络连接是否正常"
                                                  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
//{
//    
//    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
//    
//}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

- (BOOL)shouldAutorotate
{
    
    return NO;
    
}

- (NSUInteger)supportedInterfaceOrientations

{
    
    return UIInterfaceOrientationMaskPortrait;//只支持这一个方向(正常的方向)
    
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
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
    _huaYanDanXiangMuListViewController.hidesBottomBarWhenPushed = YES;
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
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:loginViewController];
    self.view.window.rootViewController = navi;
    
//    if (self.navigationController == nil) {
//        self.navigationController = [[UINavigationController alloc] init];
//    }
    
//    self.view.window.rootViewController = self.navigationController;
    
}

- (IBAction)touchDown:(UIControl *)sender {
    NSLog(@"touch down!");
    [self.view endEditing:YES];
}
@end
