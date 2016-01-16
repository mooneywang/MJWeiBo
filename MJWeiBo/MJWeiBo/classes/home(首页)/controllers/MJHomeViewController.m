//
//  MJHomeViewController.m
//  MJWeiBo
//
//  Created by 王梦杰 on 16/1/13.
//  Copyright (c) 2016年 Mooney_wang. All rights reserved.
//

#import "MJHomeViewController.h"


@interface MJHomeViewController ()

@end

@implementation MJHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendsearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
    MJLog(@"MJHomeViewController");
}

- (void)friendsearch{
    NSLog(@"%s",__func__);
}

- (void)pop{
    NSLog(@"%s",__func__);
}


@end
