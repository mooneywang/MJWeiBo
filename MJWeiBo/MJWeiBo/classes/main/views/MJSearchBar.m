//
//  MJSearchBar.m
//  MJWeiBo
//
//  Created by 王梦杰 on 16/1/16.
//  Copyright (c) 2016年 Mooney_wang. All rights reserved.
//

#import "MJSearchBar.h"

@implementation MJSearchBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //初始化代码
        self.font = [UIFont systemFontOfSize:13];
        [self setBackground:[UIImage imageNamed:@"searchbar_textfield_background"]];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        imageView.size = CGSizeMake(30, 30);
        imageView.contentMode = UIViewContentModeCenter;
        self.leftView = imageView;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

+ (instancetype)searchBar{
    return [[self alloc] init];
}

@end
