//
//  CXTarbarView.h
//  CXWeibo
//
//  Created by mac on 15-2-6.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  CXTarbarViewDelegate<NSObject>

- (void)tarbarViewDidClickBtn:(NSInteger)tag;

- (void)centerBtnClicked;

@end

@interface CXTarbarView : UIView

@property (nonatomic, weak) id<CXTarbarViewDelegate> delegate;

- (void)addTarBarItemWithTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName;
@end
