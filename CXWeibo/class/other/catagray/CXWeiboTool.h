//
//  CXWeiboTool.h
//  CXWeibo
//
//  Created by mac on 15-3-11.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GCXAccessToken;

@interface CXWeiboTool : NSObject
+ (void)chooseVC;

+ (void)saveAccessToken:(GCXAccessToken *)at;

+ (GCXAccessToken *)accessToken;

@end
