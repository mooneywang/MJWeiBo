//
//  AppDelegate.m
//  MJWeiBo
//
//  Created by 王梦杰 on 16/1/12.
//  Copyright (c) 2016年 Mooney_wang. All rights reserved.
//

#import "AppDelegate.h"
#import "MJTabBarController.h"
#import "MJNewFeatureController.h"

#define VERSIONKEY @"CFBundleVersion"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    application.statusBarHidden = NO;
    //1.新建window
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //2.设置window的根控制器，需要判断是否是第一次打开该应用
    //获取沙盒中的版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:VERSIONKEY];
    //获取当前的版本号
    NSDictionary *info = [NSBundle mainBundle].infoDictionary;
    NSString *currentVersion = info[VERSIONKEY];
    if ([currentVersion isEqualToString:lastVersion]) {//版本号相同，不需要显示新特性界面
        MJTabBarController *tabBarController = [[MJTabBarController alloc] init];
        self.window.rootViewController = tabBarController;
    }else{
        MJNewFeatureController *newFeatureController = [[MJNewFeatureController alloc] init];
        self.window.rootViewController = newFeatureController;
        //存储当前版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:VERSIONKEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    //3.显示window
    [self.window makeKeyAndVisible];
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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

@end
