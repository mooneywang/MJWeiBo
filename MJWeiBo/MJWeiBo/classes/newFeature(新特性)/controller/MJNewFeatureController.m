//
//  MJNewFeatureController.m
//  MJWeiBo
//
//  Created by 王梦杰 on 16/1/19.
//  Copyright (c) 2016年 Mooney_wang. All rights reserved.
//

#import "MJNewFeatureController.h"
#import "MJTabBarController.h"

#define IMAGECOUNT (4)

@interface MJNewFeatureController ()<UIScrollViewDelegate>

@property(nonatomic ,weak)UIScrollView *scrollView;
@property(nonatomic ,weak)UIPageControl *pageControl;

@end

@implementation MJNewFeatureController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;
    self.scrollView = scrollView;
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    
    for(int i = 0; i < IMAGECOUNT; i++){
        UIImageView *imageView = [[UIImageView alloc] init];
        NSString *name = [NSString stringWithFormat:@"new_feature_%d",i + 1];
        imageView.image = [UIImage imageNamed:name];
        imageView.width = self.scrollView.width;
        imageView.height = self.scrollView.height;
        imageView.y = 0;
        imageView.x = i * imageView.width;
        [self.scrollView addSubview:imageView];
        //在最后一张图片上添加按钮
        if (i == IMAGECOUNT - 1) {
            [self setupImageView:imageView];
        }
    }
    
    self.scrollView.contentSize = CGSizeMake(IMAGECOUNT * self.scrollView.width, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    pageControl.numberOfPages = IMAGECOUNT;
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0.725 alpha:1.000];
    pageControl.centerX = self.view.centerX;
    pageControl.centerY = self.view.height - 30;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)setupImageView:(UIImageView *)imageView{
    //开启imageView的用户交互
    imageView.userInteractionEnabled = YES;
    UIButton *checkBox = [UIButton buttonWithType:UIButtonTypeCustom];
    [imageView addSubview:checkBox];
    checkBox.width = 120;
    checkBox.height = 30;
    checkBox.centerX = imageView.width * 0.5;
    checkBox.centerY = imageView.height * 0.7;
    [checkBox setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [checkBox setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [checkBox setTitle:@"分享朋友圈" forState:UIControlStateNormal];
    [checkBox addTarget:self action:@selector(checkBoxClick:) forControlEvents:UIControlEventTouchUpInside];
    checkBox.titleLabel.font = [UIFont systemFontOfSize:15];
    [checkBox setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    checkBox.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    UIButton *startButton = [[UIButton alloc] init];
    [imageView addSubview:startButton];
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [startButton setTitle:@"开启微博" forState:UIControlStateNormal];
    startButton.size = startButton.currentBackgroundImage.size;
    startButton.centerX = checkBox.centerX;
    startButton.centerY = imageView.height * 0.78;
    [startButton addTarget:self action:@selector(startButtonClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)checkBoxClick:(UIButton *)button{
    button.selected = !button.isSelected;
}

- (void)startButtonClick{
    //销毁新特性控制器
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[MJTabBarController alloc] init];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int currentPage = (self.scrollView.width * 0.5 + self.scrollView.contentOffset.x) / self.scrollView.width;
    self.pageControl.currentPage = currentPage;
}

- (void)dealloc{
    NSLog(@"MJNewFeatureController 被销毁了");
}

@end
