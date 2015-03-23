//
//  CXTableViewCell.m
//  CXWeibo
//
//  Created by gaocaixin on 15-3-15.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "CXTableViewCell.h"
#import "CXStatusFrame.h"
#import "GCXStatuse.h"
#import "CXUser.h"
#import "UIImageView+WebCache.h"
#import "CXStatuesToolBar.h"
#import "CXTopView.h"
#import "Header.h"

@interface CXTableViewCell ()

/**背景的view*/
@property (nonatomic ,weak) CXTopView *topView;

/** 微博工具条的view*/
@property (nonatomic ,weak) CXStatuesToolBar *statusToolBar;

@end

@implementation CXTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    CXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CXTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage resizedImageWithName:@"common_card_background_highlighted"];
        cell.selectedBackgroundView =imageView;
        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 添加背景topView
        [self createOriginal];
        // 添加工具条
        [self createTool];
    }
    return self;
}

// 添加原创
- (void)createOriginal
{
    // 背景的view
    CXTopView *topView = [[CXTopView alloc] init];
    [self.contentView addSubview:topView];
    self.topView = topView;
}

// 添加工具条
- (void)createTool
{
    /**工具条的view*/
    CXStatuesToolBar *statusToolBar = [[CXStatuesToolBar alloc] init];
    [self.contentView addSubview:statusToolBar];
    self.statusToolBar = statusToolBar;
}


// frame 的 setter 方法
- (void)setStatusFrame:(CXStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    // 原创
    [self createOriginalData];
    // 添加工具条
    [self createToolData];
}

- (void)createOriginalData
{
    // 传递模型数据
    self.topView.statuesFrame = self.statusFrame;
}

- (void)createToolData
{
    // 传递模型数据
    self.statusToolBar.frame = self.statusFrame.statusToolBarF;
    self.statusToolBar.statues = self.statusFrame.statuse;
}


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// 重写这个方法 改变cell的属性
- (void)setFrame:(CGRect)frame
{
    frame.origin.x += StatuesCellBorder;
    frame.size.width -= StatuesCellBorder*2;
    frame.size.height -= StatuesCellInterval;
    [super setFrame:frame];
}

@end
