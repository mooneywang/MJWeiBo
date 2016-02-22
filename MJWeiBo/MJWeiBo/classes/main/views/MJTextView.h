//
//  MJTextView.h
//  MJWeiBo
//
//  Created by 王梦杰 on 16/2/20.
//  Copyright © 2016年 Mooney_wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJTextView : UITextView

/**
 *  占位文字
 */
@property(nonatomic, copy)NSString *placeholder;
/**
 *  占位文字颜色
 */
@property(nonatomic, strong)UIColor *placeholderColor;

@end
