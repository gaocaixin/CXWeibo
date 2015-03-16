//
//  CXWeiboTool.m
//  CXWeibo
//
//  Created by mac on 15-3-11.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "CXNewFeature.h"
#import "CXTabbarController.h"
#import "CXWeiboTool.h"
#import "GCXAccessToken.h"


#define FILE_NAME [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"access.data"]

@implementation CXWeiboTool

+ (void)chooseVC
{
    // 显示新特性
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *preVerson = [defaults stringForKey:@"CFBundleVersion"];
    NSString *currVerson = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    if ([preVerson isEqualToString:currVerson]) {
        // 沙盒有储存当前版本信息
        [UIApplication sharedApplication].keyWindow.rootViewController = [[CXTabbarController alloc] init];
    } else {
        // 版本信息不符合 展示新特性
        //              application.statusBarHidden = YES;
        [UIApplication sharedApplication].keyWindow.rootViewController = [[CXNewFeature alloc] init];
        [defaults setObject:currVerson forKey:@"CFBundleVersion"];
        [defaults synchronize];
    }

}

+ (void)saveAccessToken:(GCXAccessToken *)at
{
    at.expires_date = [[NSDate date] dateByAddingTimeInterval:at.expires_in];
    [NSKeyedArchiver archiveRootObject:at toFile:FILE_NAME];
}


+ (GCXAccessToken *)accessToken
{
    GCXAccessToken *at = [NSKeyedUnarchiver unarchiveObjectWithFile:FILE_NAME];
    // 判断账号是否过期
    if ([at.expires_date compare:[NSDate date]]) {
        return at;
    } else {
        return nil;
    }
}

@end
