//
//  MJIconView.m
//  MJWeiBo
//
//  Created by 王梦杰 on 16/2/19.
//  Copyright © 2016年 Mooney_wang. All rights reserved.
//

#import "MJIconView.h"
#import "MJUser.h"
#import "UIImageView+WebCache.h"

@interface MJIconView()

@property(nonatomic ,weak)UIImageView *verifiedView;

@end

@implementation MJIconView

- (UIImageView *)verifiedView{
    if (_verifiedView == nil) {
        UIImageView *verifiedView = [[UIImageView alloc] init];
        [self addSubview:verifiedView];
        _verifiedView = verifiedView;
    }
    return _verifiedView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setUser:(MJUser *)user{
    _user = user;
    
    //下载图片
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    //设置下标图片
    switch (user.verified_type) {
        case MJUserVerifiedPersonal: // 个人认证
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_vip"];
            break;
            
        case MJUserVerifiedOrgEnterprice:
        case MJUserVerifiedOrgMedia:
        case MJUserVerifiedOrgWebsite: // 官方认证
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
            
        case MJUserVerifiedDaren: // 微博达人
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_grassroot"];
            break;
            
        default:
            self.verifiedView.hidden = YES; // 当做没有任何认证
            break;
    }
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat scale = 0.6;
    self.verifiedView.size = self.verifiedView.image.size;
    self.verifiedView.x = self.width - self.verifiedView.width * scale;
    self.verifiedView.y = self.height - self.verifiedView.height * scale;
}

@end
