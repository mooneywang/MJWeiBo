//
//  MJStatus.h
//  MJWeiBo
//
//  Created by 王梦杰 on 16/1/25.
//  Copyright (c) 2016年 Mooney_wang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MJUser;

@interface MJStatus : NSObject

/** 	string 	字符串型的微博ID*/
@property(nonatomic, copy)NSString *idstr;
/** 	string 	微博信息内容*/
@property(nonatomic, copy)NSString *text;
/** 	object 	微博作者的用户信息字段 详细*/
@property(nonatomic, strong)MJUser *user;
/**	string	微博创建时间*/
@property (nonatomic, copy) NSString *created_at;
/**	string	微博来源*/
@property (nonatomic, copy) NSString *source;

//多图时返回图片url数组，无图时返回空
@property(nonatomic, strong)NSArray *pic_urls;

/**	转发微博*/
@property(nonatomic, strong)MJStatus *retweeted_status;

/**	int	转发数*/
@property (nonatomic, assign) int reposts_count;
/**	int	评论数*/
@property (nonatomic, assign) int comments_count;
/**	int	表态数*/
@property (nonatomic, assign) int attitudes_count;

@end
