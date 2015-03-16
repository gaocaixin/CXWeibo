//
//  CXButton.m
//  CXWeibo
//
//  Created by mac on 15-2-28.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "CXButton.h"
#define IMAGEW 20;

@implementation CXButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat H = contentRect.size.height;
    CGFloat Y = 0;
    CGFloat W = IMAGEW;
    CGFloat X = contentRect.size.width - W - 10;
    return CGRectMake(X, Y, W, H);
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat H = contentRect.size.height;
    CGFloat Y = 0;
    CGFloat W = contentRect.size.width - 20 - IMAGEW;
    CGFloat X = 0;
    return CGRectMake(X, Y, W, H);
}

@end
