//
//  GCXAccessToken.h
//  CXWeibo
//
//  Created by mac on 15-3-10.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCXAccessToken : NSObject <NSCoding>

/**
 *  {
 "access_token" = "2.00DnkZdFmqCAUBae9aaf72dasBPPNC";
 "expires_in" = 106187;
 "remind_in" = 106187;
 uid = 5165462609;
 }
 */
@property (nonatomic, strong) NSDate *expires_date;

@property (nonatomic, copy) NSString *access_token;

@property (nonatomic, assign) long long expires_in;

@property (nonatomic, assign) long long remind_in;

@property (nonatomic, assign) long long uid;

- (instancetype)initWithDict:(NSDictionary *)dict;


@end
