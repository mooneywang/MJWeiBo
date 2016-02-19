//
//  MJTitleButton.m
//  MJWeiBo
//
//  Created by 王梦杰 on 16/1/24.
//  Copyright (c) 2016年 Mooney_wang. All rights reserved.
//

#import "MJTitleButton.h"

#define MJMargin 5 //文字和图片之间的间距

@implementation MJTitleButton

/**
 *  初始化按钮
 */
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    }
    return self;
}

/**
 *  调整按钮内部子控件的位置
 */
- (void)layoutSubviews{
    [super layoutSubviews];
    
    //调整titleLabel
    self.titleLabel.x = 0;
    
    //调整imageView
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + MJMargin;
}

/**
 *  重写以下两个方法，主要是为了调用sizeToFit方法，每次给内部控件赋值的时N候，都是按钮调整自己的尺寸
 */
- (void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    //调整按钮的尺寸以适应内部的子控件大小
    [self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state{
    [super setImage:image forState:state];
    [self sizeToFit];
}


- (void)setFrame:(CGRect)frame{
    frame.size.width += MJMargin;
    [super setFrame:frame];
}

@end
