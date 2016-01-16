//
//  MJProfileViewController.m
//  MJWeiBo
//
//  Created by 王梦杰 on 16/1/13.
//  Copyright (c) 2016年 Mooney_wang. All rights reserved.
//

#import "MJProfileViewController.h"

@interface MJProfileViewController ()

@end

@implementation MJProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(setting)];
    
    MJLog(@"MJProfileViewController");
}

- (void)setting{
    NSLog(@"%s",__func__);
}

@end
