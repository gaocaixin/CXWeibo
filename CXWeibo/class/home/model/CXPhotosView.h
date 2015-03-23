//
//  CXPhotosView.h
//  CXWeibo
//
//  Created by gaocaixin on 15-3-19.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXPhotosView : UIView
// 照片数组
@property (nonatomic ,strong) NSArray *photos;

// 尺寸
+ (CGSize)photosViewSizeWithPhotoCount:(int)count;

@end
