//
//  MJTabBar.m
//  MJWeiBo
//
//  Created by 王梦杰 on 16/1/19.
//  Copyright (c) 2016年 Mooney_wang. All rights reserved.
//

#import "MJTabBar.h"

@interface MJTabBar ()

@property(nonatomic ,weak)UIButton *plusButton;

@end

@implementation MJTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //添加中间的按钮
        UIButton *plusButton = [[UIButton alloc] init];
        self.plusButton = plusButton;
        [self addSubview:plusButton];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [plusButton addTarget:self action:@selector(plusButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    int index = 0;
    CGFloat buttonWidth = self.width / 5;
    
    //设置plusButton的位置
    self.plusButton.centerX = self.width * 0.5;
    self.plusButton.centerY = self.height * 0.5;
    self.plusButton.size = self.plusButton.currentBackgroundImage.size;
    
    for (UIView *childView in self.subviews) {
        if ([childView isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            childView.width = buttonWidth;
            childView.x = buttonWidth * index;
            index++;
            if (index == 2) {
                index++;
            }
        }
    }
}

- (void)plusButtonClick:(UIButton *)plusButton{
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.delegate tabBarDidClickPlusButton:plusButton];
    }
}

@end
