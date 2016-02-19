//
//  MJUser.m
//  MJWeiBo
//
//  Created by 王梦杰 on 16/1/25.
//  Copyright (c) 2016年 Mooney_wang. All rights reserved.
//

#import "MJUser.h"

@implementation MJUser

- (void)setMbtype:(int)mbtype{
    _mbtype = mbtype;
    self.vip = mbtype > 2;
}

@end
