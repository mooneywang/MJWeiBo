//
//  NSDate+Extension.h
//  MJWeiBo
//
//  Created by 王梦杰 on 16/2/18.
//  Copyright © 2016年 Mooney_wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

/**
 *  判断是否是今年
 */
- (BOOL)isThisYear;

/**
 *  判断是否是昨天
 */
- (BOOL)isYesterday;

/**
 *  判断是否是今天
 */
- (BOOL)isToday;

@end
