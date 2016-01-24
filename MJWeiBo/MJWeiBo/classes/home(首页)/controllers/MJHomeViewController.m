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
#import "AFHTTPRequestOperationManager.h"
#import "MJAccountTool.h"
#import "MJTitleButton.h"

@interface MJHomeViewController () <MJDropDownMenuDelegate>

@end

@implementation MJHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //初始化导航栏
    [self initNav];
    
    //获取账户名（首页标题）
    [self initTitle];
    
    //加载最新微博数据
    [self loadStatus];
    
}

/**
 *  初始化导航栏
 */
- (void)initNav{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendsearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
    //添加首页按钮
    MJTitleButton *titleBtn = [MJTitleButton buttonWithType:UIButtonTypeCustom];
    //获取微博用户名
    NSString *titleName = [MJAccountTool account].name;
    //如果微博用户名为空则显示首页，不为空则显示用户名
    [titleBtn setTitle:(titleName?titleName:@"首页") forState:UIControlStateNormal];
    [titleBtn addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleBtn;
}

/**
 *  获取标题
 */
- (void)initTitle{
    //获得账号
    MJAccount *account = [MJAccountTool account];
//    MJLog(@"%@",account.access_token);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //https://api.weibo.com/2/users/show.json
    //参数：access_token\uid
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:account.access_token forKey:@"access_token"];
    [params setObject:account.uid forKey:@"uid"];
    [manager GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
//        MJLog(@"请求成功:%@",responseObject);
        NSString *titleName = responseObject[@"name"];
        //设置名字
        UIButton *titleBtn = (UIButton *)self.navigationItem.titleView;
        [titleBtn setTitle:titleName forState:UIControlStateNormal];
        //将用户名存储起来
        account.name = titleName;
        [MJAccountTool saveAccount:account];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MJLog(@"请求失败:%@",error);
    }];
}

/**
 *  加载最新微博数据
 */
- (void)loadStatus{
    MJAccount *account = [MJAccountTool account];
    
    //https://api.weibo.com/2/statuses/friends_timeline.json
    //参数：access_token
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:account.access_token forKey:@"access_token"];
    [params setObject:@1 forKey:@"count"];
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        MJLog(@"reuest success:%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MJLog(@"request failed:%@",error);
    }];
    
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
