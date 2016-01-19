//
//  MJDropDownMenu.h
//  MJDropDownMenuDemo
//
//  Created by 王梦杰 on 16/1/18.
//  Copyright (c) 2016年 Mooney_wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MJDropDownMenu;

@protocol MJDropDownMenuDelegate <NSObject>

@optional
- (void)dropDownMenuDidShow:(MJDropDownMenu *)dropDownMenu;
- (void)dropDownMenuDidDismiss:(MJDropDownMenu *)dropDownMenu;

@end

@interface MJDropDownMenu : UIView

@property(nonatomic ,weak)id<MJDropDownMenuDelegate> delegate;

/**
 *  内容视图
 */
@property(nonatomic, strong)UIView *content;
/**
 *  内容视图控制器
 */
@property(nonatomic, strong)UIViewController *contentViewController;

/**
 *  创建一个下拉菜单方法
 */
+ (instancetype)dropDownMenu;

/**
 *  显示
 */
- (void)showFrom:(UIView *)fromView;
/**
 *  移除
 */
- (void)dismiss;

@end
