//
//  CXHomeTableViewController.m
//  CXWeibo
//
//  Created by mac on 15-2-5.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "CXHomeTableViewController.h"
#import "UIBarButtonItem+Icon.h"
#import "CXButton.h"
#import "AFNetworking.h"
#import "CXWeiboTool.h"
#import "GCXAccessToken.h"
#import "UIImageView+WebCache.h"
#import "GCXStatuse.h"
#import "CXUser.h"
#import "MJExtension.h"
#import "CXStatusFrame.h"
#import "CXTableViewCell.h"

@interface CXHomeTableViewController ()

@property (nonatomic, strong) NSArray *statuseFrame;

@end

@implementation CXHomeTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.view.backgroundColor = [UIColor colorWithWhite:226/255.0 alpha:1];
        self.tableView.contentInset = UIEdgeInsetsMake(StatuesCellInterval, 0, StatuesCellInterval, 0);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // 设置导航栏btn
    [self setNavBar];
    
    // 刷新数据
    [self setUpStatusData];
}


- (void)setUpStatusData
{
    AFHTTPRequestOperationManager *rom = [AFHTTPRequestOperationManager manager];
    GCXAccessToken *at = [CXWeiboTool accessToken];
    NSDictionary *dict = @{@"access_token":at.access_token};
    
    [rom GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:dict
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
//          CXLog(@"success---%@", responseObject);
          // 数据模型转对象 statues模型
          NSArray *arr = responseObject[@"statuses"];
          
          NSArray *statuesArr = [GCXStatuse objectArrayWithKeyValuesArray:arr];
          // 转 statuesFrme 模型
          NSMutableArray *statuesFrmeM = [NSMutableArray array];
          for ( GCXStatuse *statue in statuesArr) {
              CXStatusFrame *statusFrame = [[CXStatusFrame alloc] init];
              statusFrame.statuse = statue;
              [statuesFrmeM addObject:statusFrame];
          }
          self.statuseFrame = statuesFrmeM;
          
          [self.tableView reloadData];
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          CXLog(@"%@", error);
          }];

}

- (void)setNavBar
{
        // 添加uibarbutten 抽取代码 用到分类
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtenItemWithIcon:@"navigationbar_friendsearch" highIcon:@"navigationbar_friendsearch_highlighted" action:@selector(friendsearch) target:self];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtenItemWithIcon:@"navigationbar_pop" highIcon:@"navigationbar_pop_highlighted" action:@selector(pop) target:self];
    
    // 中间按钮
    CXButton *btn = [CXButton buttonWithType:UIButtonTypeCustom];
    btn.bounds = CGRectMake(0, 0, 90, 40);
    [btn setTitle:@"好友" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageWithName:@"navigationbar_arrow_down"]forState:UIControlStateNormal];
    btn.adjustsImageWhenHighlighted = NO;
    [btn setBackgroundImage:[UIImage resizedImageWithName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnTouchUpOutside:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = btn;
}

- (void)btnTouchUpOutside:(CXButton *)btn
{
    btn.selected = !btn.selected;
    [btn setImage:[UIImage imageWithName:btn.selected?@"navigationbar_arrow_up":@"navigationbar_arrow_down"]forState:UIControlStateNormal];
}

- (void)friendsearch
{
//    CXLog(@"friendsearch");
}


- (void)pop
{
//    CXLog(@"pop");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statuseFrame.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建 cell
    CXTableViewCell *cell = [CXTableViewCell cellWithTableView:tableView];
    
    // 传递模型
    cell.statusFrame = self.statuseFrame[indexPath.row];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CXStatusFrame *statuesFrame = self.statuseFrame[indexPath.row];
    return statuesFrame.cellHeight;
}

@end
