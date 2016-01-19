//
//  MJTabBarController.m
//  MJWeiBo
//
//  Created by 王梦杰 on 16/1/13.
//  Copyright (c) 2016年 Mooney_wang. All rights reserved.
//

#import "MJTabBarController.h"
#import "MJDiscoverViewController.h"
#import "MJHomeViewController.h"
#import "MJMessageViewController.h"
#import "MJProfileViewController.h"
#import "MJNavigationController.h"
#import "MJTabBar.h"

@interface MJTabBarController () <MJTabBarDelegate>

@end

@implementation MJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加子控制器
    [self initControllers];
    //使用自定义的TabBar替换系统自带的TabBar
    MJTabBar *myTabBar = [[MJTabBar alloc] init];
    myTabBar.frame = self.tabBar.bounds;
//    self.tabBar = myTabBar;//由于tabBar的属性是readonly，所以不能直接赋值，
    //使用KVC给tabBar属性赋值
    [self setValue:myTabBar forKeyPath:@"tabBar"];
}

//添加子控制器
- (void)initControllers{
    //首页
    MJHomeViewController *homeViewCtrl = [[MJHomeViewController alloc] init];
    [self addChildCtrl:homeViewCtrl withTitle:@"首页" image:@"tabbar_home" selImage:@"tabbar_home_selected"];
    //消息
    MJMessageViewController *messageVeiwCtrl = [[MJMessageViewController alloc] init];
    [self addChildCtrl:messageVeiwCtrl withTitle:@"消息" image:@"tabbar_message_center" selImage:@"tabbar_message_center_selected"];
    //发现
    MJDiscoverViewController *discoveryViewCtrl = [[MJDiscoverViewController alloc] init];
    [self addChildCtrl:discoveryViewCtrl withTitle:@"发现" image:@"tabbar_discover" selImage:@"tabbar_discover_selected"];
    //我的
    MJProfileViewController *profileViewCtrl = [[MJProfileViewController alloc] init];
    [self addChildCtrl:profileViewCtrl withTitle:@"我的" image:@"tabbar_profile" selImage:@"tabbar_profile_selected"];
}

- (void)addChildCtrl:(UIViewController *)viewCtrl withTitle:(NSString *)title image:(NSString *)imageName selImage:(NSString *)selImageName{
    //这句可以同时设置tabBar的title和NavgationBar的title
    viewCtrl.title = title;
    viewCtrl.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewCtrl.tabBarItem.selectedImage = [[UIImage imageNamed:selImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSDictionary *normDict = @{NSForegroundColorAttributeName:[UIColor grayColor]};
    [viewCtrl.tabBarItem setTitleTextAttributes:normDict forState:UIControlStateNormal];
    NSDictionary *selectedDict = @{NSForegroundColorAttributeName:[UIColor orangeColor]};
    [viewCtrl.tabBarItem setTitleTextAttributes:selectedDict forState:UIControlStateSelected];
    MJNavigationController *navCtrl = [[MJNavigationController alloc] initWithRootViewController:viewCtrl];
    
    [self addChildViewController:navCtrl];
}

#pragma mark - MJTabBarDelegate
- (void)tabBarDidClickPlusButton:(UIButton *)button{
    UIViewController *vCtrl = [[UIViewController alloc] init];
    vCtrl.view.backgroundColor = [UIColor orangeColor];
    vCtrl.view.frame = self.view.bounds;
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    closeBtn.frame = CGRectMake(100, 350, 100, 30);
    [closeBtn setBackgroundColor:[UIColor whiteColor]];
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [vCtrl.view addSubview:closeBtn];
    NSLog(@"%@",NSStringFromCGRect(vCtrl.view.frame));
    [self presentViewController:vCtrl animated:YES completion:nil];
}

- (void)closeBtnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
