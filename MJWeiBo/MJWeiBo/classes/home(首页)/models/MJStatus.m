//
//  MJStatus.m
//  MJWeiBo
//
//  Created by 王梦杰 on 16/1/25.
//  Copyright (c) 2016年 Mooney_wang. All rights reserved.
//

#import "MJStatus.h" 
#import "MJExtension.h"
#import "MJPhoto.h"

@implementation MJStatus

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"pic_urls" : @"MJPhoto"};
}

/**
 *  重写时间的get方法
 */
/**
 1.今年
 1> 今天
 * 1分内： 刚刚
 * 1分~59分内：xx分钟前
 * 大于60分钟：xx小时前
 
 2> 昨天
 * 昨天 xx:xx
 
 3> 其他
 * xx-xx xx:xx
 
 2.非今年
 1> xxxx-xx-xx xx:xx
 */
-(NSString *)created_at{
    // _created_at == Thu Oct 16 17:06:25 +0800 2014
    // dateFormat == EEE MMM dd HH:mm:ss Z yyyy
    //E:星期几
    //M:月份
    //d:日期（几号）
    //H:24小时制 时
    //m:分钟
    //s:秒
    //y:年
    //Z:时区
    // NSString --> NSDate
    NSDateFormatter *dateF = [[NSDateFormatter alloc] init];
    //如果是真机调试，需要设置locale
    dateF.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    //设置日期的格式
    dateF.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    //微博的创建时间
    NSDate *createDate = [dateF dateFromString:_created_at];
    //当前时间
    NSDate *now = [NSDate date];
    //日历对象（方便比较两个日期对象之间的差）
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //代表想获得哪些差值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    //计算两个日期之间的差值
    NSDateComponents *components = [calendar components:unit fromDate:createDate toDate:now options:0];
    
    
    
    if ([createDate isThisYear]) {//今年
        
        if ([createDate isYesterday]) {//昨天
            
            dateF.dateFormat = @"昨天 HH:mm:ss";
            return [dateF stringFromDate:createDate];
            
        }else if ([createDate isToday]){//今天
            
            if (components.hour >= 1) {
                return [NSString stringWithFormat:@"%d小时前", components.hour];
            } else if (components.minute >= 1) {
                return [NSString stringWithFormat:@"%d分钟前", components.minute];
            } else {
                return @"刚刚";
            }
            
        }else{//其他日子
            dateF.dateFormat = @"MM-dd HH:mm:ss";
            return [dateF stringFromDate:createDate];
        }
        
    }else{//非今年
        
        dateF.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        return [dateF stringFromDate:createDate];
        
    }
}

- (void)setSource:(NSString *)source{
    //<a href=\"http://weibo.com/\" rel=\"nofollow\">微博</a>
    NSRange range;
    //从左往右找到第一个
    range.location = [source rangeOfString:@">"].location + 1;
//    range.length = [source rangeOfString:@"</"].location - range.location;
    //options:NSBackwardsSearch 表示反向查找，从右往左
    range.length = [source rangeOfString:@"<" options:NSBackwardsSearch].location - range.location;
    _source = [NSString stringWithFormat:@"来自%@",[source substringWithRange:range]];
}



@end
