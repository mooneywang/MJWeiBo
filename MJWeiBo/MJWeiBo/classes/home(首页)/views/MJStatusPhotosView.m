//
//  MJStatusPhotosView.m
//  MJWeiBo
//
//  Created by 王梦杰 on 16/2/18.
//  Copyright © 2016年 Mooney_wang. All rights reserved.
//

#import "MJStatusPhotosView.h"
#import "MJPhoto.h"
#import "UIImageView+WebCache.h"

//如果是4张图片的话，最大列数是2
#define MJMaxColumn(count) ((count == 4)?2:3)

@implementation MJStatusPhotosView

/**
 *  根据图片张数返回尺寸
 */
+ (CGSize)sizeWithCount:(int)count{
    //最多列数
    int maxCol = MJMaxColumn(count);
    //行数
    int row = (count + maxCol - 1) / maxCol;
    //高度
    CGFloat photosH = (row - 1) * MJStatusPhotoMargin + row * MJStatusPhotoWH;
    
    //列数
    int column = (count <= maxCol) ? count : maxCol;
    CGFloat photosW = (column - 1) * MJStatusPhotoMargin + column * MJStatusPhotoWH;
    
    return CGSizeMake(photosW, photosH);
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setPhotos:(NSArray *)photos{
    _photos = photos;
    
    //创建足够数量的UIImageView
    while (self.subviews.count < photos.count) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
    }
    
    //遍历所有图片控件，设置图片
    for (int i = 0; i < self.subviews.count; i++) {
        UIImageView *photoView = self.subviews[i];
        
        if (i < photos.count) {//显示并设置图片
            MJPhoto *photo = photos[i];
            [photoView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
            
            photoView.hidden = NO;
        }else{//隐藏
            photoView.hidden = YES;
        }
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    int maxCol = MJMaxColumn(self.photos.count);
    //设置图片和尺寸
    int photosCount = self.photos.count;
    for (int i = 0; i < photosCount; i++) {
        UIImageView *photoView = self.subviews[i];
        photoView.width = MJStatusPhotoWH;
        photoView.height = MJStatusPhotoWH;
        int row = i / maxCol;
        photoView.y =  row * MJStatusPhotoWH + row * MJStatusPhotoMargin;
        int col = i % maxCol;
        photoView.x = col * MJStatusPhotoWH + col * MJStatusPhotoMargin;
    }
}



@end
