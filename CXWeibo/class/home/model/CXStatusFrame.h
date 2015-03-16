//
//  CXStatusFrame.h
//  CXWeibo
//
//  Created by gaocaixin on 15-3-15.
//  assignright (c) 2015年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GCXStatuse;


#define StatuseCellBorder 10

// 名字的字体
#define StatuseNameLabelFont [UIFont systemFontOfSize:16]
// 时间的字体
#define StatuseTimeLabelFont [UIFont systemFontOfSize:14]
// 来源的字体
#define StatuseSourceLabelFont [UIFont systemFontOfSize:14]
// 正文的字体
#define StatuseContentLabelFont [UIFont systemFontOfSize:14]

// 转发正文的字体
#define StatuseRetweetContentLabelFont [UIFont systemFontOfSize:14]

// 转发昵称的字体
#define StatuseRetweetNameLabelFont [UIFont systemFontOfSize:15]

// cell 的宽度
#define StatuesCellBorder 10
// cell 的间隔
#define StatuesCellInterval 10

@interface CXStatusFrame : NSObject

@property (nonatomic ,strong) GCXStatuse * statuse;

/**背景的view*/
@property (nonatomic ,assign, readonly) CGRect topViewF;
/**头像的view*/
@property (nonatomic ,assign, readonly) CGRect iconViewF;
/**会员的view*/
@property (nonatomic ,assign, readonly) CGRect vipViewF;
/**配图的view*/
@property (nonatomic ,assign, readonly) CGRect photoViewF;
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
@property (nonatomic ,assign, readonly) CGRect retweetPhotoViewF;


/** 微博工具条的view*/
@property (nonatomic ,assign, readonly) CGRect statusToolBarF;
/** cell的height*/
@property (nonatomic ,assign, readonly) CGFloat cellHeight;

@end
