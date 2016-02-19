//
//  MJUser.h
//  MJWeiBo
//
//  Created by 王梦杰 on 16/1/25.
//  Copyright (c) 2016年 Mooney_wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MJUser : NSObject

/**     string 	字符串型的用户UID*/
@property(nonatomic, copy)NSString *idstr;
/** 	string 	友好显示名称*/
@property(nonatomic, copy)NSString *name;
/** 	string 	用户头像地址（中图），50×50像素*/
@property(nonatomic, copy)NSString *profile_image_url;
/** 会员类型*/
@property(nonatomic, assign)int mbtype;
/** 会员等级*/
@property(nonatomic, assign)int mbrank;
/** 是否是会员*/
@property(nonatomic, assign, getter=isVip)BOOL vip;

@end
