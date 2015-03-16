//
//  CXNewFeature.m
//  CXWeibo
//
//  Created by mac on 15-2-28.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "CXNewFeature.h"
#import "CXTabbarController.h"

#define ImageCount 3

@interface CXNewFeature () <UIScrollViewDelegate>

@property (nonatomic, weak) UIPageControl *page;

@end

@implementation CXNewFeature

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
    
    
    [self setupScroll];
    
    [self setupPage];
    
}

- (void)setupPage
{
    CGFloat W = 0;
    CGFloat H = 0;
    CGFloat X = self.view.bounds.size.width/2 - W/2;
    CGFloat Y = self.view.bounds.size.height - 20;

    UIPageControl *page = [[UIPageControl alloc] initWithFrame:CGRectMake(X, Y, W, H)];
    page.numberOfPages = ImageCount;
    page.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_point"]];
    page.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new_feature_pagecontrol_checked_point"]];
    page.userInteractionEnabled = NO;
    [self.view addSubview:page];
    self.page = page;
}

- (void)setupScroll
{
    UIImageView *back = [[UIImageView alloc] initWithFrame:self.view.bounds];
    back.image = [UIImage imageWithName: @"new_feature_background"];
    [self.view addSubview:back];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    CGFloat imageW = self.view.bounds.size.width;
    CGFloat imageH = self.view.bounds.size.height;
    
    for (int i = 0; i < ImageCount; i++) {
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d", i+1];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:imageName];
        
        imageView.frame = CGRectMake(i * imageW, 0, imageW, imageH);
        
        [scrollView addSubview:imageView];
        
        if (i == ImageCount - 1) {
            imageView.userInteractionEnabled = YES;
            [self setupLastImageView:imageView];
        }
    }
    
    scrollView.contentSize = CGSizeMake(imageW * ImageCount, imageH);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
}

- (void)setupLastImageView:(UIImageView *)imageView
{

    UIButton *btn = [[UIButton alloc] init];
    
    [btn setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    btn.bounds = (CGRect){CGPointZero, btn.currentBackgroundImage.size};
    btn.center = CGPointMake(self.view.bounds.size.width/2, 300);
    [btn setTitle:@"开始微博" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btn) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:btn];
    
    
    
    UIButton *btn1 = [[UIButton alloc] init];
    [btn1 setImage:[UIImage imageWithName:@"new_feature_share_false"] forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageWithName:@"new_feature_share_false"] forState:UIControlStateHighlighted];
    [btn1 setImage:[UIImage imageWithName:@"new_feature_share_true"] forState:UIControlStateSelected];
    btn1.bounds = (CGRect){CGPointZero, btn.currentBackgroundImage.size};
    btn1.center = CGPointMake(self.view.bounds.size.width/2, 250);
    btn1.selected = YES;
    [btn1 setTitle:@"分享微博" forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btn1:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:btn1];
}
/**
 *  开始微博
 */
- (void)btn
{
//    CXTabbarController *tb = [[CXTabbarController alloc] init];
    // 切换根控制器
    
    [UIApplication sharedApplication].statusBarHidden = NO;
    self.view.window.rootViewController = [[CXTabbarController alloc] init];
}

- (void)btn1:(UIButton *)btn1
{
    btn1.selected = !btn1.selected;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.page.currentPage = (scrollView.contentOffset.x +self.view.bounds.size.width / 2) / self.view.bounds.size.width;
}

@end
