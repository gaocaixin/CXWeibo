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
#import "CXPhoto.h"
#import "CXPhotosView.h"
#import "Header.h"


@implementation CXStatusFrame

/**重写这个方法 计算 frame*/
- (void)setStatuse:(GCXStatuse *)statuse
{
    _statuse = statuse;
    
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width - 2*StatuesCellBorder;
    
    // topView
    CGFloat topViewW = cellW;
    CGFloat topViewX = 0;
    CGFloat topViewY = 0;
    CGFloat topViewH = 0;
    
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
    if (_statuse.user.mbtype > 2) {
        CGFloat vipViewW = 14;
        CGFloat vipViewH = _nameLabelF.size.height;
        CGFloat vipViewX = CGRectGetMaxX(_nameLabelF) + StatuseCellBorder;
        CGFloat vipViewY = iconViewY;
        _vipViewF = (CGRect){vipViewX, vipViewY, vipViewW, vipViewH};
    }
    
    // 时间
    CGSize timeLabelSize = [_statuse.created_at sizeWithFont:StatuseTimeLabelFont];
    CGFloat timeLabelX = nameLabelX;
    CGFloat timeLabelY = CGRectGetMaxY(_iconViewF)-timeLabelSize.height+StatuseCellBorder*0.3;
    _timeLabelF = (CGRect){timeLabelX, timeLabelY, timeLabelSize};

    // 来源
    CGSize sourceLabelSize = [_statuse.source sizeWithFont:StatuseSourceLabelFont];
    CGFloat sourceLabelX = CGRectGetMaxX(_timeLabelF)+StatuseCellBorder;
    CGFloat sourceLabelY = timeLabelY;
    _sourceLabelF = (CGRect){sourceLabelX, sourceLabelY, sourceLabelSize};


    // 正文
    CGSize contentLabelSize = [_statuse.text sizeWithFont:StatuseContentLabelFont constrainedToSize:CGSizeMake(topViewW-2*StatuseCellBorder, CGFLOAT_MAX)];
    CGFloat contentLabelX = iconViewX;
    CGFloat contentLabelY = CGRectGetMaxY(_iconViewF)+StatuseCellBorder*0.7;
    _contentLabelF = (CGRect){contentLabelX, contentLabelY, contentLabelSize};
    
    // 配图
    if (statuse.pic_urls.count) {
        CGSize photosViewSize = [CXPhotosView photosViewSizeWithPhotoCount:statuse.pic_urls.count];
        CGFloat photoViewX = contentLabelX;
        CGFloat photoViewY = CGRectGetMaxY(_contentLabelF)+StatuseCellBorder *0.7;
        _photosViewF = CGRectMake(photoViewX, photoViewY, photosViewSize.width, photosViewSize.height);
        
        // 计算 topview 的高度
        topViewH = CGRectGetMaxY(_photosViewF) + StatuseCellBorder;

    } else {
        // 计算 topview 的高度
        topViewH = CGRectGetMaxY(_contentLabelF) + StatuseCellBorder;

    }
    
    // 转发
//    /**转发背景的view*/
//    @property (nonatomic ,assign, readonly) CGRect retweetViewF;
//    /**转发昵称*/
//    @property (nonatomic ,assign, readonly) CGRect retweetNameLabelF;
//    /**转发正文*/
//    @property (nonatomic ,assign, readonly) CGRect retweetContentLabelF;
//    /**转发配图的view*/
//    @property (nonatomic ,assign, readonly) CGRect retweetPhotoViewF;
    
    if (statuse.retweeted_status) {
        // retweetViewF
        CGFloat retweetViewW = topViewW-2*StatuseCellBorder;
        CGFloat retweetViewX = StatuseCellBorder;
        CGFloat retweetViewY = CGRectGetMaxY(_contentLabelF);
        CGFloat retweetViewH = 0;
        
        // retweetNameLabelF
        NSString * name = [NSString stringWithFormat:@"@%@", _statuse.retweeted_status.user.name];
        CGSize retweetNameLabelSize = [name sizeWithFont:StatuseRetweetNameLabelFont];
        CGFloat retweetNameLabelX = StatuseCellBorder;
        CGFloat retweetNameLabelY = StatuseCellBorder *0.7;
        _retweetNameLabelF = (CGRect){retweetNameLabelX, retweetNameLabelY, retweetNameLabelSize};
        
        // retweetContentLabelF
        CGSize retweetContentLabelSize = [_statuse.retweeted_status.text sizeWithFont:StatuseRetweetContentLabelFont constrainedToSize:CGSizeMake(retweetViewW-2*StatuseCellBorder, CGFLOAT_MAX)];
        CGFloat retweetContentLabelX = retweetNameLabelX;
        CGFloat retweetContentLabelY = CGRectGetMaxY(_retweetNameLabelF)+StatuseCellBorder *0.7;
        _retweetContentLabelF = (CGRect){retweetContentLabelX, retweetContentLabelY, retweetContentLabelSize};
        
        // retweetPhotoViewF
        if (statuse.retweeted_status.pic_urls.count) {
            CGSize retweetPhotosViewSize = [CXPhotosView photosViewSizeWithPhotoCount:statuse.retweeted_status.pic_urls.count];
            CGFloat retweetPhotosViewX = retweetContentLabelX;
            CGFloat retweetPhotosViewY = CGRectGetMaxY(_retweetContentLabelF)+StatuseCellBorder *0.7;
            _retweetPhotosViewF = CGRectMake(retweetPhotosViewX, retweetPhotosViewY, retweetPhotosViewSize.width, retweetPhotosViewSize.height);

            // retweetViewF
            retweetViewH = CGRectGetMaxY(_retweetPhotosViewF)+StatuseCellBorder;
        } else {
            retweetViewH = CGRectGetMaxY(_retweetContentLabelF)+StatuseCellBorder;
        }
        
        // retweetViewF
        _retweetViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
        
        // 计算 topview 的高度
        topViewH = CGRectGetMaxY(_retweetViewF) + StatuseCellBorder;
    }
    // topview
    _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    
    
    CGFloat statusToolBarW = topViewW;
    CGFloat statusToolBarH = 30;
    CGFloat statusToolBarX = topViewX;
    CGFloat statusToolBarY = CGRectGetMaxY(_topViewF);
    _statusToolBarF = CGRectMake(statusToolBarX, statusToolBarY, statusToolBarW, statusToolBarH);
    
    
    // cell 的高度
    _cellHeight = CGRectGetMaxY(_statusToolBarF) + StatuesCellInterval;
}



@end
