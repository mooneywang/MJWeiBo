//
//  UIBarButtonItem+Extension.h
//  MJWeiBo
//
//  Created by 王梦杰 on 16/1/15.
//  Copyright (c) 2016年 Mooney_wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (instancetype)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;

@end
