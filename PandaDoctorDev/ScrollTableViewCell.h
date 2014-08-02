//
//  ScrollTableViewCell.h
//  scrollView
//
//  Created by xiangxixids on 14/7/29.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollTableViewCell : UITableViewCell<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) NSArray *photoList;
-(void)loadVisiblePage;
@end
