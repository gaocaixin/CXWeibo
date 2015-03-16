//
//  GCXAccessToken.m
//  CXWeibo
//
//  Created by mac on 15-3-10.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "GCXAccessToken.h"

@implementation GCXAccessToken

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.remind_in = [aDecoder decodeInt64ForKey:@"remind_in"];
        self.expires_in = [aDecoder decodeInt64ForKey:@"expires_in"];
        self.uid = [aDecoder decodeInt64ForKey:@"uid"];
        self.expires_date = [aDecoder decodeObjectForKey:@"expires_date"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.expires_date forKey:@"expires_date"];
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeInt64:self.remind_in forKey:@"remind_in"];
    [aCoder encodeInt64:self.expires_in forKey:@"expires_in"];
    [aCoder encodeInt64:self.uid forKey:@"uid"];
}


@end
