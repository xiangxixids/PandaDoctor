//
//  PandaOCRRecongnizeViewController.h
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/8/31.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Client.h"
#import "PandaAssay.h"

@interface PandaOCRRecongnizeViewController : UIViewController<ClientDelegate>


@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property NSInteger checkItemId;

@property UIImage *image;
@property NSArray *dataList;

- (IBAction)confirm:(UIBarButtonItem *)sender;

- (IBAction)back:(UIBarButtonItem *)sender;

@end
