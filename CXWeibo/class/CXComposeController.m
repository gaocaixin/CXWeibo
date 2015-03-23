//
//  CXComposeController.m
//  CXWeibo
//
//  Created by gaocaixin on 15-3-21.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "CXComposeController.h"
#import "CXTextView.h"
#import "AFNetworking.h"
#import "Header.h"
#import "GCXAccessToken.h"
#import "CXWeiboTool.h"
#import "MBProgressHUD+MJ.h"
#import "CXComposeToolBar.h"

@interface CXComposeController ()<UITextViewDelegate, CXComposeToolBarDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic ,weak) CXTextView *textView;
@property (nonatomic ,weak) CXComposeToolBar *toolBar;
@property (nonatomic ,weak) UIImageView *imageView;
@end

@implementation CXComposeController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置导航栏
    [self setUpNav];
    
    // 创建textview
    [self createTextView];
    
    // 添加imageview
    [self createimageView];

    // 添加toolbar
    [self createToolbar];
    
}

// 创建imageView
- (void)createimageView
{
    // 添加
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(10, 100, 60, 60);
    imageView.backgroundColor = [UIColor grayColor];
    [self.textView addSubview:imageView];
    self.imageView = imageView;
}

- (void)createToolbar
{
    CXComposeToolBar *toolBar = [[CXComposeToolBar alloc] init];
    [self.view addSubview:toolBar];
    self.toolBar = toolBar;
    self.toolBar.delegate = self;
    CGFloat Y = self.view.frame.size.height - 44;
    toolBar.frame = CGRectMake(0, Y, self.view.frame.size.width, 44);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark - toolbar代理
- (void)composeToolBar:(CXComposeToolBar *)toolBar didClickedButtenType:(CXComposeToolBarButtenType)type
{
    switch (type) {
        case CXComposeToolBarButtenTypeCamera: // 相机
            [self openCamera];
            break;
        case CXComposeToolBarButtenTypePicture: // 相册
            [self openPicture];
            break;
        case CXComposeToolBarButtenTypeMention:
            
            break;
        case CXComposeToolBarButtenTypeTrend:
            
            break;
        case CXComposeToolBarButtenTypeEmotion:
            
            break;
        default:
            break;
    }
}

// 打开相册
- (void)openPicture
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

// 打开照相机
- (void)openCamera
{
    NSLog(@"拍照需要真机调试");
//    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
//    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
//    ipc.delegate = self;
//    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark - 图片选择器的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    self.imageView.image = info[UIImagePickerControllerOriginalImage];
}

// 监听键盘的弹出和收回
- (void)keyboardWillChangeFrame:(NSNotification *)nf
{
//    NSLog(@"%@", nf);
    // 获取键盘的frame改变
    CGRect keyboardF = [nf.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // toolbar的y改变值
    CGFloat keyboardH = self.view.frame.size.height - keyboardF.origin.y;
    
    float time = [nf.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:time animations:^{
        self.toolBar.transform = CGAffineTransformMakeTranslation(0, -keyboardH);
    }];
}

// 键盘会拖慢view启动的速度 因此放到这个方法里面
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}

// 创建textview
- (void)createTextView
{
    // 添加
    CXTextView *textView = [[CXTextView alloc] initWithFrame:self.view.bounds];
    textView.delegate = self;
    textView.placeholder = @"分享新鲜事......";
    [self.view addSubview:textView];
    self.textView = textView;
    // 纵向位置一直可以拖拽
    self.textView.alwaysBounceVertical = YES;
    // 通知监听文字改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChangeNotification) name:UITextViewTextDidChangeNotification object:self.textView];
    
    
}

// 监听文字改变
- (void)textViewTextDidChangeNotification
{
    BOOL hasWord = self.textView.text.length != 0;
    self.navigationItem.rightBarButtonItem.enabled = hasWord;
    self.textView.placeholder = hasWord ? @"" : @"分享新鲜事......";
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// 设置导航栏
- (void)setUpNav
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(leftBarButtonItemClick)];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
//    self.navigationItem.rightBarButtonItem.enabled = NO;

    self.navigationItem.title = @"发微博";
}

// 发送微博
- (void)rightBarButtonItemClick
{
    
    if (self.imageView.image == nil) {
        [self sendStatuseWithOutImage];
    } else {
        [self sendStatuseWithImage];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendStatuseWithOutImage
{
    AFHTTPRequestOperationManager *rom = [AFHTTPRequestOperationManager manager];
    
    GCXAccessToken *at = [CXWeiboTool accessToken];
    NSDictionary *dict = @{@"status":self.textView.text, @"access_token":at.access_token};
    
    [rom POST:@"https://api.weibo.com/2/statuses/update.json" parameters:dict
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
          
          [MBProgressHUD showSuccess:@"发送成功"];
          
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          
          CXLog(@"%@", error);
          [MBProgressHUD showError:@"发送失败"];
      }];

}

- (void)sendStatuseWithImage
{
    AFHTTPRequestOperationManager *rom = [AFHTTPRequestOperationManager manager];
    
    GCXAccessToken *at = [CXWeiboTool accessToken];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"status"] = self.textView.text;
    dict[ @"access_token"] = at.access_token;
//    dict[@"pic"] = UIImageJPEGRepresentation(self.imageView.image, 0.5);
    
//    [rom POST:@"https://api.weibo.com/2/statuses/update.json" parameters:dict
//      success:^(AFHTTPRequestOperation *operation, id responseObject) {
//          
//          [MBProgressHUD showSuccess:@"发送成功"];
//          
//      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//          
//          CXLog(@"%@", error);
//          [MBProgressHUD showError:@"发送失败"];
//      }];
    
    // 发需要上传的文件 要用这个方法 上传文件在constructingBodyWithBlock
    [rom POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 必须在这里上传数据
        NSData *data = UIImageJPEGRepresentation(self.imageView.image, 1.0);
        // name 对应的名字 fileName任意传 mimeType,文件类型
        [formData appendPartWithFileData:data name:@"pic" fileName:@"" mimeType:@"image/jpeg"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        CXLog(@"%@", error);
        [MBProgressHUD showError:@"发送失败"];
    }];
}

- (void)leftBarButtonItemClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 监听textview的滚动 收回键盘
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}



@end
