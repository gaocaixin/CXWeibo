//
//  CXComposeToolBar.m
//  CXWeibo
//
//  Created by gaocaixin on 15-3-23.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "CXComposeToolBar.h"

#define TOOLBAR_BTN_TAG 10

@implementation CXComposeToolBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"compose_toolbar_background"]];
        [self createBtn];
    }
    return self;
}

- (void)createBtn
{
    [self createBtnWithIcon:@"compose_camerabutton_background" highIcon:@"compose_camerabutton_background_highlighted" tag:CXComposeToolBarButtenTypeCamera];
    [self createBtnWithIcon:@"compose_toolbar_picture" highIcon:@"compose_toolbar_picture_highlighted" tag:CXComposeToolBarButtenTypePicture];
    [self createBtnWithIcon:@"compose_mentionbutton_background" highIcon:@"compose_mentionbutton_background_highlighted" tag:CXComposeToolBarButtenTypeMention];
    [self createBtnWithIcon:@"compose_trendbutton_background" highIcon:@"compose_trendbutton_background_highlighted" tag:CXComposeToolBarButtenTypeTrend];
    [self createBtnWithIcon:@"compose_emoticonbutton_background" highIcon:@"compose_emoticonbutton_background_highlighted" tag:CXComposeToolBarButtenTypeEmotion];
}

- (void)createBtnWithIcon:(NSString *)icon highIcon:(NSString *)highIcon tag:(NSUInteger)tag
{
    UIButton *btn = [[UIButton alloc] init];
    
    btn.tag = tag;
    [btn setImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageWithName:highIcon] forState:UIControlStateHighlighted];
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn];
}

// 协议
- (void)btnClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(composeToolBar:didClickedButtenType:)]) {
        [self.delegate composeToolBar:self didClickedButtenType:btn.tag];
    }
}

- (void)layoutSubviews
{
     [super layoutSubviews];
    
    CGFloat W = self.frame.size.width / self.subviews.count;
    CGFloat H = self.frame.size.height;
    for (int i = 0; i < self.subviews.count; i++) {
        UIButton *btn = (UIButton *)self.subviews[i];
        btn.frame = CGRectMake(i*W, 0, W, H);
    }
}



@end
