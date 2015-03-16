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
    timeLabel.font = StatuseTimeLabelFont;
    self.timeLabel = timeLabel;
    /**来源*/
    UILabel *sourceLabel = [[UILabel alloc] init];
    [topView addSubview:sourceLabel];
    sourceLabel.font = StatuseSourceLabelFont;
    self.sourceLabel = sourceLabel;
    /**正文*/
    UILabel *contentLabel = [[UILabel alloc] init];
    [topView addSubview:contentLabel];
    contentLabel.font = StatuseContentLabelFont;
    contentLabel.numberOfLines = 0;
    self.contentLabel = contentLabel;

    
}

// 添加转发
- (void)createTransmit
{
    /**转发背景的view*/
    UIImageView *retweetView = [[UIImageView alloc] init];
    [self.topView addSubview:retweetView];
    self.retweetView = retweetView;
    /**转发昵称*/
    UILabel *retweetNameLabel = [[UILabel alloc] init];
    [retweetView addSubview:retweetNameLabel];
    self.retweetNameLabel = retweetNameLabel;
    /**转发正文*/
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    [retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
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
    self.vipView.hidden = !user.isVip;
    self.vipView.image = [UIImage imageNamed:@"common_icon_membership"];
    self.vipView.frame = self.statusFrame.vipViewF;
    // 时间
    self.timeLabel.text = statues.created_at;
    self.timeLabel.frame = self.statusFrame.timeLabelF;
    // 来源
    self.sourceLabel.text = statues.source;
    self.sourceLabel.frame = self.statusFrame.sourceLabelF;
    
    // 正文
    self.contentLabel.text = statues.text;
    self.contentLabel.frame = self.statusFrame.contentLabelF;
    
}

- (void)createTransmitData
{
    
}

- (void)createToolData
{
    
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

@end
