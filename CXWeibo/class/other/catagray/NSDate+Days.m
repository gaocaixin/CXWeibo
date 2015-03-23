//
//  NSDate+Days.m
//  CXWeibo
//
//  Created by gaocaixin on 15-3-17.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "NSDate+Days.h"

@implementation NSDate (Days)

- (BOOL)isToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    // 获取当前时间的年月日
    NSDate *nowDate = [NSDate date];
    NSDateComponents *nowCmps = [calendar components:unit fromDate:nowDate];
    
    // 获取发布时间的年月日
        NSDateComponents *createCmps = [calendar components:unit fromDate:self];
    
    if (nowCmps.day == createCmps.day && nowCmps.month == createCmps.month && nowCmps.year == createCmps.year) {
        return YES;
    }
    
    return NO;
}


- (BOOL)isYesterday
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    // 统一格式
    NSDate *now = [NSDate date];
    NSString *nowStr = [fmt stringFromDate:now];
    NSDate *nowDate = [fmt dateFromString:nowStr];
    
    // 统一格式
    NSString *selfStr = [fmt stringFromDate:self];
    NSDate *selfDate = [fmt dateFromString:selfStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth fromDate:selfDate toDate:nowDate options:0];
    
    if (comp.day == 1) {
        return YES;
    }
    
    return NO;
}


- (BOOL)isThisyear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    // 获取当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 获取发布时间的年月日
    NSDateComponents *createCmps = [calendar components:unit fromDate:self];
    
    if (nowCmps.year == createCmps.year) {
        return YES;
    }
    
    return NO;
}

- (NSDateComponents *)deltaWithNow
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}

@end
