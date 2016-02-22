//
//  MJComposePhotosView.m
//  MJWeiBo
//
//  Created by 王梦杰 on 16/2/21.
//  Copyright © 2016年 Mooney_wang. All rights reserved.
//

#import "MJComposePhotosView.h"

@implementation MJComposePhotosView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _photos = [NSMutableArray array];
    }
    return self;
}

/**
 *  添加图片
 */
- (void)addPhoto:(UIImage *)photo {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = photo;
    [self addSubview:imageView];
    
    [self.photos addObject:photo];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 设置图片的尺寸和位置
    NSUInteger count = self.subviews.count;
    int maxCol = 4;
    CGFloat imageWH = 70;
    CGFloat imageMargin = 10;
    
    for (int i = 0; i<count; i++) {
        UIImageView *photoView = self.subviews[i];
        
        int col = i % maxCol;
        photoView.x = col * (imageWH + imageMargin);
        
        int row = i / maxCol;
        photoView.y = row * (imageWH + imageMargin);
        photoView.width = imageWH;
        photoView.height = imageWH;
    }
    
}

@end
