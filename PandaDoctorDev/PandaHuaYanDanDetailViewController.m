//
//  PandaHuaYanDanDetailViewController.m
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/8/5.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import "PandaHuaYanDanDetailViewController.h"
#import "PandaHuaYanDanRadioCheckViewController.h"
#import "UtilTool.h"

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
    
    
    // GCD start
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
        _data = [rpcInterface checkItemsForApp:_checkItemId];
        
        // tell main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            [_showTimer invalidate];
            [_indicatorPop stopAnimating];
            [_tableView reloadData];
            
            // code replace and tableview reload data
            if (_data==nil) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"网络错误"
                                                               message:@"联网错误, 请检查您的网络连接是否正常"
                                                              delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                return;
            }
            
            
            
            NSString *datastr = [[NSString alloc]initWithData:_data encoding:NSUTF8StringEncoding];
            _tableViewDataList = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@", _tableViewDataList);
            [_tableView reloadData];
            
            UINavigationItem *item = [_navigationBar.items objectAtIndex:0];
            item.title = _titleName;
            
            if ([_isOCR isEqualToString:@"1"]) {
                //        _btnTakePhoto.titleLabel.text = @"一键拍单";
                [_btnTakePhoto setTitle:@"一键拍单" forState:UIControlStateNormal];
                _barItemTakePhoto.title = @"拍化验单";
                [UtilTool globalDataSave:@"1" forKey:[NSString stringWithFormat:@"%d",_checkItemId]]; // 这里直接记录当前checkid 是否能够OCR, 在history 里面用到这个
            }else{
                //        _btnTakePhoto.titleLabel.text = @"填化验单";
                [_btnTakePhoto setTitle:@"填化验单" forState:UIControlStateNormal];
                _barItemTakePhoto.title = @"填化验单";
                [UtilTool globalDataSave:@"0" forKey:[NSString stringWithFormat:@"%d",_checkItemId]]; // 这里也记录一下是否可以ocr
            }
        });
    });
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

- (void)goToHuaYanDanRadioCheck
{
    NSLog(@"goToHuaYanDanRadioCheck");
    PandaHuaYanDanRadioCheckViewController *controller = [[PandaHuaYanDanRadioCheckViewController alloc]initWithNibName:nil bundle:nil];
    controller.checkItemId = _checkItemId;
    
    [self.navigationController pushViewController:controller animated:YES];
    
    
}

- (IBAction)takePhoto:(UIBarButtonItem *)sender {
    
    NSLog(@"take photo..");
    
    if (![_isOCR isEqualToString:@"1"]) {
        NSLog(@"can not support OCR");
        [self goToHuaYanDanRadioCheck];
        return;
    }
    
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
    
    if (![_isOCR isEqualToString:@"1"]) {
        NSLog(@"can not support OCR");
        [self goToHuaYanDanRadioCheck];
        return;
    }
    
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
    
    
    // 测试照片, 先存储, 后
//    NSData *data;
//    if (UIImagePNGRepresentation(image) == nil) {
//        data = UIImageJPEGRepresentation(image, 1);
//        NSLog(@"JPEG");
//    } else {
//        data = UIImagePNGRepresentation(image);
//        NSLog(@"PNG");
//    }
    
//    data = UIImagePNGRepresentation(image);
//    data = UIImageJPEGRepresentation(image, 1);
//    [UtilTool saveFileInDocument:@"123.jpg" content:data];
//    
//    NSString *aPath3=[UtilTool getImagePath:@"123.jpg"];
//    UIImage *imgFromUrl3=[[UIImage alloc]initWithContentsOfFile:aPath3];
//    UIImageView* imageView3=[[UIImageView alloc]initWithImage:imgFromUrl3];
//    
//    UIImage *image1 = imgFromUrl3;
    
//    _takePhotoPreviewViewController = [[PandaTakePhotoPreviewViewController alloc]initWithNibName:nil bundle:nil];
//    //_takePhotoPreviewViewController.photoPreview.image = image;
//    _takePhotoPreviewViewController.image = image1;
//    _takePhotoPreviewViewController.hidesBottomBarWhenPushed = YES;
//    _takePhotoPreviewViewController.checkItemId = _checkItemId;
//    [self.navigationController pushViewController:_takePhotoPreviewViewController animated:YES];
//    [picker dismissViewControllerAnimated:YES completion:NULL];
//    return;
    //
    
    // 那个项目的照片; 大项->小项->具体
    PandaOCRRecongnizeViewController *controller = [[PandaOCRRecongnizeViewController alloc]initWithNibName:nil bundle:nil];
    controller.image = image;
    controller.checkItemId = _checkItemId;
    [self.navigationController pushViewController:controller animated:YES];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
@end
