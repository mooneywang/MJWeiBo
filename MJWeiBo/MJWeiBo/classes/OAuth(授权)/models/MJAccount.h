//
//  MJAccount.h
//  MJWeiBo
//
//  Created by 王梦杰 on 16/1/21.
//  Copyright (c) 2016年 Mooney_wang. All rights reserved.
//

/*
 "access_token" = "2.00byXygC0C_kXf030a089618cGOs_E";
 "expires_in" = 157679999;
 "remind_in" = 157679999;
 uid = 2467302065;
 */

#import <Foundation/Foundation.h>

@interface MJAccount : NSObject <NSCoding>
/**
 *  用于调用access_token，接口获取授权后的access token
 */
@property(nonatomic, copy)NSString *access_token;
/**
 *   	access_token的生命周期，单位是秒数
 */
@property(nonatomic, copy)NSNumber *expires_in;
/**
 *  当前授权用户的UID
 */
@property(nonatomic, copy)NSString *uid;
/**
 *  获取access_Token的时间
 */
@property(nonatomic, strong)NSDate *create_Date;
/**
 *  微博用户名
 */
@property(nonatomic, copy)NSString *name;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
