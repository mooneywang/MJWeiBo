//
//  NSString+Extension.h
//  MJWeiBo
//
//  Created by 王梦杰 on 16/2/18.
//  Copyright © 2016年 Mooney_wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

/**
 *  计算字符串的尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;

- (CGSize)sizeWithFont:(UIFont *)font;

@end
