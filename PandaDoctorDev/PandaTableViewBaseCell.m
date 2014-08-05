//
//  PandaTableViewBaseCell.m
//  PandaDoctorDev
//
//  Created by xiangxixids on 14/8/4.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import "PandaTableViewBaseCell.h"

@implementation PandaTableViewBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
