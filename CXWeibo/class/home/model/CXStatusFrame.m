//
//  CXStatusFrame.m
//  CXWeibo
//
//  Created by gaocaixin on 15-3-15.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "CXStatusFrame.h"
#import "GCXStatuse.h"
#import "CXUser.h"



@implementation CXStatusFrame

/**重写这个方法 计算 frame*/
- (void)setStatuse:(GCXStatuse *)statuse
{
    _statuse = statuse;
    
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    // topView
    CGFloat topViewW = cellW;
    CGFloat topViewX = 0;
    CGFloat topViewY = 0;
    
    // 头像iconView
    CGFloat iconViewW = 35;
    CGFloat iconViewH = iconViewW;
    CGFloat iconViewX = StatuseCellBorder;
    CGFloat iconViewY = StatuseCellBorder;
    _iconViewF = CGRectMake(iconViewX, iconViewY, iconViewW, iconViewH);
    
    // nameLabel
    CGSize nameLabelSize = [_statuse.user.name sizeWithFont:StatuseNameLabelFont];
    CGFloat nameLabelX = CGRectGetMaxX(_iconViewF)+StatuseCellBorder;
    CGFloat nameLabelY = iconViewY;
    _nameLabelF = (CGRect){nameLabelX, nameLabelY, nameLabelSize};
    
    // vip
    if (_statuse.user.vip) {
        CGFloat vipViewW = 14;
        CGFloat vipViewH = _nameLabelF.size.height;
        CGFloat vipViewX = CGRectGetMaxX(_nameLabelF) + StatuseCellBorder;
        CGFloat vipViewY = iconViewY;
        _vipViewF = (CGRect){vipViewX, vipViewY, vipViewW, vipViewH};
    }
    
    // 时间
    CGSize timeLabelSize = [_statuse.created_at sizeWithFont:StatuseTimeLabelFont];
    CGFloat timeLabelX = nameLabelX;
    CGFloat timeLabelY = CGRectGetMaxY(_nameLabelF)+StatuseCellBorder;
    _timeLabelF = (CGRect){timeLabelX, timeLabelY, timeLabelSize};

    // 来源
    CGSize sourceLabelSize = [_statuse.source sizeWithFont:StatuseSourceLabelFont];
    CGFloat sourceLabelX = CGRectGetMaxX(_timeLabelF)+StatuseCellBorder;
    CGFloat sourceLabelY = timeLabelY;
    _sourceLabelF = (CGRect){sourceLabelX, sourceLabelY, sourceLabelSize};


    // 正文
    CGSize contentLabelSize = [_statuse.text sizeWithFont:StatuseContentLabelFont constrainedToSize:CGSizeMake(topViewW-2*StatuseCellBorder, CGFLOAT_MAX)];
    CGFloat contentLabelX = iconViewX;
    CGFloat contentLabelY = CGRectGetMaxY(_iconViewF)+StatuseCellBorder;
    _contentLabelF = (CGRect){contentLabelX, contentLabelY, contentLabelSize};
    
    // 计算 topview 的高度
    CGFloat topViewH = CGRectGetMaxY(_contentLabelF) + StatuseCellBorder;
    _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    
    // cell 的高度
    _cellHeight = topViewH + StatuseCellBorder;
}

@end
