//
//  CXPhotosView.m
//  CXWeibo
//
//  Created by gaocaixin on 15-3-19.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "CXPhotosView.h"
#import "CXPhoto.h"
#import "CXPhotosView.h"
#import "CXPhotoView.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "Header.h"



@implementation CXPhotosView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 初始化9个控件
        for (int i = 0; i < 9; i++) {
            CXPhotoView *photoView = [[CXPhotoView alloc] init];
            photoView.userInteractionEnabled = YES;
            photoView.tag = i;
            [photoView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(photoTap:)]];
            [self addSubview:photoView];
        }
        
    }
    return self;
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    for (int i = 0; i < self.subviews.count; i++) {
        CXPhotoView *photoView = self.subviews[i];
        
        if (i < photos.count) {
            // 显示图片
            photoView.hidden = NO;
            // 传递模型数据
            photoView.photo = photos[i];
            // 设置子控件frame
            int maxColums = (photos.count == 4) ? 2 : 3;
            int col = i % maxColums;
            int row = i / maxColums;
            CGFloat photoX = col * (CXPhotoW+CXPhotoMargin);
            CGFloat photoY = row * (CXPhotoH +CXPhotoMargin);
            photoView.frame = CGRectMake(photoX, photoY, CXPhotoW, CXPhotoH);
            
            if (photos.count == 1) {
                photoView.contentMode = UIViewContentModeScaleAspectFit;
                photoView.clipsToBounds = NO;
            } else {
                photoView.contentMode = UIViewContentModeScaleAspectFill;
                photoView.clipsToBounds = YES;
            }
        } else {
            photoView.hidden = YES;
        }
    }
}

- (void)photoTap:(UITapGestureRecognizer *)tap
{
    int count = self.photos.count;
    
    NSMutableArray *myphotos = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count; i++) {
        // 一个mjphoto对象 显示一张图片
        MJPhoto * mjphoto = [[MJPhoto alloc] init];
        // 来源于哪一个uiimaheview
        mjphoto.srcImageView = self.subviews[i];
        
        CXPhoto *cxphoto = self.photos[i];
        NSString *photoUrl = [cxphoto.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        mjphoto.url = [NSURL URLWithString:photoUrl];
        
        [myphotos addObject:mjphoto];
    }
    
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    
    browser.currentPhotoIndex = tap.view.tag;
    
    browser.photos = myphotos;
    
    [browser show];
}


+ (CGSize)photosViewSizeWithPhotoCount:(int)count
{
    // 一行最多3列
    int maxColumns = (count == 4) ? 2 : 3;
    
    // 总行数
    int rows = (count + maxColumns - 1) / maxColumns;
    // 高度
    CGFloat photosH = rows * CXPhotoH + (rows - 1) * CXPhotoMargin;
    
    // 总列数
    int cols = (count >= maxColumns) ? maxColumns : count;
    
    // 宽度
    CGFloat photosW = cols * CXPhotoW + (cols - 1) * CXPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
    
}


@end
