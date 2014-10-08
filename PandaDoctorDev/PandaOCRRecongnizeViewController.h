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
#import "PandaOCRTableViewCell.h"

@interface PandaOCRRecongnizeViewController : UIViewController<ClientDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property NSInteger checkItemId;
@property (strong, nonatomic) IBOutlet UITableView *ocrTableView;

@property UIImage *image;
@property NSArray *dataList;

@property NSMutableArray *assResultList;
@property NSMutableArray *postArray;

- (IBAction)confirm:(UIBarButtonItem *)sender;
- (IBAction)confirmByBtn:(UIButton *)sender;

- (IBAction)back:(UIBarButtonItem *)sender;
- (IBAction)touchDown:(UIControl *)sender;

@end
