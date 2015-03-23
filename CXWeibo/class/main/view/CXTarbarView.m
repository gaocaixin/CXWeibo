//
//  CXTarbarView.m
//  CXWeibo
//
//  Created by mac on 15-2-6.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "CXTarbarView.h"
#import "CXTabBarButten.h"

@interface CXTarbarView ()
@property (nonatomic, weak) CXTabBarButten *preBtn;
@property (nonatomic, strong) UIButton *cenBtn;
@end

@implementation CXTarbarView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 设置背景色
        if (!iOS7) {
            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"tabbar_background"]];
        }
        
        // 这里添加btn时 要添加到view子数组里 否则不显示
        UIButton *centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [centerBtn setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [centerBtn setBackgroundImage:[UIImage imageWithName:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [centerBtn setImage:[UIImage imageWithName:@"tabbar_compose_icon_add-1"] forState:UIControlStateNormal];
        [centerBtn setImage:[UIImage imageWithName:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        centerBtn.bounds = CGRectMake(0, 0, centerBtn.currentBackgroundImage.size.width, centerBtn.currentBackgroundImage.size.height);
        [centerBtn addTarget:self action:@selector(centerBtn) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:centerBtn];
        self.cenBtn = centerBtn;
        
    }
    return self;
}

- (void)centerBtn
{
    if ([self.delegate respondsToSelector:@selector(centerBtnClicked)]) {
        [self.delegate centerBtnClicked];
    }
}
- (void)addTarBarItemWithTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    CXTabBarButten *btn = [[CXTabBarButten alloc] init];
    
    [btn setTitle:title forState:UIControlStateNormal];
    
    UIImage *mal =[UIImage imageWithName:imageName];
    UIImage *sel =[UIImage imageWithName:selectedImageName];
    UIImage *selBack = [UIImage imageWithName:@"tabbar_slider"];
    if (iOS7) {
        mal =[mal imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        sel =[sel imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        selBack = [selBack imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    [btn setImage:mal forState:UIControlStateNormal];
    [btn setImage:sel forState:UIControlStateSelected];
    [btn setBackgroundImage:selBack forState:UIControlStateSelected];
    
        
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:btn];
//    [self.arrM addObject:btn];
    
    
    if (self.subviews.count == 2) {
        [self btnClick:btn];
    }
    
}

- (void)btnClick:(CXTabBarButten *)btn
{
    self.preBtn.selected = NO;
    btn.selected = YES;
    self.preBtn = btn;
    
    if ([self.delegate respondsToSelector:@selector(tarbarViewDidClickBtn:)]) {
        [self.delegate tarbarViewDidClickBtn:btn.tag];
    }
}

- (void)layoutSubviews
{
    self.cenBtn.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    
//    self.arrM = (NSMutableArray *)self.subviews;
//    [self.arrM insertObject:self.cenBtn atIndex:self.subviews.count / 2];
    
    CGFloat btnW = self.frame.size.width / self.subviews.count;
    CGFloat btnH = self.frame.size.height;
    CGFloat btnY = 0;
    
    // 前面已经添加了一个btn subviews数组里不是从零开始排列buttenitem 需要处理
    for (int i = 1; i < self.subviews.count; i++) {
        CGFloat btnX = btnW * (i - 1);
        UIButton *btn = self.subviews[i];
        if (i > 2) {
            btnX += btnW;
        }
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        // tag 要符合代理调用的tag值 从零开始
        btn.tag = 10 + i - 1;
    }
//    NSLog(@"%@", self.arrM);
}

@end
