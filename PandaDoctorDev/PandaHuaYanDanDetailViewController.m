//
//  PandaHuaYanDanDetailViewController.m
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/8/5.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import "PandaHuaYanDanDetailViewController.h"

@interface PandaHuaYanDanDetailViewController ()

@end

@implementation PandaHuaYanDanDetailViewController

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
    
    NSLog(@"view did load!!");
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    PandaRPCInterface *rpcInterface = [[PandaRPCInterface alloc]init];
    NSMutableData *data = [rpcInterface checkItemsForApp:_checkItemId];
    NSString *datastr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    _tableViewDataList = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@", _tableViewDataList);
    
    
    UINavigationItem *item = [_navigationBar.items objectAtIndex:0];
    item.title = _titleName;
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tableViewDataList.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //PandaBingLiHistoryTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"PandaBingLiHistoryTableViewCell" owner:self options:nil] objectAtIndex:0];
    PandaHuaYanDanDetailTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"PandaHuaYanDanDetailTableViewCell" owner:self options:nil] objectAtIndex:0];
    cell.name.text = [[_tableViewDataList objectAtIndex:indexPath.row] valueForKey:ITEM_NM];
    cell.desc.text = [[_tableViewDataList objectAtIndex:indexPath.row] valueForKey:SIGNIFICANCE];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
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

- (IBAction)takePhoto:(UIBarButtonItem *)sender {
    
    NSLog(@"take photo..");
    
    // UIImagePickerControllerCameraDeviceRear 后置摄像头
    // UIImagePickerControllerCameraDeviceFront 前置摄像头
    BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    if (!isCamera) {
        NSLog(@"没有摄像头");
        return ;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    // 编辑模式
    //imagePicker.allowsEditing = YES;
    
    [self  presentViewController:imagePicker animated:YES completion:^{
    }];
    
}

- (IBAction)takePic:(UIButton *)sender {
    
    NSLog(@"take photo..");
    // UIImagePickerControllerCameraDeviceRear 后置摄像头
    // UIImagePickerControllerCameraDeviceFront 前置摄像头
    BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    if (!isCamera) {
        NSLog(@"没有摄像头");
        return ;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.delegate = self;
    // 编辑模式
    //imagePicker.allowsEditing = YES;
    
    [self  presentViewController:imagePicker animated:YES completion:^{
    }];
}

// 选中照片

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"%@", info);
    NSLog(@"take photo over");
    UIImageView  *imageView = (UIImageView *)[self.view viewWithTag:101];
    // UIImagePickerControllerOriginalImage 原始图片
    // UIImagePickerControllerEditedImage 编辑后图片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //imageView.image = image;
    
    
//    _takePhotoPreviewViewController = [[PandaTakePhotoPreviewViewController alloc]initWithNibName:nil bundle:nil];
//    //_takePhotoPreviewViewController.photoPreview.image = image;
//    _takePhotoPreviewViewController.image = image;
//    _takePhotoPreviewViewController.hidesBottomBarWhenPushed = YES;
//    _takePhotoPreviewViewController.checkItemId = _checkItemId;
//    [self.navigationController pushViewController:_takePhotoPreviewViewController animated:YES];
    
    // 那个项目的照片; 大项->小项->具体
    PandaOCRRecongnizeViewController *controller = [[PandaOCRRecongnizeViewController alloc]initWithNibName:nil bundle:nil];
    controller.image = image;
    controller.checkItemId = _checkItemId;
    [self.navigationController pushViewController:controller animated:YES];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
@end
