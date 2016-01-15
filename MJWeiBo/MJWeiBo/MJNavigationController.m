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
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navigationbar_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
        
        viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navigationbar_more"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backToHomeAction)];
        
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
