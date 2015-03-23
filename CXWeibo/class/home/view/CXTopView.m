//
//  CXTopView.m
//  CXWeibo
//
//  Created by gaocaixin on 15-3-17.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "CXTopView.h"
#import "CXUser.h"
#import "CXStatusFrame.h"
#import "GCXStatuse.h"
#import "UIImageView+WebCache.h"
#import "CXReweetStatuesView.h"
#import "CXPhoto.h"
#import "CXPhotosView.h"
#import "Header.h"


@interface CXTopView ()

/**头像的view*/
@property (nonatomic ,weak) UIImageView *iconView;
/**会员的view*/
@property (nonatomic ,weak) UIImageView *vipView;

/**配图的view*/
@property (nonatomic ,weak) CXPhotosView *photosView;
/**昵称*/
@property (nonatomic ,weak) UILabel * nameLabel;
/**时间*/
@property (nonatomic ,weak) UILabel * timeLabel;
/**来源*/
@property (nonatomic ,weak) UILabel * sourceLabel;
/**正文*/
@property (nonatomic ,weak) UILabel * contentLabel;

/**转发背景的view*/
@property (nonatomic ,weak) CXReweetStatuesView *retweetView;

@end

@implementation CXTopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        
        self.image = [UIImage resizedImageWithName:@"timeline_card_top_background"];
        self.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_top_background_highlighted"];

        [self setUp];
        
        [self setUpReweetView];
    }
    return self;
}

- (void)setUpReweetView
{
    /**转发背景的view*/
    CXReweetStatuesView *retweetView = [[CXReweetStatuesView alloc] init];
    [self addSubview:retweetView];
    self.retweetView = retweetView;
}

- (void)setUp
{
    // 头像的父控件
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    self.iconView = iconView;
    // 会员的父控件
    UIImageView *vipView = [[UIImageView alloc] init];
    [self addSubview:vipView];
    vipView.contentMode = UIViewContentModeCenter;
    self.vipView = vipView;
    // 配图父控件
    CXPhotosView *photosView = [[CXPhotosView alloc] init];
    [self addSubview:photosView];
    self.photosView = photosView;
    
    /**昵称*/
    UILabel *nameLabel = [[UILabel alloc] init];
    [self addSubview:nameLabel];
    nameLabel.font = StatuseNameLabelFont;
    self.nameLabel = nameLabel;
    /**时间*/
    UILabel *timeLabel = [[UILabel alloc] init];
    [self addSubview:timeLabel];
    timeLabel.textColor = [UIColor colorWithRed:240/255.0 green:150/255.0 blue:50/255.0 alpha:1];
    timeLabel.font = StatuseTimeLabelFont;
    self.timeLabel = timeLabel;
    /**来源*/
    UILabel *sourceLabel = [[UILabel alloc] init];
    [self addSubview:sourceLabel];
    sourceLabel.textColor = [UIColor colorWithRed:135/255.0 green:135/255.0 blue:135/255.0 alpha:1];
    sourceLabel.font = StatuseSourceLabelFont;
    self.sourceLabel = sourceLabel;
    /**正文*/
    UILabel *contentLabel = [[UILabel alloc] init];
    [self addSubview:contentLabel];
    contentLabel.textColor = [UIColor colorWithRed:39/255.0 green:39/255.0 blue:39/255.0 alpha:1];
    contentLabel.font = StatuseContentLabelFont;
    contentLabel.numberOfLines = 0;
    self.contentLabel = contentLabel;
    
}

- (void)setStatuesFrame:(CXStatusFrame *)statuesFrame
{
    
    _statuesFrame = statuesFrame;
    GCXStatuse *statues = _statuesFrame.statuse;
    CXUser *user = statues.user;
    
    // topview
    self.frame = statuesFrame.topViewF;
    
    // 头像
    [self.iconView setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    self.iconView.frame = statuesFrame.iconViewF;
    
    // 昵称
    self.nameLabel.text = user.name;
    self.nameLabel.frame = self.statuesFrame.nameLabelF;
    
    
    // vip
    if (user.mbtype > 2) {
        self.vipView.hidden = NO;
        self.vipView.frame = statuesFrame.vipViewF;
        NSString *name = [NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank];
        self.vipView.image = [UIImage imageNamed:name];
        self.nameLabel.textColor = [UIColor colorWithRed:240/255.0 green:150/255.0 blue:50/255.0 alpha:1];
    } else {
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    
    // 时间
    self.timeLabel.text = statues.created_at;
    //    self.timeLabel.frame = self.statusFrame.timeLabelF;
    // 时间
    CGSize timeLabelSize = [statues.created_at sizeWithFont:StatuseTimeLabelFont];
    CGFloat timeLabelX = self.nameLabel.frame.origin.x;
    CGFloat timeLabelY = CGRectGetMaxY(self.iconView.frame)-timeLabelSize.height+StatuseCellBorder*0.3;
    self.timeLabel.frame = (CGRect){timeLabelX, timeLabelY, timeLabelSize};
    
    // 来源
    self.sourceLabel.text = statues.source;
    //    self.sourceLabel.frame = self.statusFrame.sourceLabelF;
    
    CGSize sourceLabelSize = [statues.source sizeWithFont:StatuseSourceLabelFont];
    CGFloat sourceLabelX = CGRectGetMaxX(self.timeLabel.frame)+StatuseCellBorder;
    CGFloat sourceLabelY = timeLabelY;
    self.sourceLabel.frame = (CGRect){sourceLabelX, sourceLabelY, sourceLabelSize};
    
    // 正文
    self.contentLabel.text = statues.text;
    self.contentLabel.frame = statuesFrame.contentLabelF;
    
    // 配图
    //    self.photoView.hidden = (BOOL)statues.thumbnail_pic;
    //    [self.photoView setImageWithURL:[NSURL URLWithString:statues.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    //    self.photoView.frame = self.statusFrame.photoViewF;
    if (statues.pic_urls.count) {
        self.photosView.hidden = NO;
        self.photosView.frame = statuesFrame.photosViewF;
        self.photosView.photos = statues.pic_urls;
    } else {
        self.photosView.hidden = YES;
    }
    
    self.retweetView.statusFrame = statuesFrame;
}

@end
