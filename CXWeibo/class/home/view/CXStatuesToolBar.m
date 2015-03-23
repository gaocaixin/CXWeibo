//
//  CXStatuesToolBar.m
//  CXWeibo
//
//  Created by gaocaixin on 15-3-17.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "CXStatuesToolBar.h"
#import "GCXStatuse.h"

@interface CXStatuesToolBar ()
@property (nonatomic ,strong) NSMutableArray *btns;
@property (nonatomic ,strong) NSMutableArray *dividers;
@end

@implementation CXStatuesToolBar

- (NSMutableArray *)btns
{
    if (_btns == nil) {
        _btns = [[NSMutableArray alloc] init];
    }
    return _btns;
}

- (NSMutableArray *)dividers
{
    if (_dividers == nil) {
        _dividers = [[NSMutableArray alloc] init];
    }
    return _dividers;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置背景图片
        self.image = [UIImage resizedImageWithName:@"timeline_card_bottom_background"];
        self.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_bottom_background_highlighted"];
        
        self.userInteractionEnabled = YES;
        
        // 添加按钮
        [self createBtnWithImageName:@"timeline_icon_retweet" title:@"转发" backgroundImageName:@"timeline_card_leftbottom_highlighted"];
        
        [self createBtnWithImageName:@"timeline_icon_comment" title:@"评论" backgroundImageName:@"timeline_card_middlebottom_highlighted"];
        
        [self createBtnWithImageName:@"timeline_icon_unlike" title:@"赞" backgroundImageName:@"timeline_card_rightbottom_highlighted"];
        
        
        // 添加imageView
        [self createDivider];
        [self createDivider];
        
    }
    return self;
}

- (void)createDivider
{
    UIImageView *image = [[UIImageView alloc] init];
    image.image = [UIImage imageWithName:@"timeline_card_bottom_line"];
    [self addSubview:image];
    [self.dividers addObject:image];
}

- (void)createBtnWithImageName:(NSString *)imageName title:(NSString *)title backgroundImageName:(NSString *)backgroundImageName
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageWithName:imageName] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage resizedImageWithName:backgroundImageName] forState:UIControlStateHighlighted];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    btn.adjustsImageWhenHighlighted = NO;
    [self addSubview:btn];
    [self.btns addObject:btn];
}

- (void)layoutSubviews
{
    CGFloat divW = 2;
    
    CGFloat btnY = 0;
    CGFloat btnW = (self.frame.size.width-self.dividers.count*divW)/self.btns.count;
    CGFloat btnH = self.frame.size.height;
    // 按钮
    for (int i = 0; i < self.btns.count; i++) {
        UIButton *btn = self.btns[i];
        CGFloat btnX = i*(btnW+divW);
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
    // 分割线
    CGFloat divY = 0;
    CGFloat divH = self.frame.size.height;
    // 按钮
    for (int i = 0; i < self.dividers.count; i++) {
        UIButton *btn = self.dividers[i];
        CGFloat divX = i*(btnW+divW)+btnW;
        btn.frame = CGRectMake(divX, divY, divW, divH);
    }
    
    [super layoutSubviews];
}

- (void)setStatues:(GCXStatuse *)statues
{
    
    _statues = statues;
    
    UIButton *reposts = self.btns[0];
    [self sutupStatuesBtnWithTitle:@"转发" count:statues.reposts_count btn:reposts];
    
    UIButton *countcomments = self.btns[1];
    [self sutupStatuesBtnWithTitle:@"评论" count:statues.comments_count  btn:countcomments];
    

    UIButton *attitudes = self.btns[2];
    [self sutupStatuesBtnWithTitle:@"赞" count:statues.attitudes_count  btn:attitudes];

    
}

- (void)sutupStatuesBtnWithTitle:(NSString *)title count:(int)count btn:(UIButton *)btn
{
    if (count <= 0) {
    } else if (count < 10000) {
        title = [NSString stringWithFormat:@"%d", count];
    } else {
        CGFloat countF = count/10000.0;
        title = [NSString stringWithFormat:@"%.1f万", countF];
        title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    [btn setTitle:title forState:UIControlStateNormal];
}

@end
