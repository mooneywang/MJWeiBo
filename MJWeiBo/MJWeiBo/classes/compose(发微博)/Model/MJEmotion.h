//
//  MJEmotion.h
//  MJWeiBo
//
//  Created by 王梦杰 on 16/2/22.
//  Copyright © 2016年 Mooney_wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MJEmotion : NSObject
/** 表情的文字描述 */
@property (nonatomic, copy) NSString *chs;
/** 表情的png图片名 */
@property (nonatomic, copy) NSString *png;
/** emoji表情的16进制编码 */
@property (nonatomic, copy) NSString *code;

@end
