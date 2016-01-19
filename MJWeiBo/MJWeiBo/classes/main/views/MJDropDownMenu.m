//
//  MJDropDownMenu.m
//  MJDropDownMenuDemo
//
//  Created by 王梦杰 on 16/1/18.
//  Copyright (c) 2016年 Mooney_wang. All rights reserved.
//

#import "MJDropDownMenu.h"
#import "UIView+Extension.h"

#define MARGIN (10);

@interface MJDropDownMenu ()

/**
 *  容器视图
 */
@property(nonatomic ,weak)UIImageView *containerView;

@end

@implementation MJDropDownMenu

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //初始化代码
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+ (instancetype)dropDownMenu{
    return [[self alloc] init];
}

/**
 *  容器的懒加载
 */
- (UIImageView *)containerView{
    if (!_containerView) {
        UIImageView *containerView = [[UIImageView alloc] init];
        //开启用户交互
        containerView.userInteractionEnabled = YES;
        NSString *imageName = [@"MJDropDownMenu.bundle" stringByAppendingPathComponent:@"popover_background"];
        UIImage *image = [UIImage imageNamed:imageName];
        CGFloat h = image.size.height * 0.5;
        //将图片以中心点为拉伸点拉伸,且只拉伸垂直方向，不拉伸水平方向
        containerView.image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(h, 0, h, 0) resizingMode:UIImageResizingModeStretch];
        containerView.frame = CGRectMake(0, 0, 217, 217);
        self.containerView = containerView;
        [self addSubview:containerView];
    }
    return _containerView;
}

- (void)setContent:(UIView *)content{
    _content = content;
    //调整内容视图的位置
    content.x = MARGIN;
    content.y = 15;
    //根据内容视图的尺寸来设置容器的尺寸
    self.containerView.height = content.height + content.y + MARGIN;
    self.containerView.width = content.width + 2 * MARGIN;
    [self.containerView addSubview:content];
}

- (void)setContentViewController:(UIViewController *)contentViewController{
    _contentViewController = contentViewController;
    self.content = contentViewController.view;
}

/**
 *  通过点击fromView显示下拉菜单
 */
- (void)showFrom:(UIView *)fromView{
    //获得显示在最前面的window
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    //设置视图的尺寸
    self.frame = window.bounds;
    //调整坐标系
    CGRect newFrame = [fromView convertRect:fromView.bounds toView:window];
    //调整容器的位置
    self.containerView.centerX = CGRectGetMidX(newFrame);
    self.containerView.y = CGRectGetMaxY(newFrame);
    //将视图添加到window上面
    [window addSubview:self];
    //通知代理
    if ([self.delegate respondsToSelector:@selector(dropDownMenuDidShow:)]) {
        [self.delegate dropDownMenuDidShow:self];
    }
}

/**
 *  移除
 */
- (void)dismiss{
    [self removeFromSuperview];
    //通知代理
    if ([self.delegate respondsToSelector:@selector(dropDownMenuDidDismiss:)]) {
        [self.delegate dropDownMenuDidDismiss:self];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self dismiss];
}

@end
