//
//  UIImage+CXImage.m
//  CXWeibo
//
//  Created by mac on 15-2-5.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "UIImage+CXImage.h"

@implementation UIImage (CXImage)

+ (instancetype)imageWithName:(NSString *)name
{
    if (iOS7) {
        NSString *newName = [name stringByAppendingString:@"_os7"];
        
        UIImage *image7 = [UIImage imageNamed:newName];
        
        if (image7 == nil) {
            return [UIImage imageNamed:name];
        }
        
        return image7;
    }
    return [UIImage imageNamed:name];
}

+ (UIImage *)resizedImageWithName:(NSString *)name
{
    UIImage *image = [self imageWithName:name];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
}


@end
