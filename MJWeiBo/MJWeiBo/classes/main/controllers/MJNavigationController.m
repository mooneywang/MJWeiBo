//
//  MJNavigationController.m
//  MJWeiBo
//
//  Created by 王梦杰 on 16/1/15.
//  Copyright (c) 2016年 Mooney_wang. All rights reserved.
//

#import "MJNavigationController.h"


@interface MJNavigationController ()

@end

@implementation MJNavigationController

+ (void)initialize{
    //设置所有UIBarButtonItem的样式
    UIBarButtonItem *barButtonItem = [UIBarButtonItem appearance];
    NSDictionary *barButtonItemDictNormal = @{NSForegroundColorAttributeName:[UIColor orangeColor],NSFontAttributeName:[UIFont systemFontOfSize:15]};
    [barButtonItem setTitleTextAttributes:barButtonItemDictNormal forState:UIControlStateNormal];
    
    NSDictionary *barButtonItemDictDisable = @{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:15]};
    [barButtonItem setTitleTextAttributes:barButtonItemDictDisable forState:UIControlStateDisabled];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

/*
重写该方法，push的时候做一些特定的操作
 */
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    //如果不是根控制器，则需要添加leftBarItem、rightBarItem
    if (self.viewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        //添加导航栏左侧按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(backAction) image:@"navigationbar_back" highImage:@"navigationbar_back_highlighted"];
        //添加导航栏右侧按钮
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(backToHomeAction) image:@"navigationbar_more" highImage:@"navigationbar_more_highlighted"];
        
    }
    
    
    [super pushViewController:viewController animated:animated];
}

- (void)backAction{
    [self popViewControllerAnimated:YES];
}

- (void)backToHomeAction{
    [self popToRootViewControllerAnimated:YES];
}

@end
