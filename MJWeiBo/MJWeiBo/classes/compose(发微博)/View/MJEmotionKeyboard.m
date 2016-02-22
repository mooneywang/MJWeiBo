//
//  MJEmotionKeyboard.m
//  MJWeiBo
//
//  Created by 王梦杰 on 16/2/21.
//  Copyright © 2016年 Mooney_wang. All rights reserved.
//

#import "MJEmotionKeyboard.h"
#import "MJEmotionListView.h"
#import "MJEmotionTabBar.h"
#import "MJExtension.h"
#import "MJEmotion.h"



@interface MJEmotionKeyboard() <MJEmotionTabBarDelegate>

@property(nonatomic ,weak)MJEmotionListView *emotionListView;
@property(nonatomic ,weak)MJEmotionTabBar *emotionTabBar;
/**  最近表情列表*/
@property(nonatomic, strong)MJEmotionListView *recentListView;
/**  默认表情列表*/
@property(nonatomic, strong)MJEmotionListView *defaultListView;
/**  emoji表情列表*/
@property(nonatomic, strong)MJEmotionListView *emojiListView;
/**  浪小花表情列表*/
@property(nonatomic, strong)MJEmotionListView *lxhListView;
/**  当前正在显示的表情列表*/
@property(nonatomic, strong)MJEmotionListView *showingListView;

@end

@implementation MJEmotionKeyboard

#pragma mark - 懒加载



- (MJEmotionListView *)recentListView {
    if (_recentListView == nil) {
        self.recentListView = [[MJEmotionListView alloc] init];
    }
    return _recentListView;
}

- (MJEmotionListView *)defaultListView{
    if (_defaultListView == nil) {
        self.defaultListView = [[MJEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        //直接使用MJExtension将字典数组转化成模型数组
        self.defaultListView.emotions = [MJEmotion mj_objectArrayWithFile:path];
    }
    return _defaultListView;
}

- (MJEmotionListView *)emojiListView {
    if (_emojiListView == nil) {
        self.emojiListView = [[MJEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        self.emojiListView.emotions = [MJEmotion mj_objectArrayWithFile:path];
    }
    return _emojiListView;
}

- (MJEmotionListView *)lxhListView {
    if (_lxhListView == nil) {
        self.lxhListView = [[MJEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        self.lxhListView.emotions = [MJEmotion mj_objectArrayWithFile:path];
    }
    return _lxhListView;
}

#pragma mark - 初始化方法

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //表情列表
        MJEmotionListView *emotionListView = [[MJEmotionListView alloc] init];
        self.emotionListView = emotionListView;
        [self addSubview:emotionListView];
        emotionListView.backgroundColor = [UIColor redColor];
        
        //表情工具条
        MJEmotionTabBar *emotionTabBar = [[MJEmotionTabBar alloc] init];
        self.emotionTabBar = emotionTabBar;
        emotionTabBar.delegate = self;
        [self addSubview:emotionTabBar];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //emotionTabBar的尺寸
    CGFloat emotionTabBarH = 37;
    self.emotionTabBar.height = emotionTabBarH;
    self.emotionTabBar.width = self.width;
    self.emotionTabBar.y = self.height - emotionTabBarH;
    //emotionListView的尺寸
    self.showingListView.x = self.showingListView.y = 0;
    self.showingListView.width = self.width;
    self.showingListView.height = self.emotionTabBar.y;
}

#pragma mark - MJEmotionTabBarDelegate
- (void)emotionTabBar:(MJEmotionTabBar *)emotionTabBar didClickButtonWithType:(MJEmotionTabBarButtonType)type {
    
    // 移除正在显示的listView控件
    [self.showingListView removeFromSuperview];
    
    switch (type) {
        case MJEmotionTabBarButtonTypeDefault:{
            [self addSubview:self.defaultListView];
            break;
        }
            
        case MJEmotionTabBarButtonTypeRecent:{
            [self addSubview:self.recentListView];
            break;
        }
            
        case MJEmotionTabBarButtonTypeEmoji:{
            [self addSubview:self.emojiListView];
            break;
        }
            
        case MJEmotionTabBarButtonTypeLxh:{
            [self addSubview:self.lxhListView];
            break;
        }
            
        default:
            break;
    }
    
    // 设置正在显示的listView
    self.showingListView = [self.subviews lastObject];
    
    // 设置frame
    [self setNeedsLayout];
}

@end
