//
//  MJDiscoverViewController.m
//  MJWeiBo
//
//  Created by 王梦杰 on 16/1/13.
//  Copyright (c) 2016年 Mooney_wang. All rights reserved.
//

#import "MJDiscoverViewController.h"

@interface MJDiscoverViewController ()

@end

@implementation MJDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    MJLog(@"MJDiscoverViewController");
    
    UITextField *searchBar = [[UITextField alloc] init];
    searchBar.frame = CGRectMake(0, 0, 300, 30);
    searchBar.font = [UIFont systemFontOfSize:13];
    searchBar.placeholder = @"请输入搜所条件";
    [searchBar setBackground:[UIImage imageNamed:@"searchbar_textfield_background"]];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
    imageView.size = CGSizeMake(30, 30);
    imageView.contentMode = UIViewContentModeCenter;
    searchBar.leftView = imageView;
    searchBar.leftViewMode = UITextFieldViewModeAlways;
    self.navigationItem.titleView = searchBar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
