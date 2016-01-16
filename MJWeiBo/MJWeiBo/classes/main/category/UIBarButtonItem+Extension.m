//
//  UIBarButtonItem+Extension.m
//  MJWeiBo
//
//  Created by 王梦杰 on 16/1/15.
//  Copyright (c) 2016年 Mooney_wang. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (instancetype)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    //设置按钮的尺寸
    btn.size = btn.currentImage.size;
    //添加点击事件
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
