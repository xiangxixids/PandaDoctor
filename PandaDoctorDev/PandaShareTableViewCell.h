//
//  PandaShareTableViewCell.h
//  scrollView
//
//  Created by xiangxixids on 14/8/2.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PandaShareTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headerImage;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *hintLabel;

@property (weak, nonatomic) IBOutlet UILabel *author;

@property (weak, nonatomic) IBOutlet UILabel *date;

@end
