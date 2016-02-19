//
//  MJLoadMoreFooter.m
//  MJWeiBo
//
//  Created by 王梦杰 on 16/1/28.
//  Copyright (c) 2016年 Mooney_wang. All rights reserved.
//

#import "MJLoadMoreFooter.h"

@implementation MJLoadMoreFooter

+ (instancetype)footer{
    return [[[NSBundle mainBundle] loadNibNamed:@"MJLoadMoreFooter" owner:nil options:nil] lastObject];
}

@end
