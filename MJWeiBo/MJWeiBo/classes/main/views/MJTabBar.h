//
//  MJTabBar.h
//  MJWeiBo
//
//  Created by 王梦杰 on 16/1/19.
//  Copyright (c) 2016年 Mooney_wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MJTabBarDelegate <UITabBarDelegate>

@optional
- (void)tabBarDidClickPlusButton:(UIButton *)button;

@end

@interface MJTabBar : UITabBar

@property(nonatomic ,weak)id<MJTabBarDelegate> delegate;

@end
