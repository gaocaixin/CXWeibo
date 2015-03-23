//
//  NSDate+Days.h
//  CXWeibo
//
//  Created by gaocaixin on 15-3-17.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Days)

- (BOOL)isToday;


- (BOOL)isYesterday;

- (BOOL)isThisyear;
- (NSDateComponents *)deltaWithNow;
@end
