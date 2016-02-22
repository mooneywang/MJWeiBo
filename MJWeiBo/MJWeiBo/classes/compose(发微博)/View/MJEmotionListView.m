//
//  MJEmotionListView.m
//  MJWeiBo
//
//  Created by 王梦杰 on 16/2/21.
//  Copyright © 2016年 Mooney_wang. All rights reserved.
//

#import "MJEmotionListView.h"

#define MJEmotionListPageSize 20

@interface MJEmotionListView ()

@property(nonatomic ,weak)UIScrollView *scrollView;
@property(nonatomic ,weak)UIPageControl *pageControl;

@end

@implementation MJEmotionListView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        //1.UIScrollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        self.scrollView = scrollView;
        [self addSubview:scrollView];
        self.scrollView.backgroundColor = MJRandomColor;
        
        //2.PageControl
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        self.pageControl = pageControl;
        [self addSubview:pageControl];
        //设置内部的圆点图片,由于_currentPageImage、_pageImage是私有属性，所以用KVC的方式来修改
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"_currentPageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"_pageImage"];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //1.pageControl
    self.pageControl.height = 35;
    self.pageControl.width = self.width;
    self.pageControl.x = 0;
    self.pageControl.y = self.height - self.pageControl.height;
    
    //2.scrollView
    self.scrollView.width = self.width;
    self.scrollView.height = self.height - self.pageControl.height;
    self.scrollView.x = 0;
    self.scrollView.y = 0;
}

- (void)setEmotions:(NSArray *)emotions{
    _emotions = emotions;
    NSLog(@"表情的数量=%d",self.emotions.count);
    //1.设置页数,每页显示20个
    NSUInteger count = (self.emotions.count + MJEmotionListPageSize - 1) / MJEmotionListPageSize;
    self.pageControl.numberOfPages = count;
    //2.设置表情
    
    
}

@end
