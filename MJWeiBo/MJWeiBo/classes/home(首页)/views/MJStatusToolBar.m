//
//  MJStatusToolBar.m
//  MJWeiBo
//
//  Created by 王梦杰 on 16/2/18.
//  Copyright © 2016年 Mooney_wang. All rights reserved.
//

#import "MJStatusToolBar.h"
#import "MJStatus.h"

@interface MJStatusToolBar()

/**
 *  按钮数组
 */
@property(nonatomic, strong)NSMutableArray *btnArray;

/**
*  分割线数组
*/
@property(nonatomic, strong)NSMutableArray *lineArray;

@property(nonatomic ,weak)UIButton *repostBtn;
@property(nonatomic ,weak)UIButton *commentBtn;
@property(nonatomic ,weak)UIButton *likeBtn;

@end

@implementation MJStatusToolBar

- (NSMutableArray *)btnArray{
    if (_btnArray == nil) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (NSMutableArray *)lineArray{
    if (_lineArray == nil) {
        _lineArray = [NSMutableArray array];
    }
    return _lineArray;
}

+ (instancetype)toolBar{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        //添加按钮
        //转发
        self.repostBtn = [self setupBtnWithTitle:@"转发" icon:@"timeline_icon_retweet"];
        //评论
        self.commentBtn = [self setupBtnWithTitle:@"评论" icon:@"timeline_icon_comment"];
        //点赞
        self.likeBtn = [self setupBtnWithTitle:@"赞" icon:@"timeline_icon_unlike"];
        
        //添加分隔线
        [self setupLine];
        [self setupLine];
    }
    return self;
}

- (UIButton *)setupBtnWithTitle:(NSString *)title icon:(NSString *)icon{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [self addSubview:btn];
    
    [self.btnArray addObject:btn];
    
    return btn;
}

- (void)setupLine{
    UIImageView *line = [[UIImageView alloc] init];
    line.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:line];
    
    [self.lineArray addObject:line];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    int count = self.btnArray.count;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    for (int i = 0; i < count; i++) {
        UIButton *btn = (UIButton *)self.btnArray[i];
        btn.y = 0;
        btn.x = i * btnW;
        btn.width = btnW;
        btn.height = btnH;
    }
    
    int lineCount = self.lineArray.count;
    for (int i = 0; i < lineCount; i++) {
        UIImageView *line = (UIImageView *)self.lineArray[i];
        line.y = 0;
        line.x = (i + 1) * btnW;
        line.width = 1;
        line.height = btnH;
    }
}

- (void)setStatus:(MJStatus *)status{
    _status = status;
    
    [self setupBtn:self.repostBtn withCount:status.reposts_count title:@"转发"];
    [self setupBtn:self.commentBtn withCount:status.comments_count title:@"评论"];
    [self setupBtn:self.likeBtn withCount:status.attitudes_count title:@"赞"];
    
    
    
}

- (void)setupBtn:(UIButton *)btn withCount:(int)count title:(NSString *)title{
    /*
     不足10000，直接显示
     超过10000，显示 xx.x万
     1.1万
     如果是x.0万，直接显示x万
     */
    if (count) {
        if (count < 10000) { // 不足10000：直接显示数字，比如786、7986
            title = [NSString stringWithFormat:@"%d", count];
        } else { // 达到10000：显示xx.x万，不要有.0的情况
            double wan = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1f万", wan];
            // 将字符串里面的.0去掉
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
        [btn setTitle:title forState:UIControlStateNormal];
    }else{
        [btn setTitle:title forState:UIControlStateNormal];
    }
}

@end
