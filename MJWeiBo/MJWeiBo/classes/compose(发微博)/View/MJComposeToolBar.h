//
//  MJComposeToolBar.h
//  MJWeiBo
//
//  Created by 王梦杰 on 16/2/21.
//  Copyright © 2016年 Mooney_wang. All rights reserved.
//  发微博工具条

#import <UIKit/UIKit.h>

typedef enum {
    MJComposeToolBarButtonTypeCamera, //拍照
    MJComposeToolBarButtonTypeAlbumn, //相册
    MJComposeToolBarButtonTypeMention,//@
    MJComposeToolBarButtonTypeTrend,  //#
    MJComposeToolBarButtonTypeEmotion,//表情
} MJComposeToolBarButtonType;

@class MJComposeToolBar;



@protocol MJComposeToolBarDelegate <NSObject>

@optional
- (void)composeToolBar:(MJComposeToolBar *)toolBar didClickButton:(MJComposeToolBarButtonType)type;

@end

@interface MJComposeToolBar : UIView

@property(nonatomic ,weak)id<MJComposeToolBarDelegate> delegate;

/**
 *  是否是表情键盘
 */
@property(nonatomic, assign)BOOL isEmotionKeyboard;

@end
