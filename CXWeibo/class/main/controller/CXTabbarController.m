//
//  CXTabbarController.m
//  CXWeibo
//
//  Created by mac on 15-2-5.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "CXTabbarController.h"
#import "CXHomeTableViewController.h"
#import "CXDiscoverTableViewController.h"
#import "CXMessageTableViewController.h"
#import "CXMineTableViewController.h"
#import "CXTarbarView.h"
#import "CXNavigationController.h"
#import "WWSideslipViewController.h"

@interface CXTabbarController () <CXTarbarViewDelegate>
@property (nonatomic, strong) CXTarbarView *tarbar;
@end

@implementation CXTabbarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
//    CXLog(@"%s", __func__);
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
    
}

- (void)viewDidLoad
{
//    CXLog(@"%s", __func__);
    [super viewDidLoad];
    
    // 初始化tarbar
    [self setTabbar];
    
    // 初始化所有控制器
    [self setAllViewControls];
    
}

- (void)setTabbar
{
//    CXLog(@"%s", __func__);
    self.tarbar = [[CXTarbarView alloc] initWithFrame:self.tabBar.bounds];
//    self.tarbar.backgroundColor = [UIColor greenColor];
    
    self.tarbar.delegate = self;
//    self.tarbar.userInteractionEnabled = YES;
}



- (void)viewWillAppear:(BOOL)animated
{
//    CXLog(@"%s", __func__);
    [super viewWillAppear:animated];
    
    // 在这里添加 可以覆盖系统item
    [self.tabBar addSubview:self.tarbar];
}

// 初始化所有控制器
- (void)setAllViewControls
{
//    CXLog(@"%s", __func__);
    CXHomeTableViewController *home = [[CXHomeTableViewController alloc] init];
    [self addChildViewController:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    
    CXMessageTableViewController *message = [[CXMessageTableViewController alloc] init];
    [self addChildViewController:message title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    
    CXDiscoverTableViewController *discover = [[CXDiscoverTableViewController alloc] init];
    [self addChildViewController:discover title:@"广场" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    
    CXMineTableViewController *mine = [[CXMineTableViewController alloc] init];
    [self addChildViewController:mine title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
}

// 初始化单个控制器
- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{

    [self.tarbar addTarBarItemWithTitle:title imageName:imageName selectedImageName:selectedImageName];
    // 设置导航控制器
    childController.navigationItem.title = title;
    CXNavigationController *nav = [[CXNavigationController alloc] initWithRootViewController:childController];
    
    // 这里会添加uibuttenitem 会覆盖自定义的view 需要手动删除item
    [self addChildViewController:nav];
    
}

- (void)tarbarViewDidClickBtn:(NSInteger)tag
{
//    CXLog(@"%s", __func__);
//    self.tabBar.selectedItem = self.tabBar.subviews[tag - 10];
    self.selectedIndex = tag - 10;
    
//    [self.navigationController pushViewController:[[UIViewController alloc] init] animated:YES];
    
}

- (void)centerBtnClicked
{
    CXLog(@"%s", __func__);
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor blueColor];
//    [self.navigationController pushViewController:vc animated:YES];
}

@end
