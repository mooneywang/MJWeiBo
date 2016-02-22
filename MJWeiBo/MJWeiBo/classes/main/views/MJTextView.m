//
//  MJTextView.m
//  MJWeiBo
//
//  Created by 王梦杰 on 16/2/20.
//  Copyright © 2016年 Mooney_wang. All rights reserved.
//

#import "MJTextView.h"

@implementation MJTextView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //监听通知
        /**
         *  Observer:   谁来监听
         *  selector:   执行方法
         *  name:       通知类型
         *  object:     谁发出的通知（发出通知的对象）
         */
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)textDidChange {
    [self setNeedsDisplay];
}


- (void)drawRect:(CGRect)rect {
    //如果有文字的话就什么也不画
    if (self.hasText) return;
    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSForegroundColorAttributeName] = self.placeholderColor?self.placeholderColor:[UIColor grayColor];
    attrDict[NSFontAttributeName] = self.font;
    CGFloat x = 5;
    CGFloat y = 8;
    CGRect drawRect = CGRectMake(x, y, self.size.width - 2 * x, self.size.height - 2 * y);
    [self.placeholder drawInRect:drawRect withAttributes:attrDict];
}

/**
 *  由于text是父类的属性，所以重写的时候要调用父类的方法
 */
- (void)setText:(NSString *)text{
    [super setText:text];
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}

- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font{
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
