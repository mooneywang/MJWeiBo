//
//  MJAccountTool.m
//  MJWeiBo
//
//  Created by 王梦杰 on 16/1/21.
//  Copyright (c) 2016年 Mooney_wang. All rights reserved.
//

#import "MJAccountTool.h"

#define ACCOUNT_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

@implementation MJAccountTool

+ (MJAccount *)account{
    //1.获取账号
    MJAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:ACCOUNT_PATH];
    //2.判断账号是否过期
    //获得获取access_Token的时间，在账号模型中添加一个时间属性，用来存放获取access_Token的时间
    NSDate *createDate = account.create_Date;
    //将获取access_Token的时间 + 账号的有效期 得到过期时间
    long long expire_in = [account.expires_in longLongValue];
    NSDate *expire_Date = [createDate dateByAddingTimeInterval:expire_in];
//    NSLog(@"expire_Date:%@",expire_Date);
    //获得当前时间
    NSDate *now = [NSDate date];
//    NSLog(@"now:%@",now);
    NSComparisonResult result = [now compare:expire_Date];
    if (result == NSOrderedDescending) {//过期
        return nil;
    }
    
    return account;
}

+ (void)saveAccount:(MJAccount *)account{
    //将当前时间保存下来
    account.create_Date = [NSDate date];
    [NSKeyedArchiver archiveRootObject:account toFile:ACCOUNT_PATH];
}

@end
