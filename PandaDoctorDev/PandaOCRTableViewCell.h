//
//  PandaOCRTableViewCell.h
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/9/30.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PandaUITextField.h"

@interface PandaOCRTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *OCR_name;
@property (strong, nonatomic) IBOutlet PandaUITextField *OCR_value;
@property (strong, nonatomic) IBOutlet PandaUITextField *REF_low;
@property (strong, nonatomic) IBOutlet PandaUITextField *REF_high;
@property (strong, nonatomic) IBOutlet PandaUITextField *OCR_unit;



@end
