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
#import "MJUser.h"
#import "MJStatus.h"
#import "MJExtension.h"
#import "MJLoadMoreFooter.h"
#import "MJStatusCell.h"
#import "MJStatusFrame.h"

@interface MJHomeViewController () <MJDropDownMenuDelegate>

/**
 *  数据源数组（里面每一个元素都是statusFrame）
 */
@property(nonatomic, strong)NSMutableArray *statusFrameArray;

@end

@implementation MJHomeViewController

/**
 *  数据源懒加载
 */
- (NSMutableArray *)statusFrameArray{
    if (_statusFrameArray == nil) {
        _statusFrameArray = [NSMutableArray array];
    }
    return _statusFrameArray;
}

/**
 *  将status数组转换成statusFrame数组
 */
- (NSArray *)statusFrameArrayWithStatusArray:(NSArray *)statusArray{
    NSMutableArray *statusFrameArray = [NSMutableArray array];
    for (MJStatus *status in statusArray) {
        MJStatusFrame *statusFrame = [[MJStatusFrame alloc] init];
        statusFrame.status = status;
        [statusFrameArray addObject:statusFrame];
    }
    return statusFrameArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:1.0];
    
    //初始化导航栏
    [self initNav];
    
    //获取账户名（首页标题）
    [self initTitle];
    
    //集成下拉刷新控件
    [self setupRefresh];
    
    //添加上拉加载更多控件
    [self setupLoadMoreFooter];
    
    //获取未读数
    //每60s调用一次setupUnReadCount方法
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(setupUnReadCount) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
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
        MJUser *user = [MJUser mj_objectWithKeyValues:responseObject];
//        NSString *titleName = responseObject[@"name"];
        //设置名字
        UIButton *titleBtn = (UIButton *)self.navigationItem.titleView;
        [titleBtn setTitle:user.name forState:UIControlStateNormal];
        //将用户名存储起来
        account.name = user.name;
        [MJAccountTool saveAccount:account];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MJLog(@"请求失败:%@",error);
    }];
}

/**
 *  集成下拉刷新控件（系统自带）
 */
- (void)setupRefresh{
    //添加下拉刷新控件
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    NSDictionary *dict = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新" attributes:dict];
    refreshControl.tintColor = [UIColor whiteColor];
    refreshControl.backgroundColor = [UIColor lightGrayColor];
    [self.tableView addSubview:refreshControl];
    //添加监听事件
    [refreshControl addTarget:self action:@selector(statusChanged:) forControlEvents:UIControlEventValueChanged];
    
    //进入开始刷新状态(调用beginRefreshing方法,只会将isRefreshing属性值改为yes，并不会调用valuechanged方法)
    [refreshControl beginRefreshing];
    //手动调用刷新方法
    [self statusChanged:refreshControl];
}

/**
 *  刷新事件
 */
- (void)statusChanged:(UIRefreshControl *)refreshControl{
    
    
    MJAccount *account = [MJAccountTool account];
    
    //https://api.weibo.com/2/statuses/friends_timeline.json
    //参数：access_token
    //since_id	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:account.access_token forKey:@"access_token"];
    //    [params setObject:@1 forKey:@"count"];//默认获取20条
    //获得当前数据源中的第一条微博
    MJStatusFrame *sinceStatusF = [self.statusFrameArray firstObject];
    if (sinceStatusF) {
        [params setObject:sinceStatusF.status.idstr forKey:@"since_id"];
    }
    
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        MJLog(@"%@",responseObject);
        NSArray *newStatuses = [MJStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        NSArray *newStatusFrames = [self statusFrameArrayWithStatusArray:newStatuses];
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newStatusFrames.count)];
        //插入到数据源的最前面
        [self.statusFrameArray insertObjects:newStatusFrames atIndexes:indexSet];
        
        //刷新表格
        [self.tableView reloadData];
        //结束刷新
        [refreshControl endRefreshing];
        //显示获取到的最新微博数量
        [self showRefreshCount:newStatusFrames.count];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MJLog(@"request failed:%@",error);
        //结束刷新
        [refreshControl endRefreshing];
    }];
    
}

- (void)showRefreshCount:(NSInteger)count{
    //刷新之后去掉tabBar以及应用程序上的提示数
    self.tabBarItem.badgeValue = nil;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    //显示刷新微博条数
    UILabel *label = [[UILabel alloc] init];
    label.height = 35;
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.y = 64 - label.height;
    label.backgroundColor = [UIColor orangeColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14];
    if (count == 0) {
        label.text = @"没有最新的微博,请稍后再试";
    }else{
        label.text = [NSString stringWithFormat:@"共有%ld条最新微博数据",(long)count];
    }
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    [UIView animateWithDuration:1.0 animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        //1秒钟后消失
        CGFloat duration = 1.0f;
        
        [UIView animateWithDuration:1.0 delay:duration options:UIViewAnimationOptionCurveLinear animations:^{
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
        
    }];
    
}

/**
 *  集成上拉加载控件
 */
- (void)setupLoadMoreFooter{
    MJLoadMoreFooter *footerView = [MJLoadMoreFooter footer];
    footerView.backgroundColor = [UIColor redColor];
    footerView.hidden = YES;
    self.tableView.tableFooterView = footerView;
}

/**
 *  加载更多的微博数据
 */
- (void)loadMoreStatuses{
    
    MJAccount *account = [MJAccountTool account];
    
    //https://api.weibo.com/2/statuses/friends_timeline.json
    //参数：access_token
    //max_id 	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:account.access_token forKey:@"access_token"];
    //    [params setObject:@1 forKey:@"count"];//默认获取20条
    //获得当前数据源中的最后一条微博
    MJStatusFrame *lastStatusF = [self.statusFrameArray lastObject];
    long long maxID = lastStatusF.status.idstr.longLongValue - 1;
    [params setObject:@(maxID) forKey:@"max_id"];
    
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        MJLog(@"%@",responseObject);
        NSArray *lastStatuses = [MJStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        NSArray *lastStatusFrames = [self statusFrameArrayWithStatusArray:lastStatuses];
        //插入到数据源的最后面
        [self.statusFrameArray  addObjectsFromArray:lastStatusFrames];
        
        //刷新表格
        [self.tableView reloadData];
        //结束刷新
        self.tableView.tableFooterView.hidden = YES;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MJLog(@"request failed:%@",error);
        //结束刷新
        self.tableView.tableFooterView.hidden = YES;
    }];
}

/**
 *  获取某个用户的各种消息未读数
 */
- (void)setupUnReadCount{
    NSLog(@"setupUnReadCount");
    MJAccount *account = [MJAccountTool account];
    
    //https://rm.api.weibo.com/2/remind/unread_count.json
    //参数：access_token
    //uid 需要获取消息未读数的用户UID，必须是当前登录用户。
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:account.access_token forKey:@"access_token"];
    [params setObject:account.uid forKey:@"uid"];
    //    [params setObject:@1 forKey:@"count"];//默认获取20条
    //获得当前数据源中的最后一条微博
    MJStatusFrame *lastStatusF = [self.statusFrameArray lastObject];
    long long maxID = lastStatusF.status.idstr.longLongValue - 1;
    [params setObject:@(maxID) forKey:@"max_id"];
    
    [manager GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSString *statusCount = [responseObject[@"status"] description];//description是将NSNumber对象转化为NSString
        if ([statusCount isEqualToString:@"0"]) {
            self.tabBarItem.badgeValue = nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        }else{
            self.tabBarItem.badgeValue = statusCount;
            [UIApplication sharedApplication].applicationIconBadgeNumber = statusCount.integerValue;
        }
        
        
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

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.statusFrameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MJStatusCell *cell = [MJStatusCell cellWithTableView:tableView];
    
    //取出模型
    MJStatusFrame *statusFrame = self.statusFrameArray[indexPath.row];
    //传递模型
    cell.statusFrame = statusFrame;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //取出模型
    MJStatusFrame *statusFrame = self.statusFrameArray[indexPath.row];
    return statusFrame.cellHeight;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    // 如果tableView还没有数据，就直接返回
    if (self.statusFrameArray.count == 0 || self.tableView.tableFooterView.hidden == NO) return;
    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentSize.height - scrollView.height + scrollView.contentInset.bottom - self.tableView.tableFooterView.height;
    //当最后一个cell完全进入视野
    if (offsetY >= judgeOffsetY) {
        self.tableView.tableFooterView.hidden = NO;
        //加载更多的微博数据
        [self loadMoreStatuses];
    }
}

@end
