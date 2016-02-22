//
//  MJComposeToolBar.m
//  MJWeiBo
//
//  Created by 王梦杰 on 16/2/21.
//  Copyright © 2016年 Mooney_wang. All rights reserved.
//

#import "MJComposeToolBar.h"

@interface MJComposeToolBar ()

@property(nonatomic, weak)UIButton *emotionButton;

@end

@implementation MJComposeToolBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        [self setupBtnWithImage:@"compose_camerabutton_background" highImage:@"compose_camerabutton_background_highlighted" buttonType:MJComposeToolBarButtonTypeCamera];
        [self setupBtnWithImage:@"compose_toolbar_picture" highImage:@"compose_toolbar_picture_highlighted" buttonType:MJComposeToolBarButtonTypeAlbumn];
        [self setupBtnWithImage:@"compose_mentionbutton_background" highImage:@"compose_mentionbutton_background_highlighted" buttonType:MJComposeToolBarButtonTypeMention];
        [self setupBtnWithImage:@"compose_trendbutton_background" highImage:@"compose_trendbutton_background_highlighted" buttonType:MJComposeToolBarButtonTypeTrend];
        self.emotionButton = [self setupBtnWithImage:@"compose_emoticonbutton_background" highImage:@"compose_emoticonbutton_background_highlighted" buttonType:MJComposeToolBarButtonTypeEmotion];
    }
    return self;
}

- (UIButton *)setupBtnWithImage:(NSString *)imageName highImage:(NSString *)highImageName buttonType:(MJComposeToolBarButtonType)type{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    button.tag = type;
    [self addSubview:button];
    
    [button addTarget:self action:@selector(toolbarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat buttonW = self.width / self.subviews.count;
    CGFloat buttonH = self.height;
    for (int i =0; i < self.subviews.count; i++) {
        UIButton *button = self.subviews[i];
        button.frame = CGRectMake(i * buttonW, 0, buttonW, buttonH);
    }
}

- (void)toolbarButtonClick:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(composeToolBar:didClickButton:)]) {
        [self.delegate composeToolBar:self didClickButton:(MJComposeToolBarButtonType)button.tag];
    }
}

- (void)setIsEmotionKeyboard:(BOOL)isEmotionKeyboard {
    _isEmotionKeyboard = isEmotionKeyboard;
    NSString *nImage = @"compose_emoticonbutton_background";
    NSString *hImage = @"compose_emoticonbutton_background_highlighted";

    if (isEmotionKeyboard) {
        nImage = @"compose_keyboardbutton_background";
        hImage = @"compose_keyboardbutton_background_highlighted";
    }
    [self.emotionButton setImage:[UIImage imageNamed:nImage] forState:UIControlStateNormal];
    [self.emotionButton setImage:[UIImage imageNamed:hImage] forState:UIControlStateHighlighted];
}

@end
