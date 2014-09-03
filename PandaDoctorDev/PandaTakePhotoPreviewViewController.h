//
//  PandaTakePhotoPreviewViewController.h
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/8/31.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PandaTakePhotoPreviewViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *photoPreview;

@property UIImage *image;

- (IBAction)photoConfirm:(UIBarButtonItem *)sender;

- (IBAction)back:(UIBarButtonItem *)sender;

- (NSString *)OCRrecongnize:(UIImage *)image;

@end
