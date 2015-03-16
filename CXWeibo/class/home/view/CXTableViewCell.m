//
//  CXTableViewCell.m
//  CXWeibo
//
//  Created by gaocaixin on 15-3-15.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "CXTableViewCell.h"
#import "CXStatusFrame.h"
#import "GCXStatuse.h"
#import "CXUser.h"
#import "UIImageView+WebCache.h"

@interface CXTableViewCell ()

/**背景的view*/
@property (nonatomic ,weak) UIImageView *topView;
/**头像的view*/
@property (nonatomic ,weak) UIImageView *iconView;
/**会员的view*/
@property (nonatomic ,weak) UIImageView *vipView;
/**配图的view*/
@property (nonatomic ,weak) UIImageView *photoView;
/**昵称*/
@property (nonatomic ,weak) UILabel * nameLabel;
/**时间*/
@property (nonatomic ,weak) UILabel * timeLabel;
/**来源*/
@property (nonatomic ,weak) UILabel * sourceLabel;
/**正文*/
@property (nonatomic ,weak) UILabel * contentLabel;


/**转发背景的view*/
@property (nonatomic ,weak) UIImageView *retweetView;
/**转发昵称*/
@property (nonatomic ,weak) UILabel * retweetNameLabel;
/**转发正文*/
@property (nonatomic ,weak) UILabel * retweetContentLabel;
/**转发配图的view*/
@property (nonatomic ,weak) UIImageView *retweetPhotoView;


/** 微博工具条的view*/
@property (nonatomic ,weak) UIImageView *statusToolBar;

@end

@implementation CXTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    CXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CXTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage resizedImageWithName:@"common_card_background_highlighted"];
        cell.selectedBackgroundView =imageView;
        
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 添加原创
        [self createOriginal];
        
        // 添加转发
        [self createTransmit];
        
        // 添加工具条
        [self createTool];

    }
    return self;
}

// 添加原创
- (void)createOriginal
{
    // 最外面的父控件
    UIImageView *topView = [[UIImageView alloc] init];
    [self.contentView addSubview:topView];
    self.topView = topView;
    topView.image = [UIImage resizedImageWithName:@"timeline_card_top_background"];
    topView.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_top_background_highlighted"];
    
    // 头像的父控件
    UIImageView *iconView = [[UIImageView alloc] init];
    [topView addSubview:iconView];
    self.iconView = iconView;
    // 会员的父控件
    UIImageView *vipView = [[UIImageView alloc] init];
    [topView addSubview:vipView];
    self.vipView = vipView;
    // 配图父控件
    UIImageView *photoView = [[UIImageView alloc] init];
    [topView addSubview:photoView];
    self.photoView = photoView;
    
    /**昵称*/
    UILabel *nameLabel = [[UILabel alloc] init];
    [topView addSubview:nameLabel];
    nameLabel.font = StatuseNameLabelFont;
    self.nameLabel = nameLabel;
    /**时间*/
    UILabel *timeLabel = [[UILabel alloc] init];
    [topView addSubview:timeLabel];
    timeLabel.textColor = [UIColor colorWithRed:240/255.0 green:150/255.0 blue:50/255.0 alpha:1];
    timeLabel.font = StatuseTimeLabelFont;
    self.timeLabel = timeLabel;
    /**来源*/
    UILabel *sourceLabel = [[UILabel alloc] init];
    [topView addSubview:sourceLabel];
    sourceLabel.textColor = [UIColor colorWithRed:135/255.0 green:135/255.0 blue:135/255.0 alpha:1];
    sourceLabel.font = StatuseSourceLabelFont;
    self.sourceLabel = sourceLabel;
    /**正文*/
    UILabel *contentLabel = [[UILabel alloc] init];
    [topView addSubview:contentLabel];
    contentLabel.textColor = [UIColor colorWithRed:39/255.0 green:39/255.0 blue:39/255.0 alpha:1];
    contentLabel.font = StatuseContentLabelFont;
    contentLabel.numberOfLines = 0;
    self.contentLabel = contentLabel;

    
}

// 添加转发
- (void)createTransmit
{
    /**转发背景的view*/
    UIImageView *retweetView = [[UIImageView alloc] init];
    retweetView.image = [UIImage resizedImageWithName:@"timeline_retweet_background" left:1 top:1];
    [self.topView addSubview:retweetView];
    self.retweetView = retweetView;
    /**转发昵称*/
    UILabel *retweetNameLabel = [[UILabel alloc] init];
    [retweetView addSubview:retweetNameLabel];
    retweetNameLabel.font = StatuseRetweetNameLabelFont;
    self.retweetNameLabel = retweetNameLabel;
    retweetNameLabel.textColor = [UIColor colorWithRed:67/255.0 green:107/255.0 blue:163/255.0 alpha:1];
    /**转发正文*/
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    [retweetView addSubview:retweetContentLabel];
    retweetContentLabel.font = StatuseRetweetContentLabelFont;
    retweetContentLabel.numberOfLines = 0;
    self.retweetContentLabel = retweetContentLabel;
    retweetContentLabel.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1];
    /**转发配图的view*/
    UIImageView *retweetPhotoView = [[UIImageView alloc] init];
    [retweetView addSubview:retweetPhotoView];
    self.retweetPhotoView = retweetPhotoView;
}

// 添加工具条
- (void)createTool
{
    /**工具条背景的view*/
    UIImageView *statusToolBar = [[UIImageView alloc] init];
    [self.contentView addSubview:statusToolBar];
    self.statusToolBar = statusToolBar;
    
    statusToolBar.image = [UIImage resizedImageWithName:@"timeline_card_bottom_background"];
    statusToolBar.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_bottom_background_highlighted"];
}

- (void)setStatusFrame:(CXStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    // 原创
    [self createOriginalData];
    
    // 转发
    [self createTransmitData];
    
    // 添加工具条
    [self createToolData];
}

- (void)createOriginalData
{
    GCXStatuse *statues = self.statusFrame.statuse;
    CXUser *user = statues.user;
    
    // topview
    self.topView.frame = self.statusFrame.topViewF;
    
    // 头像
    [self.iconView setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    self.iconView.frame = self.statusFrame.iconViewF;
    
    // 昵称
    self.nameLabel.text = user.name;
    self.nameLabel.frame = self.statusFrame.nameLabelF;
    
    // vip
//    self.vipView.hidden = !user.isVip;
//    self.vipView.image = [UIImage imageNamed:@"common_icon_membership"];
//    self.vipView.frame = self.statusFrame.vipViewF;
    if (user.isVip) {
        self.vipView.hidden = NO;
        self.vipView.image = [UIImage imageNamed:@"common_icon_membership"];
        self.vipView.frame = self.statusFrame.vipViewF;
    } else {
        self.vipView.hidden = YES;
    }
    
    // 时间
    self.timeLabel.text = statues.created_at;
    self.timeLabel.frame = self.statusFrame.timeLabelF;
    // 来源
    self.sourceLabel.text = statues.source;
    self.sourceLabel.frame = self.statusFrame.sourceLabelF;
    
    // 正文
    self.contentLabel.text = statues.text;
    self.contentLabel.frame = self.statusFrame.contentLabelF;
    
    // 配图
//    self.photoView.hidden = (BOOL)statues.thumbnail_pic;
//    [self.photoView setImageWithURL:[NSURL URLWithString:statues.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
//    self.photoView.frame = self.statusFrame.photoViewF;
    if (statues.thumbnail_pic) {
        self.photoView.hidden = NO;
        [self.photoView setImageWithURL:[NSURL URLWithString:statues.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        self.photoView.frame = self.statusFrame.photoViewF;
    } else {
        self.photoView.hidden = YES;
    }
    
}

- (void)createTransmitData
{
    GCXStatuse *statues = self.statusFrame.statuse.retweeted_status;
    CXUser *user = statues.user;
    
    /**转发背景的view*/
//    @property (nonatomic ,weak) UIImageView *retweetView;
//    /**转发昵称*/
//    @property (nonatomic ,weak) UILabel * retweetNameLabel;
//    /**转发正文*/
//    @property (nonatomic ,weak) UILabel * retweetContentLabel;
//    /**转发配图的view*/
//    @property (nonatomic ,weak) UIImageView *retweetPhotoView;
    if (statues) {
        self.retweetView.hidden = NO;
        
        self.retweetView.frame = self.statusFrame.retweetViewF;
        
        self.retweetNameLabel.text = user.name;
        self.retweetNameLabel.frame = self.statusFrame.retweetNameLabelF;
        
        self.retweetContentLabel.text = statues.text;
        self.retweetContentLabel.frame = self.statusFrame.retweetContentLabelF;
        
        // 配图
        if (statues.thumbnail_pic) {
            self.retweetPhotoView.hidden = NO;
            [self.retweetPhotoView setImageWithURL:[NSURL URLWithString:statues.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
            self.retweetPhotoView.frame = self.statusFrame.retweetPhotoViewF;
        } else {
            self.retweetPhotoView.hidden = YES;
        }
        
    } else {
        self.retweetView.hidden = YES;
    }
}

- (void)createToolData
{
    self.statusToolBar.frame = self.statusFrame.statusToolBarF;
    
}


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x += StatuesCellBorder;
    frame.size.width -= StatuesCellBorder*2;
    frame.size.height -= StatuesCellInterval;
//    frame.origin.y += StatuesCellInterval;
    [super setFrame:frame];
}

@end
