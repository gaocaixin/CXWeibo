//
//  CXComposeToolBar.h
//  CXWeibo
//
//  Created by gaocaixin on 15-3-23.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CXComposeToolBar;

typedef enum {
    CXComposeToolBarButtenTypeCamera,
    CXComposeToolBarButtenTypePicture,
    CXComposeToolBarButtenTypeMention,
    CXComposeToolBarButtenTypeTrend,
    CXComposeToolBarButtenTypeEmotion
}CXComposeToolBarButtenType;

@protocol CXComposeToolBarDelegate <NSObject>

- (void)composeToolBar:(CXComposeToolBar *)toolBar didClickedButtenType:(CXComposeToolBarButtenType)type;

@end

@interface CXComposeToolBar : UIView

@property (nonatomic ,weak) id<CXComposeToolBarDelegate> delegate;

@end
