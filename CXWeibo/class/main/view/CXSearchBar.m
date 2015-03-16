//
//  CXSearchBar.m
//  CXWeibo
//
//  Created by mac on 15-2-26.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "CXSearchBar.h"

@implementation CXSearchBar

+(instancetype)searchBar
{
    return [[CXSearchBar alloc] init];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 背景图片
        self.background = [UIImage resizedImageWithName:@"searchbar_textfield_background"];
//        self.textAlignment = NSTextAlignmentCenter;
        // 默认尺度
        self.bounds = CGRectMake(0, 0, 300, 30);
        
        // 左边图标
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithName:@"searchbar_textfield_search_icon"]];
        imageView.contentMode = UIViewContentModeCenter;
        self.leftView = imageView;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        self.font = [UIFont systemFontOfSize:14];
        self.clearButtonMode = UITextFieldViewModeAlways;
        
        // 搜索Placeholder属性
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSFontAttributeName] = @"14";
        attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索" attributes:attrs];
        self.returnKeyType = UIReturnKeySearch;
        self.enablesReturnKeyAutomatically = YES;
    }
    return self;
}

- (void)layoutSubviews
{
    
    self.leftView.frame = CGRectMake(0, 0, 30, self.bounds.size.height);
    
    [super layoutSubviews];
}

@end
