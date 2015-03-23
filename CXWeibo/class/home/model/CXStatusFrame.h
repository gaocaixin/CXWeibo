//
//  CXStatusFrame.h
//  CXWeibo
//
//  Created by gaocaixin on 15-3-15.
//  assignright (c) 2015年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GCXStatuse;



@interface CXStatusFrame : NSObject

@property (nonatomic ,strong) GCXStatuse * statuse;

/**背景的view*/
@property (nonatomic ,assign, readonly) CGRect topViewF;
/**头像的view*/
@property (nonatomic ,assign, readonly) CGRect iconViewF;
/**会员的view*/
@property (nonatomic ,assign, readonly) CGRect vipViewF;
/**配图的view*/
@property (nonatomic ,assign, readonly) CGRect photosViewF;
/**昵称*/
@property (nonatomic ,assign, readonly) CGRect nameLabelF;
/**时间*/
@property (nonatomic ,assign, readonly) CGRect timeLabelF;
/**来源*/
@property (nonatomic ,assign, readonly) CGRect sourceLabelF;
/**正文*/
@property (nonatomic ,assign, readonly) CGRect contentLabelF;


/**转发背景的view*/
@property (nonatomic ,assign, readonly) CGRect retweetViewF;
/**转发昵称*/
@property (nonatomic ,assign, readonly) CGRect retweetNameLabelF;
/**转发正文*/
@property (nonatomic ,assign, readonly) CGRect retweetContentLabelF;
/**转发配图的view*/
@property (nonatomic ,assign, readonly) CGRect retweetPhotosViewF;


/** 微博工具条的view*/
@property (nonatomic ,assign, readonly) CGRect statusToolBarF;
/** cell的height*/
@property (nonatomic ,assign, readonly) CGFloat cellHeight;

@end
