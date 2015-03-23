//
//  CXTextView.m
//  CXWeibo
//
//  Created by gaocaixin on 15-3-21.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "CXTextView.h"

#define PlaceholderFont [UIFont systemFontOfSize:16]
@interface CXTextView ()
@property (nonatomic ,weak) UILabel *label;
@end

@implementation CXTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = PlaceholderFont;
        self.keyboardType = UIKeyboardTypeDefault;
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor grayColor];
        label.hidden = YES;
        
        [self addSubview:label];
        self.label = label;
        
    }
    return self;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    self.label.text = placeholder;
    self.label.hidden = placeholder.length == 0;
    CGSize size = [placeholder sizeWithFont:PlaceholderFont];
    self.label.frame = (CGRect){5,7, size};
}

@end
