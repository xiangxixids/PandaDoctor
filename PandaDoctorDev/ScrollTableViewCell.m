//
//  ScrollTableViewCell.m
//  scrollView
//
//  Created by xiangxixids on 14/7/29.
//  Copyright (c) 2014年 xiangxixids. All rights reserved.
//

#import "ScrollTableViewCell.h"

@implementation ScrollTableViewCell



- (void)awakeFromNib
{
    // Initialization code
    NSLog(@"awakeFromNib");
    _photoList = [NSArray arrayWithObjects:[UIImage imageNamed:@"IMG_1.jpg"],
                  [UIImage imageNamed:@"IMG_2.jpg"],
                  [UIImage imageNamed:@"IMG_3.jpg"],
                  [UIImage imageNamed:@"IMG_4.jpg"],nil];
    
    NSInteger pageCount = _photoList.count;
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = pageCount;
    
    //_scrollView.frame = CGRectMake(0, 0, 320, 420); //  如果指定了size 就不要再添加了
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES; // 出现page 效果, 一次只滑动一页
    
    for (NSInteger i=0; i<pageCount; i++) {
        CGRect frame;
        frame.origin.x = _scrollView.frame.size.width*i;
        frame.origin.y = 0;
        frame.size = _scrollView.frame.size;
        frame = CGRectInset(frame, 10.0f, 10.0f); //插入10像素的空白
        
        UIImageView *newPageView = [[UIImageView alloc]initWithImage:[_photoList objectAtIndex:i]];
        newPageView.contentMode = UIViewContentModeScaleAspectFill;
        newPageView.frame = frame;
        
        [_scrollView addSubview:newPageView];
    }
    
    CGSize PagedScrollViewSize = _scrollView.frame.size;
    _scrollView.contentSize = CGSizeMake(PagedScrollViewSize.width*_photoList.count, 0);//(number, 0)禁止上下滑动, (0,number) 禁止左右滑动
    
    
}

-(void)loadVisiblePage{
    CGFloat pageWidth = _scrollView.frame.size.width;
    NSInteger page = (NSInteger)floor((_scrollView.contentOffset.x - pageWidth/2)/pageWidth)+1; // 查找当前page的位置.
    
    _pageControl.currentPage = page;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"scrollViewDidScroll");
    [self loadVisiblePage];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
