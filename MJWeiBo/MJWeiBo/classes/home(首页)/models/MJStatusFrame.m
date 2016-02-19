//
//  MJStatusFrame.m
//  MJWeiBo
//
//  Created by 王梦杰 on 16/2/15.
//  Copyright © 2016年 Mooney_wang. All rights reserved.
//

#import "MJStatusFrame.h"
#import "MJUser.h"
#import "MJStatusPhotosView.h"

@implementation MJStatusFrame

- (void)setStatus:(MJStatus *)status{
    _status = status;
    
    MJUser *user = status.user;
    
    //根据传入的数据模型，计算子控件的frame
    //原创微博
    /** 头像 */
    CGFloat iconX = MJStatusCellBorderW;
    CGFloat iconY = MJStatusCellBorderW;
    CGFloat iconW = 40;
    CGFloat iconH = 40;
    self.iconViewF = CGRectMake(iconX, iconY, iconW, iconH);
    
    /** 昵称 */
    CGFloat nameLabelX = CGRectGetMaxX(self.iconViewF) + MJStatusCellBorderW;
    CGFloat nameLabelY = iconY;
    CGSize nameLabelSize = [user.name sizeWithFont:MJStatusCellNameFont];
//    CGFloat nameLabelW = nameLabelSize.width;
//    CGFloat nameLabelH = nameLabelSize.height;
//    self.nameLabelF = CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    self.nameLabelF = (CGRect){{nameLabelX, nameLabelY}, nameLabelSize};
    
    /** 会员图标 */
    if (status.user.isVip) {
        CGFloat vipViewX = CGRectGetMaxX(self.nameLabelF) + MJStatusCellBorderW;
        CGFloat vipViewY = nameLabelY;
        CGFloat vipViewW = 14;
        CGFloat vipViewH = nameLabelSize.height;
        self.vipViewF = CGRectMake(vipViewX, vipViewY, vipViewW, vipViewH);
    }
    
    /** 时间 */
    CGFloat timeLabelX = nameLabelX;
    CGFloat timeLabelY = CGRectGetMaxY(self.nameLabelF) + MJStatusCellBorderW;
    CGSize timeLabelSize = [status.created_at sizeWithFont:MJStatusCellTimeFont];
    self.timeLabelF = (CGRect){{timeLabelX, timeLabelY}, timeLabelSize};
    
    /** 来源 */
    CGFloat sourceLabelX = CGRectGetMaxX(self.timeLabelF) + MJStatusCellBorderW;
    CGFloat sourceLabelY = timeLabelY;
    CGSize sourceLabelSize = [status.source sizeWithFont:MJStatusCellSourceFont];
    self.sourceLabelF = (CGRect){{sourceLabelX, sourceLabelY}, sourceLabelSize};
    
    /** 正文 */
    CGFloat contentLabelX = iconX;
    CGFloat contentLabelY = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabelF)) + MJStatusCellBorderW;
    CGFloat contentLabelMaxW = [[UIScreen mainScreen] bounds].size.width - 2 * contentLabelX;
    CGSize contentLabelSize = [status.text sizeWithFont:MJStatusCellContentFont maxW:contentLabelMaxW];
    self.contentLabelF = (CGRect){{contentLabelX, contentLabelY}, contentLabelSize};
    
    /** 原创微博整体的高 */
    CGFloat originalH;
    /** 配图 */
    if (status.pic_urls.count) {//有配图
        CGFloat photosViewX = iconX;
        CGFloat photosViewY = CGRectGetMaxY(self.contentLabelF) + MJStatusCellBorderW;
        CGSize photosViewSize = [MJStatusPhotosView sizeWithCount:status.pic_urls.count];
        self.photosViewF = (CGRect){{photosViewX, photosViewY}, photosViewSize};
        
        originalH = CGRectGetMaxY(self.photosViewF) + MJStatusCellBorderW;
        
    }else{//无配图
        originalH = CGRectGetMaxY(self.contentLabelF) + MJStatusCellBorderW;
        
    }
    
    /** 原创微博整体 */
    CGFloat originalX = 0;
    CGFloat originalY = 0;
    CGFloat originalW = [[UIScreen mainScreen] bounds].size.width;
    self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    
    CGFloat toolbarY;
    if (status.retweeted_status) {//有转发微博
        
        /** 转发微博昵称+正文 */
        CGFloat retweetContentLabelX = MJStatusCellBorderW;
        CGFloat retweetContentLabelY = MJStatusCellBorderW;
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",status.retweeted_status.user.name,status.retweeted_status.text];
        CGSize retweetContentLabelSize = [retweetContent sizeWithFont:MJStatusCellRetweetContentFont maxW:contentLabelMaxW];
        self.retweetContentLabelF = (CGRect){{retweetContentLabelX, retweetContentLabelY}, retweetContentLabelSize};
        /** 转发微博图片 */
        CGFloat retweetViewH;
        if (status.retweeted_status.pic_urls.count) {
            CGFloat retweetPhotosViewX = retweetContentLabelX;
            CGFloat retweetPhotosViewY = CGRectGetMaxY(self.retweetContentLabelF) + MJStatusCellBorderW;
            CGSize retweetPhotosViewSize = [MJStatusPhotosView sizeWithCount:status.retweeted_status.pic_urls.count];
            self.retweetPhotosViewF = (CGRect){{retweetPhotosViewX, retweetPhotosViewY}, retweetPhotosViewSize};
            /** 转发微博整体的高度 */
            retweetViewH = CGRectGetMaxY(self.retweetPhotosViewF) + MJStatusCellBorderW;
        }else{
            /** 转发微博整体的高度 */
            retweetViewH = CGRectGetMaxY(self.retweetContentLabelF) + MJStatusCellBorderW;
        }
        /** 转发微博整体 */
        CGFloat retweetViewX = originalX;
        CGFloat retweetViewY = CGRectGetMaxY(self.originalViewF);
        CGFloat retweetViewW = originalW;
        self.retweetViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
        
        /** 工具条的Y */
        toolbarY = CGRectGetMaxY(self.retweetViewF);
        
    }else{//无转发微博
        
        /** 工具条的Y */
        toolbarY = CGRectGetMaxY(self.originalViewF);
    }
    
    /** 工具条整体 */
    CGFloat toolbarX = 0;
    CGFloat toolbarW = originalW;
    CGFloat toolbarH = 30;
    self.toolbarF = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    
    /** cell的高度 */
    self.cellHeight = CGRectGetMaxY(self.toolbarF) + MJStatusCellMargin;
}

@end
