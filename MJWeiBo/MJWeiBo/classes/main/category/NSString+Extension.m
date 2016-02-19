//
//  NSString+Extension.m
//  MJWeiBo
//
//  Created by 王梦杰 on 16/2/18.
//  Copyright © 2016年 Mooney_wang. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

/**
 *  计算字符串的尺寸
 *
 *  @param font 字体
 *  @param maxW 最大宽度
 *
 *  @return 尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW{
    NSDictionary *attrDict = @{NSFontAttributeName : font};
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrDict context:nil].size;
}

/**
 *  计算字符串的尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font{
    return [self sizeWithFont:font maxW:MAXFLOAT];
}

@end
