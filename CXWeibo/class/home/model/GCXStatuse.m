//
//  GCXStatuse.m
//  CXWeibo
//
//  Created by mac on 15-3-13.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "GCXStatuse.h"
#import "CXUser.h"
#import "NSDate+Days.h"
#import "MJExtension.h"
#import "CXPhoto.h"

@implementation GCXStatuse

// 返回timelabel要显示的文字
- (NSString *)created_at
{
    // Tue Mar 17 10:47:14 +0800 2015
    // EEE MMM dd HH:mm:ss Z yyyy
    // 1获取微博发送时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 美国的格式
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
#pragma mark - 真机调试下需要加 区域
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *createdDate = [fmt dateFromString:_created_at];
    
    // 2 计算当前和微博发送的时间差
    if ([createdDate isToday]) { // 今天
        if (createdDate.deltaWithNow.hour >= 1 ) {
            return [NSString stringWithFormat:@"%d小时前", createdDate.deltaWithNow.hour];
        } else if (createdDate.deltaWithNow.minute >= 1) {
            return [NSString stringWithFormat:@"%d分钟前", createdDate.deltaWithNow.minute];
        } else {
            return @"刚刚";
        }
    } else if ([createdDate isYesterday]) { // 昨天
        fmt.dateFormat = @"昨天 HH:mm";
        return [fmt stringFromDate:createdDate];
    } else if ([createdDate isThisyear]) { // 今年
        fmt.dateFormat = @"MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    } else {
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    }
}



- (void)setSource:(NSString *)source
{
    NSInteger loc = [source rangeOfString:@">"].location+1;
    NSInteger len = [source rangeOfString:@"</"].location-loc;
    
    if (len <= 0) {
         _source = source;
    } else {
         _source = [source substringWithRange:NSMakeRange(loc, len)];
        _source = [NSString stringWithFormat:@"来自 %@", _source];
    }
}

// MJ的类 实现这个方法 告诉pic_urls这个数组里装的是[CXPhoto class]模型
- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [CXPhoto class]};
}

@end
