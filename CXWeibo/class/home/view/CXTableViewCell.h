//
//  CXTableViewCell.h
//  CXWeibo
//
//  Created by gaocaixin on 15-3-15.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CXStatusFrame;

@interface CXTableViewCell : UITableViewCell

@property (nonatomic ,strong) CXStatusFrame *statusFrame;


+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
