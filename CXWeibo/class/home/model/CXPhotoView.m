//
//  CXPhotoView.m
//  CXWeibo
//
//  Created by gaocaixin on 15-3-19.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "CXPhotoView.h"
#import "CXPhoto.h"
#import "UIImageView+WebCache.h"

@interface CXPhotoView ()

@property (nonatomic ,weak) UIImageView *gifView;

@end

@implementation CXPhotoView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加一个Gif的小图片
        UIImage *image = [UIImage imageWithName:@"timeline_image_gif"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:imageView];
        self.gifView = imageView;
    }
    return self;
}


- (void)setPhoto:(CXPhoto *)photo
{
    _photo = photo;
    
    // 不是gif的图片不显示标签
    self.gifView.hidden = ![photo.thumbnail_pic hasSuffix:@"gif"];
    
    // 下载图片
    [self setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageWithName:@"timeline_image_placeholder"]];
}

- (void)layoutSubviews
{
    self.gifView.layer.anchorPoint = CGPointMake(1, 1);
    self.gifView.layer.position = CGPointMake(self.frame.size.width, self.frame.size.height);
}

@end
