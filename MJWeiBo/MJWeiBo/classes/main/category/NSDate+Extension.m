//
//  NSDate+Extension.m
//  MJWeiBo
//
//  Created by 王梦杰 on 16/2/18.
//  Copyright © 2016年 Mooney_wang. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

/**
 *  判断是否是今年
 */
- (BOOL)isThisYear{
    //获得日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //设置需要获取的时间组件（年月日时分秒），这里只需要获取年
    NSCalendarUnit unit = NSCalendarUnitYear;
    //获得某个时间的年
    NSDateComponents *dateComps = [calendar components:unit fromDate:self];
    //获得当前时间的年
    NSDateComponents *nowComps = [calendar components:unit fromDate:[NSDate date]];
    //如果相等就是今年
    return dateComps.year == nowComps.year;
}

/**
 *  判断是否是昨天
 */
- (BOOL)isYesterday{
    //获得当前时间
    NSDate *now = [NSDate date];
    NSDateFormatter *dateF = [[NSDateFormatter alloc] init];
    dateF.dateFormat = @"yyyy-MM-dd";
    //将需要判断的日期 和 当前日期转换成年月日的形式
    NSString *dateStr = [dateF stringFromDate:self];
    NSString *nowStr = [dateF stringFromDate:now];
    //再转化成日期对象,此时的时分秒均为0
    NSDate *date = [dateF dateFromString:dateStr];
    now = [dateF dateFromString:nowStr];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    //获得两个日期之间的差值
    NSDateComponents *components = [calendar components:unit fromDate:date toDate:now options:0];
    
    return components.year == 0 && components.month == 0 && components.day == 1;
}

/**
 *  判断是否是今天
 */
- (BOOL)isToday{
    NSDate *now = [NSDate date];
    NSDateFormatter *dateF = [[NSDateFormatter alloc] init];
    dateF.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [dateF stringFromDate:self];
    NSString *nowStr = [dateF stringFromDate:now];
    return [dateStr isEqualToString:nowStr];
}

@end
