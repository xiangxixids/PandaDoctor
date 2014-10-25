//
//  PandaOCRResultViewController.h
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/10/1.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PandaOCRResultViewController : UIViewController<UIAlertViewDelegate>


@property (strong, nonatomic) IBOutlet UITextView *resultTextView;

@property NSMutableArray *postArray;
@property NSArray *dataList;
@property NSInteger checkItemId;
@property NSData *data;

@property BOOL isOCR;
@property NSString *ocrImageName;

@property UIImage *ocrImage;

- (IBAction)saveResult:(UIBarButtonItem *)sender;

- (IBAction)back:(UIBarButtonItem *)sender;

@end
