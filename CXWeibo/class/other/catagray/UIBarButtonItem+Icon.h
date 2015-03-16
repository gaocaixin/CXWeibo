//
//  UIBarButtonItem+Icon.h
//  CXWeibo
//
//  Created by mac on 15-2-26.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Icon)

+ (UIBarButtonItem *)barButtenItemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon action:(SEL)action target:(id)target;

@end
