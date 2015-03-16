//
//  CXNavigationController.m
//  CXWeibo
//
//  Created by mac on 15-2-25.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "CXNavigationController.h"

@interface CXNavigationController ()

@end

@implementation CXNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

// 此方法只能被加载一次 一个类只能被执行一次 类似于类的属性配置
+ (void)initialize
{
    // 设置导航栏主题
    [self setupNavBar];

    
    // 设置tabbaritem的主题
    [self setupNavbarItem];
}

+ (void)setupNavBar
{
    // 拿到bar总配置文件
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    // 设置背景
    if (!iOS7) {
        [navBar setBackgroundImage:[UIImage imageWithName:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
    }
    
    // 设置标题文字
    NSMutableDictionary *titleDict = [NSMutableDictionary dictionary];
    titleDict[UITextAttributeTextColor] = [UIColor blackColor];
    //    titleDict[UITextAttributeFont] = [UIFont systemFontOfSize:16];
    // 设置粗体
    titleDict[UITextAttributeFont] = [UIFont boldSystemFontOfSize:18];
    [navBar setTitleTextAttributes:titleDict];
}

// 设置导航栏按钮的主题
+ (void)setupNavbarItem
{
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    
    if (!iOS7) {
        [barItem setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [barItem setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background_pushed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        [barItem setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background_disable"] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
    }
    
    
    // 设置标题文字
    NSMutableDictionary *titleDict = [NSMutableDictionary dictionary];
    titleDict[UITextAttributeTextColor] = iOS7 ? [UIColor orangeColor] : [UIColor blackColor];
    titleDict[UITextAttributeFont] = [UIFont systemFontOfSize:iOS7 ? 16 : 14];

    [barItem setTitleTextAttributes:titleDict forState:UIControlStateNormal];
    [barItem setTitleTextAttributes:titleDict forState:UIControlStateHighlighted];
}


// 拦截导航栏push操作 隐藏tabBar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    
    [super pushViewController:viewController animated:YES];
}

@end
