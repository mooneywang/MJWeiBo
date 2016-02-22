//
//  MJStatusPhotoView.m
//  MJWeiBo
//
//  Created by 王梦杰 on 16/2/19.
//  Copyright © 2016年 Mooney_wang. All rights reserved.
//

#import "MJStatusPhotoView.h"
#import "MJPhoto.h"

@interface MJStatusPhotoView()

@property(nonatomic ,weak)UIImageView *gifView;

@end

@implementation MJStatusPhotoView

- (UIImageView *)gifView{
    if (_gifView == nil) {
        UIImageView *gifView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        [self addSubview:gifView];
        _gifView = gifView;
    }
    return _gifView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //内容模式
        self.contentMode = UIViewContentModeScaleAspectFill;
        //超出图片部分剪切掉
        self.layer.masksToBounds = YES;
    }
    return self;
}


- (void)setPhoto:(MJPhoto *)photo{
    _photo = photo;
    //如果不是gif就隐藏gifView
    self.gifView.hidden = ![photo.thumbnail_pic hasSuffix:@"gif"];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //调整gif图标，使之显示在右下角
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
    
}


@end
