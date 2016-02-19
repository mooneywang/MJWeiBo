//
//  MJStatusPhotosView.h
//  MJWeiBo
//
//  Created by 王梦杰 on 16/2/18.
//  Copyright © 2016年 Mooney_wang. All rights reserved.
//  配图相册

#import <UIKit/UIKit.h>

//一张图片的宽和高为70
#define MJStatusPhotoWH 70
#define MJStatusPhotoMargin 10

@interface MJStatusPhotosView : UIView

@property(nonatomic, strong)NSArray *photos;

/**
 *  根据图片张数返回尺寸
 */
+ (CGSize)sizeWithCount:(int)count;

@end
