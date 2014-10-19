//
//  PandaRadioTableViewCell.h
//  PandaDoctorDev
//
//  Created by xiangxixids on 10/18/14.
//  Copyright (c) 2014 xiangxixids. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PandaUISwitch.h"
@interface PandaRadioTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet PandaUISwitch *check;


@end
