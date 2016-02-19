//
//  MJStatusFrame.h
//  MJWeiBo
//
//  Created by 王梦杰 on 16/2/15.
//  Copyright © 2016年 Mooney_wang. All rights reserved.
// 一个MJStatusFrame内部包含
// 1.一个MJStatus数据模型
// 2.一个cell内部所有子控件的frame
// 3.一个cell的高度

#import <Foundation/Foundation.h>
#import "MJStatus.h"

// 昵称字体
#define MJStatusCellNameFont [UIFont systemFontOfSize:15]
// 时间字体
#define MJStatusCellTimeFont [UIFont systemFontOfSize:12]
// 来源字体
#define MJStatusCellSourceFont MJStatusCellTimeFont
// 正文字体
#define MJStatusCellContentFont [UIFont systemFontOfSize:14]
// 转发微博正文字体
#define MJStatusCellRetweetContentFont [UIFont systemFontOfSize:13]

//cell的边框留白的宽度
#define MJStatusCellBorderW 10
//cell的间距
#define MJStatusCellMargin 8

@interface MJStatusFrame : NSObject

@property(nonatomic, strong)MJStatus *status;

/** 原创微博整体 */
@property(nonatomic ,assign)CGRect originalViewF;
/** 头像 */
@property(nonatomic ,assign)CGRect iconViewF;
/** 会员图标 */
@property(nonatomic ,assign)CGRect vipViewF;
/** 配图 */
@property(nonatomic ,assign)CGRect photosViewF;
/** 昵称 */
@property(nonatomic ,assign)CGRect nameLabelF;
/** 时间 */
@property(nonatomic ,assign)CGRect timeLabelF;
/** 来源 */
@property(nonatomic ,assign)CGRect sourceLabelF;
/** 正文 */
@property(nonatomic ,assign)CGRect contentLabelF;

/** 转发微博整体 */
@property(nonatomic ,assign)CGRect retweetViewF;
/** 转发微博昵称+正文 */
@property(nonatomic ,assign)CGRect retweetContentLabelF;
/** 转发微博图片 */
@property(nonatomic ,assign)CGRect retweetPhotosViewF;

/** 工具条 */
@property(nonatomic ,assign)CGRect toolbarF;

/** cell的高度 */
@property(nonatomic, assign)CGFloat cellHeight;

@end
