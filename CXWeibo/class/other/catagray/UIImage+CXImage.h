//
//  UIImage+CXImage.h
//  CXWeibo
//
//  Created by mac on 15-2-5.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CXImage)

+ (instancetype)imageWithName:(NSString *)name;

/**
 *  返回一张自由拉伸的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;

@end
