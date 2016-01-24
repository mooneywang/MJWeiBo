//
//  MJAccountTool.h
//  MJWeiBo
//
//  Created by 王梦杰 on 16/1/21.
//  Copyright (c) 2016年 Mooney_wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJAccount.h"

@interface MJAccountTool : NSObject

/**
 *  保存账号信息
 *
 *  @param account 账号信息
 */
+ (void)saveAccount:(MJAccount *)account;

/**
 *  获取账号
 *
 *  @return 账号
 */
+ (MJAccount *)account;

@end
