//
//  PandaTakePhotoPreviewViewController.m
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/8/31.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import "PandaTakePhotoPreviewViewController.h"

@interface PandaTakePhotoPreviewViewController ()

@end

@implementation PandaTakePhotoPreviewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _image = [[UIImage alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _photoPreview.image = _image;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)photoConfirm:(UIBarButtonItem *)sender {
    NSLog(@"confirm this photo.");
    NSString *recongnize = [self OCRrecongnize:_image];
    
    // 那个项目的照片; 大项->小项->具体
    
    
    
}

- (IBAction)back:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSString *)OCRrecongnize:(UIImage *)image{
    return nil;
}

@end
