//
//  GCXOAuthViewController.m
//  CXWeibo
//
//  Created by mac on 15-3-10.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "GCXOAuthViewController.h"
#import "AFNetworking.h"
#import "GCXAccessToken.h"
#import "CXWeiboTool.h"
#import "MBProgressHUD+MJ.h"
#import "Header.h"



@interface GCXOAuthViewController () <UIWebViewDelegate>

@end

@implementation GCXOAuthViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.delegate = self;
    [self.view addSubview:webView];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", client_id, redirect_uri]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

#pragma mark - 代理方法

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *str = [request.URL absoluteString];
    NSRange range = [str rangeOfString:@"code="];
    if (range.length) {
        
        str = [str substringFromIndex:range.location+range.length];
        
        [self createAccessToken:str];
        
        // 授权成功 不返回回调页面
        return NO;
    }
    return YES;
}

- (void)createAccessToken:(NSString *)str
{
    /**
     *  client_id	true	string	申请应用时分配的AppKey。
     client_secret	true	string	申请应用时分配的AppSecret。
     grant_type	true	string	请求的类型，填写authorization_code
     
     grant_type为authorization_code时
     必选	类型及范围	说明
     code	true	string	调用authorize获得的code值。
     redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
     */
    
    AFHTTPRequestOperationManager *rom = [AFHTTPRequestOperationManager manager];
    NSDictionary *dict = @{@"client_id":client_id, @"client_secret":client_secret, @"grant_type":@"authorization_code", @"code":str, @"redirect_uri":redirect_uri};
    
    [rom POST:@"https://api.weibo.com/oauth2/access_token" parameters:dict
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        CXLog(@"%@", responseObject);
          // 转模型
          GCXAccessToken *at = [[GCXAccessToken alloc] initWithDict:responseObject];
          
          [CXWeiboTool saveAccessToken:at];
          
          [CXWeiboTool chooseVC];
          
          [MBProgressHUD hideHUD];
          
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        CXLog(@"%@", error);
        [MBProgressHUD hideHUD];
    }];
    
    /**
     *  {
     "access_token" = "2.00DnkZdFmqCAUBae9aaf72dasBPPNC";
     "expires_in" = 106187;
     "remind_in" = 106187;
     uid = 5165462609;
     }
     */
    
}

// 开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在帮你加载...."];
}

// 加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}
@end
