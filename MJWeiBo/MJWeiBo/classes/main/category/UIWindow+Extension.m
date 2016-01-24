//
//  UIWindow+Extension.m
//  MJWeiBo
//
//  Created by 王梦杰 on 16/1/23.
//  Copyright (c) 2016年 Mooney_wang. All rights reserved.
//

#define VERSIONKEY @"CFBundleVersion"

#import "UIWindow+Extension.h"
#import "MJTabBarController.h"
#import "MJNewFeatureController.h"

@implementation UIWindow (Extension)

- (void)switchRootViewController{
    //获取沙盒中的版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:VERSIONKEY];
    //获取当前的版本号
    NSDictionary *info = [NSBundle mainBundle].infoDictionary;
    NSString *currentVersion = info[VERSIONKEY];
    if ([currentVersion isEqualToString:lastVersion]) {//版本号相同，不需要显示新特性界面
        MJTabBarController *tabBarController = [[MJTabBarController alloc] init];
        self.rootViewController = tabBarController;
    }else{
        MJNewFeatureController *newFeatureController = [[MJNewFeatureController alloc] init];
        self.rootViewController = newFeatureController;
        //存储当前版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:VERSIONKEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
