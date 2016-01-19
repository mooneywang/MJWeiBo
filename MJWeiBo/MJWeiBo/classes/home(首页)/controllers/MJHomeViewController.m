//
//  MJHomeViewController.m
//  MJWeiBo
//
//  Created by 王梦杰 on 16/1/13.
//  Copyright (c) 2016年 Mooney_wang. All rights reserved.
//

#import "MJHomeViewController.h"
#import "MJDropDownMenu.h"
#import "MJTitleViewController.h"

@interface MJHomeViewController () <MJDropDownMenuDelegate>

@end

@implementation MJHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendsearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
    //添加首页按钮
    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    titleBtn.width = 80;
    titleBtn.height = 30;
    [titleBtn setTitle:@"首页" forState:UIControlStateNormal];
    [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    titleBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    titleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 30);
    titleBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 45, 0, 0);
    [titleBtn addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleBtn;
}

- (void)friendsearch{
    NSLog(@"%s",__func__);
}

- (void)pop{
    NSLog(@"%s",__func__);
}

- (void)titleButtonClick:(UIButton *)button{
    //创建下拉菜单
    MJDropDownMenu *dropDownMenu = [MJDropDownMenu dropDownMenu];
    dropDownMenu.delegate = self;
    //内容控制器
    MJTitleViewController *titleVc= [[MJTitleViewController alloc] init];
    titleVc.view.height = 90;
    titleVc.view.width = 100;
    //给下拉菜单添加内容
    dropDownMenu.contentViewController = titleVc;
    //显示下拉菜单
    [dropDownMenu showFrom:button];
}

#pragma mark - MJDropDownMenuDelegate
- (void)dropDownMenuDidShow:(MJDropDownMenu *)dropDownMenu{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    titleButton.selected = YES;
}

- (void)dropDownMenuDidDismiss:(MJDropDownMenu *)dropDownMenu{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    titleButton.selected = NO;
}

@end
