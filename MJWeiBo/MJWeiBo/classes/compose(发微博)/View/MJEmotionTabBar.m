//
//  MJEmotionTabBar.m
//  MJWeiBo
//
//  Created by 王梦杰 on 16/2/21.
//  Copyright © 2016年 Mooney_wang. All rights reserved.
//

#import "MJEmotionTabBar.h"



@interface MJEmotionTabBar ()

/**
 *  当前选中的按钮
 */
@property(nonatomic, strong)MJEmotionTabBarButton *selectedBtn;

/**
 *  默认按钮
 */
@property(nonatomic, weak)MJEmotionTabBarButton *defaultBtn;

@end

@implementation MJEmotionTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addButtonWithTitle:@"最近" buttonType:MJEmotionTabBarButtonTypeRecent];
        self.defaultBtn = [self addButtonWithTitle:@"默认" buttonType:MJEmotionTabBarButtonTypeDefault];
        [self addButtonWithTitle:@"Emoji" buttonType:MJEmotionTabBarButtonTypeEmoji];
        [self addButtonWithTitle:@"浪小花" buttonType:MJEmotionTabBarButtonTypeLxh];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat buttonW = self.width / self.subviews.count;
    CGFloat buttonH = self.height;
    for (int i =0; i < self.subviews.count; i++) {
        MJEmotionTabBarButton *button = self.subviews[i];
        button.frame = CGRectMake(i * buttonW, 0, buttonW, buttonH);
    }
    
}

- (MJEmotionTabBarButton *)addButtonWithTitle:(NSString *)title buttonType:(MJEmotionTabBarButtonType)type{
    MJEmotionTabBarButton *button = [MJEmotionTabBarButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:MJColor(250, 250, 250) forState:UIControlStateNormal];
    [button setTitleColor:MJColor(180, 180, 180) forState:UIControlStateDisabled];
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    button.adjustsImageWhenHighlighted = NO;
    NSString *bgImage = @"compose_emotion_table_mid_normal";
    NSString *selBgImage = @"compose_emotion_table_mid_selected";
    if (self.subviews.count == 1) {//第一个按钮
        bgImage = @"compose_emotion_table_left_normal";
        selBgImage = @"compose_emotion_table_left_selected";
    }
    if (self.subviews.count == 4) {//最后一个按钮
        bgImage = @"compose_emotion_table_right_normal";
        selBgImage = @"compose_emotion_table_right_selected";
    }
    [button setBackgroundImage:[UIImage imageNamed:bgImage] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:selBgImage] forState:UIControlStateDisabled];
    [self addSubview:button];
    button.tag = type;
//    //默认选中
//    if (type == MJEmotionTabBarButtonTypeDefault) {
//        [self btnClick:button];
//    }
    
    return button;
}

- (void)btnClick:(MJEmotionTabBarButton *)button {
    self.selectedBtn.enabled = YES;
    button.enabled = NO;
    self.selectedBtn = button;
    
    //调用代理方法
    if ([self.delegate respondsToSelector:@selector(emotionTabBar:didClickButtonWithType:)]) {
        [self.delegate emotionTabBar:self didClickButtonWithType:button.tag];
    }
}

/**
 *  代理有值之后再调用代理方法，选中默认按钮
 */
- (void)setDelegate:(id<MJEmotionTabBarDelegate>)delegate{
    _delegate = delegate;
    [self btnClick:self.defaultBtn];
}

@end
