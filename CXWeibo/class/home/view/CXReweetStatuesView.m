//
//  CXReweetStatuesView.m
//  CXWeibo
//
//  Created by gaocaixin on 15-3-17.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "CXReweetStatuesView.h"
#import "CXStatusFrame.h"
#import "GCXStatuse.h"
#import "CXUser.h"
#import "UIImageView+WebCache.h"
#import "CXPhoto.h"
#import "CXPhotosView.h"
#import "Header.h"

@interface CXReweetStatuesView ()

/**转发昵称*/
@property (nonatomic ,weak) UILabel * retweetNameLabel;
/**转发正文*/
@property (nonatomic ,weak) UILabel * retweetContentLabel;
/**转发配图的view*/
@property (nonatomic ,weak) CXPhotosView *retweetPhotosView;

@end

@implementation CXReweetStatuesView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 拉伸背景图片
        self.image = [UIImage resizedImageWithName:@"timeline_retweet_background" left:0.9 top:0.9];
        self.userInteractionEnabled = YES;
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    /**转发昵称*/
    UILabel *retweetNameLabel = [[UILabel alloc] init];
    [self addSubview:retweetNameLabel];
    retweetNameLabel.font = StatuseRetweetNameLabelFont;
    self.retweetNameLabel = retweetNameLabel;
    retweetNameLabel.textColor = [UIColor colorWithRed:67/255.0 green:107/255.0 blue:163/255.0 alpha:1];
    /**转发正文*/
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    [self addSubview:retweetContentLabel];
    retweetContentLabel.font = StatuseRetweetContentLabelFont;
    retweetContentLabel.numberOfLines = 0;
    self.retweetContentLabel = retweetContentLabel;
    retweetContentLabel.textColor = [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:1];
    /**转发配图的view*/
    CXPhotosView *retweetPhotosView = [[CXPhotosView alloc] init];
    [self addSubview:retweetPhotosView];
    self.retweetPhotosView = retweetPhotosView;

}

- (void)setStatusFrame:(CXStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    GCXStatuse *statues = _statusFrame.statuse.retweeted_status;
    CXUser *user = statues.user;

    // 存在转发的数据 布局frame
    if (statues) {
        self.hidden = NO;
        // 自己的frame
        self.frame = self.statusFrame.retweetViewF;
        
        // 昵称
        NSString *retweetNameLabel = [NSString stringWithFormat:@"@%@", user.name];
        self.retweetNameLabel.text = retweetNameLabel;
        self.retweetNameLabel.frame = self.statusFrame.retweetNameLabelF;
        
        // 正文
        self.retweetContentLabel.text = statues.text;
        self.retweetContentLabel.frame = self.statusFrame.retweetContentLabelF;
        
        // 配图
        if (statues.pic_urls.count) {
            self.retweetPhotosView.hidden = NO;
            self.retweetPhotosView.frame = self.statusFrame.retweetPhotosViewF;
            self.retweetPhotosView.photos = self.statusFrame.statuse.retweeted_status.pic_urls;
        } else {
            self.retweetPhotosView.hidden = YES;
        }
        
    } else {
        self.hidden = YES;
    }

}

@end
