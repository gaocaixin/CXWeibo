//
//  UIBarButtonItem+Icon.m
//  CXWeibo
//
//  Created by mac on 15-2-26.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "UIBarButtonItem+Icon.h"

@implementation UIBarButtonItem (Icon)

+ (UIBarButtonItem *)barButtenItemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon action:(SEL)action target:(id)target
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithName:highIcon] forState:UIControlStateHighlighted];
    btn.frame = (CGRect){CGPointZero, btn.currentBackgroundImage.size};
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
