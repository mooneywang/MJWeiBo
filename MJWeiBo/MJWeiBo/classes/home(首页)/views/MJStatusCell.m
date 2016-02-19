//
//  MJStatusCell.m
//  MJWeiBo
//
//  Created by 王梦杰 on 16/2/15.
//  Copyright © 2016年 Mooney_wang. All rights reserved.
//

#import "MJStatusCell.h"
#import "MJStatusFrame.h"
#import "MJStatus.h"
#import "MJUser.h"
#import "UIImageView+WebCache.h"
#import "MJPhoto.h"
#import "MJStatusToolBar.h"
#import "MJStatusPhotosView.h"

@interface MJStatusCell ()

/** 原创微博整体 */
@property(nonatomic ,weak)UIView *originalView;
/** 头像 */
@property(nonatomic ,weak)UIImageView *iconView;
/** 会员图标 */
@property(nonatomic ,weak)UIImageView *vipView;
/** 配图 */
@property(nonatomic ,weak)MJStatusPhotosView *photosView;
/** 昵称 */
@property(nonatomic ,weak)UILabel *nameLabel;
/** 时间 */
@property(nonatomic ,weak)UILabel *timeLabel;
/** 来源 */
@property(nonatomic ,weak)UILabel *sourceLabel;
/** 正文 */
@property(nonatomic ,weak)UILabel *contentLabel;

/** 转发微博整体 */
@property(nonatomic ,weak)UIView *retweetView;
/** 转发微博昵称+正文 */
@property(nonatomic ,weak)UILabel *retweetContentLabel;
/** 转发微博图片 */
@property(nonatomic ,weak)MJStatusPhotosView *retweetPhotosView;

/** 工具条 */
@property(nonatomic ,weak)MJStatusToolBar *toolbar;

@end

@implementation MJStatusCell

/**
 * 让每一个cell的frame向下移动10个像素
 */
- (void)setFrame:(CGRect)frame{
    frame.origin.y += 10;
    [super setFrame:frame];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *cellID = @"status";
    MJStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[MJStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        /*
        UIView *selBg = [[UIView alloc] init];
        selBg.backgroundColor = [UIColor blueColor];
        self.selectedBackgroundView = selBg;
        */
        //设置原创微博
        [self setupOriginalStatus];
        //设置转发微博
        [self setupRetweetStatus];
        //设置工具条
        [self setupToolBar];
    }
    return self;
}


- (void)setupOriginalStatus{
    /** 原创微博整体 */
    UIView *originalView = [[UIView alloc] init];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    originalView.backgroundColor = [UIColor whiteColor];
    
    /** 头像 */
    UIImageView *iconView = [[UIImageView alloc] init];
    [originalView addSubview:iconView];
    self.iconView = iconView;
    
    /** 会员图标 */
    UIImageView *vipView = [[UIImageView alloc] init];
    [originalView addSubview:vipView];
    self.vipView = vipView;
    vipView.contentMode = UIViewContentModeCenter;
    
    /** 配图 */
    MJStatusPhotosView *photosView = [[MJStatusPhotosView alloc] init];
    [originalView addSubview:photosView];
    self.photosView = photosView;
    
    /** 昵称 */
    UILabel *nameLabel = [[UILabel alloc] init];
    [originalView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    nameLabel.font = MJStatusCellNameFont;
    
    /** 时间 */
    UILabel *timeLabel = [[UILabel alloc] init];
    [originalView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    timeLabel.font = MJStatusCellTimeFont;
    timeLabel.textColor = [UIColor orangeColor];
    
    /** 来源 */
    UILabel *sourceLabel = [[UILabel alloc] init];
    [originalView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    sourceLabel.font = MJStatusCellSourceFont;
    
    /** 正文 */
    UILabel *contentLabel = [[UILabel alloc] init];
    [originalView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    contentLabel.font = MJStatusCellContentFont;
    contentLabel.numberOfLines = 0;
}

- (void)setupRetweetStatus{
    /** 转发微博整体 */
    UIView *retweetView = [[UIView alloc] init];
    [self.contentView addSubview:retweetView];
    self.retweetView = retweetView;
    retweetView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    
    /** 转发微博昵称+正文 */
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    [retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    retweetContentLabel.font = MJStatusCellRetweetContentFont;
    retweetContentLabel.numberOfLines = 0;
    
    /** 转发微博图片 */
    MJStatusPhotosView *retweetPhotosView = [[MJStatusPhotosView alloc] init];
    [self.retweetView addSubview:retweetPhotosView];
    self.retweetPhotosView = retweetPhotosView;
    
}

- (void)setupToolBar{
    /** 工具条整体 */
    MJStatusToolBar *toolbar = [MJStatusToolBar toolBar];
    [self.contentView addSubview:toolbar];
    self.toolbar = toolbar;
}

- (void)setStatusFrame:(MJStatusFrame *)statusFrame{
    _statusFrame = statusFrame;
    //取出数据模型
    MJStatus *status = statusFrame.status;
    //设置子控件的内容
    /** 头像 */
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:status.user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    /** 会员图标 */
    if (status.user.isVip) {
        self.vipView.hidden = NO;
        NSString *vipImageName = [NSString stringWithFormat:@"common_icon_membership_level%d",status.user.mbrank];
        self.vipView.image = [UIImage imageNamed:vipImageName];
        //会员昵称为橙色
        self.nameLabel.textColor = [UIColor orangeColor];
    }else{
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    
    /** 配图 */
    if (status.pic_urls.count) {//有配图
        MJPhoto *photo = [status.pic_urls firstObject];
#warning TODO 设置图片
        self.photosView.photos = status.pic_urls;
//        [self.photoView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        self.photosView.hidden = NO;
    }else{//无配图
        self.photosView.hidden = YES;
    }
    
    /** 昵称 */
    self.nameLabel.text = status.user.name;
    /** 时间 */
    self.timeLabel.text = status.created_at;
    /** 来源 */
    self.sourceLabel.text = status.source;
    /** 正文 */
    self.contentLabel.text = status.text;
    
    /** 转发微博整体 */
    if (status.retweeted_status) {
        MJStatus *retweetStatus = status.retweeted_status;
        MJUser *retweetUser = status.retweeted_status.user;
        
        self.retweetView.hidden = NO;
        /** 转发微博昵称+正文 */
        self.retweetContentLabel.text = [NSString stringWithFormat:@"@%@ : %@",retweetUser.name,retweetStatus.text];
        /** 转发微博图片 */
        if (retweetStatus.pic_urls.count) {//有配图
            MJPhoto *photo = [retweetStatus.pic_urls firstObject];
#warning TODO 设置图片
            self.retweetPhotosView.photos = retweetStatus.pic_urls;
//            [self.retweetPhotoView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
            self.retweetPhotosView.hidden = NO;
        }else{//无配图
            self.retweetPhotosView.hidden = YES;
        }
        
    }else{
        self.retweetView.hidden = YES;
    }
    
    //工具条
    self.toolbar.status = status;
    
    //设置子控件的frame
    /** 原创微博整体 */
    self.originalView.frame = statusFrame.originalViewF;
    /** 头像 */
    self.iconView.frame = statusFrame.iconViewF;
    /** 会员图标 */
    self.vipView.frame = statusFrame.vipViewF;
    /** 配图 */
    self.photosView.frame = statusFrame.photosViewF;
    /** 昵称 */
    self.nameLabel.frame = statusFrame.nameLabelF;
    
    //由于时间每次刷新都会重新计算，所以可能不同，这里需要重新计算时间和来源的frame
    /** 时间 */
    CGFloat timeLabelX = self.nameLabel.x;
    CGFloat timeLabelY = CGRectGetMaxY(self.nameLabel.frame) + MJStatusCellBorderW;
    CGSize timeLabelSize = [status.created_at sizeWithFont:MJStatusCellTimeFont];
    self.timeLabel.frame = (CGRect){{timeLabelX, timeLabelY}, timeLabelSize};
    
    /** 来源 */
    CGFloat sourceLabelX = CGRectGetMaxX(self.timeLabel.frame) + MJStatusCellBorderW;
    CGFloat sourceLabelY = timeLabelY;
    CGSize sourceLabelSize = [status.source sizeWithFont:MJStatusCellSourceFont];
    self.sourceLabel.frame = (CGRect){{sourceLabelX, sourceLabelY}, sourceLabelSize};
    
    /** 正文 */
    self.contentLabel.frame = statusFrame.contentLabelF;
    /** 转发微博整体 */
    self.retweetView.frame = statusFrame.retweetViewF;
    /** 转发微博昵称+正文 */
    self.retweetContentLabel.frame = statusFrame.retweetContentLabelF;
    /** 转发微博图片 */
    self.retweetPhotosView.frame = statusFrame.retweetPhotosViewF;
    /** 工具条整体 */
    self.toolbar.frame = statusFrame.toolbarF;
}

/* 
 - (void)awakeFromNib {
 // Initialization code
 }
 
 - (void)setSelected:(BOOL)selected animated:(BOOL)animated {
 [super setSelected:selected animated:animated];
 
 // Configure the view for the selected state
 }
*/

@end
