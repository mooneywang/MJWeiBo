//
//  AppDelegate.m
//  MJWeiBo
//
//  Created by 王梦杰 on 16/1/12.
//  Copyright (c) 2016年 Mooney_wang. All rights reserved.
//

#import "AppDelegate.h"
#import "MJOAuthController.h"
#import "MJAccount.h"
#import "MJAccountTool.h"
#import "UIWindow+Extension.h"
#import "SDWebImageManager.h"

#define VERSIONKEY @"CFBundleVersion"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    application.statusBarHidden = NO;
    //1.新建window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //2.显示window
    [self.window makeKeyAndVisible];
    
    //3.设置window的根控制器，需要判断有没有授权过，需要判断是否是第一次打开该应用
    //获取账号
    MJAccount *account = [MJAccountTool account];
    if (account) {
        //如果存在accessToken，表示以前登录过
        
        //选择加载哪一个控制器
        [self.window switchRootViewController];
        
    }else{
        //之前没有登录过，直接显示授权界面
        self.window.rootViewController = [[MJOAuthController alloc] init];
    }
    
    //4.如果是iOS8.0以上的版本，需要注册通知
    // iOS8中设置application badge value 会抛错：Attempting to badge the application icon but haven't received permission from the user to badge the,原因是因为在ios8中，设置应用的application badge value需要得到用户的许可。
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

//程序进入后台的时候调用
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    //向操作系统申请后台运行的资格,能维持多久是不确定的
    UIBackgroundTaskIdentifier task = [application beginBackgroundTaskWithExpirationHandler:^{
        //当后台运行时间已经结束（过期），就会调用这个block
        //结束任务
        [application endBackgroundTask:task];
        
    }];
    
    //为了延长后台运行的时间，可以冒充音乐播放器，循环播放一个0KB的mp3文件
    
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/**
 *  由于使用了SDWebImage,程序运行过程中会产生图片缓存，所以内存警告时必须做相应的处理
 */
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    //1、取消下载
    [manager cancelAll];
    //2、清楚内存中的所有图片
    [manager.imageCache clearMemory];
}

@end
