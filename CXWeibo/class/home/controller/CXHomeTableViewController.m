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
#import "CXUser.h"
#import "MJRefresh.h"
#import "Header.h"

@interface CXHomeTableViewController ()

@property (nonatomic, strong) NSMutableArray *statuseFrame;

@end

@implementation CXHomeTableViewController

- (NSMutableArray *)statuseFrame
{
    if (_statuseFrame == nil) {
        _statuseFrame = [[NSMutableArray alloc] init];
    }
    return _statuseFrame;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.view.backgroundColor = [UIColor colorWithWhite:226/255.0 alpha:1];
//        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, StatuesCellInterval, 0);
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpTitleBtnTitle];
    
    // 刷新
    [self createRefreshControl];
    
    // 设置导航栏btn
    [self setNavBar];
    
}

- (void)setUpTitleBtnTitle
{
    // 获取更新的微博数据
    AFHTTPRequestOperationManager *rom = [AFHTTPRequestOperationManager manager];
    GCXAccessToken *at = [CXWeiboTool accessToken];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"access_token"] = at.access_token;
    dict[@"uid"] = @(at.uid);
    
    [rom GET:@"https://api.weibo.com/2/users/show.json" parameters:dict
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         // 通过数据查看是字典模型
         CXUser *user = [CXUser objectWithKeyValues:responseObject];
         [(CXButton *)self.navigationItem.titleView setTitle:user.name forState:UIControlStateNormal];
         
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
         CXLog(@"%@", error);
     }];

}


- (void)createRefreshControl
{
//    // 下拉刷新 系统的
//    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
//    // 监听刷新界面的只改变
//    [refresh addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
//    [self.tableView addSubview:refresh];
//    
//    [refresh beginRefreshing];
//    
//    [self refresh:refresh];
    
    [self.tableView addHeaderWithTarget:self action:@selector(refresh)];
    [self.tableView headerBeginRefreshing];
    
    // 上拉刷新
    [self.tableView addFooterWithTarget:self action:@selector(footerRefresh)];
    
}

- (void)footerRefresh
{
    // 获取更新的微博数据
    AFHTTPRequestOperationManager *rom = [AFHTTPRequestOperationManager manager];
    GCXAccessToken *at = [CXWeiboTool accessToken];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"access_token"] = at.access_token;
    
//    if (self.statuseFrame.count) {
        CXStatusFrame *statuesFrame = [self.statuseFrame lastObject];
        long long maxid = [statuesFrame.statuse.idstr longLongValue]-1;
        dict[@"max_id"] = @(maxid);
//    }
    
    
    [rom GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:dict
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         // 数据模型转对象 statues模型
         NSArray *arr = responseObject[@"statuses"];
         
         NSArray *statuesArr = [GCXStatuse objectArrayWithKeyValuesArray:arr];
         
         
         [self createTableTitileView:statuesArr.count];
         
         // 转 statuesFrme 模型
         NSMutableArray *statuesFrmeM = [NSMutableArray array];
         for ( GCXStatuse *statue in statuesArr) {
             CXStatusFrame *statusFrame = [[CXStatusFrame alloc] init];
             statusFrame.statuse = statue;
             [statuesFrmeM addObject:statusFrame];
         }
         
         //追加到旧数据的前面
         NSMutableArray *arrM = [NSMutableArray array];
         [arrM addObjectsFromArray:self.statuseFrame];
         [arrM addObjectsFromArray:statuesFrmeM];
         self.statuseFrame = arrM;
         
         [self.tableView reloadData];
         
         // 停止旋转
         [self.tableView footerEndRefreshing];
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         CXLog(@"%@", error);
     }];
}

- (void)refresh
{
    // 获取更新的微博数据
    AFHTTPRequestOperationManager *rom = [AFHTTPRequestOperationManager manager];
    GCXAccessToken *at = [CXWeiboTool accessToken];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"access_token"] = at.access_token;
    
    if (self.statuseFrame.count) {
        CXStatusFrame *statuesFrame = self.statuseFrame[0];
        dict[@"since_id"] = statuesFrame.statuse.idstr;
    }
    
    
    [rom GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:dict
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         // 数据模型转对象 statues模型
         NSArray *arr = responseObject[@"statuses"];
         
         NSArray *statuesArr = [GCXStatuse objectArrayWithKeyValuesArray:arr];
         
         // 设置显示提醒刷新多少条微博的btn
         [self createTableTitileView:statuesArr.count];
         
         // 转 statuesFrme 模型
         NSMutableArray *statuesFrmeM = [NSMutableArray array];
         for ( GCXStatuse *statue in statuesArr) {
             CXStatusFrame *statusFrame = [[CXStatusFrame alloc] init];
             statusFrame.statuse = statue;
             [statuesFrmeM addObject:statusFrame];
         }
         
         //追加到旧数据的前面
         NSMutableArray *arrM = [NSMutableArray array];
         [arrM addObjectsFromArray:statuesFrmeM];
         [arrM addObjectsFromArray:self.statuseFrame];
         self.statuseFrame = arrM;
         
         [self.tableView reloadData];
         
         // 停止刷新状态
         [self.tableView headerEndRefreshing];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         CXLog(@"%@", error);
         // 停止刷新状态
         [self.tableView headerEndRefreshing];
     }];
}

- (void)createTableTitileView:(int)count
{
    // 初始化的位置
    
    CGFloat H = 30;
    CGFloat X = StatuesCellBorder;
    CGFloat Y = 64-H;
    CGFloat W = [UIScreen mainScreen].bounds.size.width - 2*X;
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(X, Y, W, H)];
    btn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"timeline_new_status_background"]];
    // 放到导航栏的下面
    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
    
    // 设置title
    NSString *title = [NSString stringWithFormat:@"共有%d条新微博", count];
    if (count == 0) {
        title = @"没有新微博";
    }
    [btn setTitle:title forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.75 animations:^{
        btn.transform = CGAffineTransformMakeTranslation(0, H+1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.75 delay:0.5 options:0 animations:^{
            btn.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            // 删除btn
            [btn removeFromSuperview];
        }];
    }];
}

- (void)setNavBar
{
        // 添加uibarbutten 抽取代码 用到分类
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtenItemWithIcon:@"navigationbar_friendsearch" highIcon:@"navigationbar_friendsearch_highlighted" action:@selector(friendsearch) target:self];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtenItemWithIcon:@"navigationbar_pop" highIcon:@"navigationbar_pop_highlighted" action:@selector(pop) target:self];
    
    // 中间按钮
    CXButton *btn = [CXButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"首页" forState:UIControlStateNormal];
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
