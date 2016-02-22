//
//  MJComposePhotosView.h
//  MJWeiBo
//
//  Created by 王梦杰 on 16/2/21.
//  Copyright © 2016年 Mooney_wang. All rights reserved.
//  用来展示，要发送的图片

#import <UIKit/UIKit.h>

@interface MJComposePhotosView : UIView

@property (nonatomic, strong, readonly) NSMutableArray *photos;

- (void)addPhoto:(UIImage *)image;

@end
