//
//  CXTabBarButten.m
//  CXWeibo
//
//  Created by mac on 15-2-6.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "CXTabBarButten.h"

@implementation CXTabBarButten

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        
        self.imageView.contentMode = UIViewContentModeCenter;
        
        [self setTitleColor: (iOS7 ? [UIColor blackColor] : [UIColor whiteColor]) forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    }
    return self;
}

// 去掉高光
- (void)setHighlighted:(BOOL)highlighted{}

// 从定义image和label的位置
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat width = contentRect.size.width;
    CGFloat height = 30;
    
    return CGRectMake(0, 0, width, height);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat width = contentRect.size.width;
    CGFloat height = 20;
    CGFloat y = contentRect.size.height - height;
    
    return CGRectMake(0, y, width, height);
}
@end
