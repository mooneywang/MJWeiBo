//
//  MJEmotionTabBar.h
//  MJWeiBo
//
//  Created by 王梦杰 on 16/2/21.
//  Copyright © 2016年 Mooney_wang. All rights reserved.
//  表情键盘底部的选项卡

#import <UIKit/UIKit.h>
#import "MJEmotionTabBarButton.h"

typedef enum {
    MJEmotionTabBarButtonTypeRecent,
    MJEmotionTabBarButtonTypeDefault,
    MJEmotionTabBarButtonTypeEmoji,
    MJEmotionTabBarButtonTypeLxh
} MJEmotionTabBarButtonType;

@class MJEmotionTabBar;

@protocol MJEmotionTabBarDelegate <NSObject>

@optional
- (void)emotionTabBar:(MJEmotionTabBar *)emotionTabBar didClickButtonWithType:(MJEmotionTabBarButtonType)type;

@end

@interface MJEmotionTabBar : UIView

@property(nonatomic ,weak)id<MJEmotionTabBarDelegate> delegate;

@end
