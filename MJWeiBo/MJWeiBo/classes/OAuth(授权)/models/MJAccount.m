//
//  MJAccount.m
//  MJWeiBo
//
//  Created by 王梦杰 on 16/1/21.
//  Copyright (c) 2016年 Mooney_wang. All rights reserved.
//

#import "MJAccount.h"

@implementation MJAccount

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        _access_token = dict[@"access_token"];
        _expires_in = dict[@"expires_in"];
        _uid = dict[@"uid"];
    }
    return self;
}

+ (instancetype)accountWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_access_token forKey:@"access_token"];
    [aCoder encodeObject:_expires_in forKey:@"expires_in"];
    [aCoder encodeObject:_uid forKey:@"uid"];
    [aCoder encodeObject:_create_Date forKey:@"create_Date"];
    [aCoder encodeObject:_name forKey:@"name"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        _access_token = [aDecoder decodeObjectForKey:@"access_token"];
        _expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        _uid = [aDecoder decodeObjectForKey:@"uid"];
        _create_Date = [aDecoder decodeObjectForKey:@"create_Date"];
        _name = [aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"_access_token=%@,_expires_in=%@,_uid=%@",_access_token,_expires_in,_uid];
}

@end
