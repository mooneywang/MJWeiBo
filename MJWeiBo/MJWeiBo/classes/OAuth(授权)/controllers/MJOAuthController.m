//
//  MJOAuthController.m
//  MJWeiBo
//
//  Created by 王梦杰 on 16/1/19.
//  Copyright (c) 2016年 Mooney_wang. All rights reserved.
//

#import "MJOAuthController.h"
#import "AFHTTPRequestOperationManager.h"
#import "MJAccount.h"
#import "MBProgressHUD+MJ.h"
#import "MJAccountTool.h"
#import "UIWindow+Extension.h"

@interface MJOAuthController () <UIWebViewDelegate>

@end

@implementation MJOAuthController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    //第二个参数为回调地址，如果没有设置回调地址，默认是http://，如果设置了回调地址，必须与回调地址一致
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=613872604&redirect_uri=http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark - UIWebViewDelegate
//可以用来拦截网络请求
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //获取url字符串
    NSString *url = request.URL.absoluteString;
//    NSLog(@"shouldStartLoadWithRequest - %@",url);
    NSRange range = [url rangeOfString:@"code="];
    //判断是否为回调地址，点击授权之后发出的请求带有code参数，我们需要拦截该url，取出code的值
    if (range.length != 0) {//是回调地址
        //截取code的值
        NSInteger fromIndex = range.location + range.length;
        NSString *code = [url substringFromIndex:fromIndex];
        //获取token
        [self accessTokenWithCode:code];
        
        //禁止跳转到回调页面
        return NO;
    }
    
    return YES;
}

//开始加载网页的时候调用
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showMessage:@"正在加载..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideHUD];
}

/**
 *  根据授权成功的标记获取access token
 */
- (void)accessTokenWithCode:(NSString *)code{
    /*
     https://api.weibo.com/oauth2/access_token
     client_id 	    true 	string 	申请应用时分配的AppKey。
     client_secret 	true 	string 	申请应用时分配的AppSecret。
     grant_type 	true 	string 	请求的类型，填写authorization_code
     code 	true 	string 	调用authorize获得的code值。
     redirect_uri 	true 	string 	回调地址，需需与注册应用里的回调地址一致。
     */
    //1.获取管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //2.设置访问参数
    NSDictionary *pramdict = [NSMutableDictionary dictionary];
    [pramdict setValue:@"613872604" forKey:@"client_id"];
    [pramdict setValue:@"99e18a30bb3e7c3dc732e785b270685f" forKey:@"client_secret"];
    [pramdict setValue:@"authorization_code" forKey:@"grant_type"];
    [pramdict setValue:code forKey:@"code"];
    [pramdict setValue:@"http://www.baidu.com" forKey:@"redirect_uri"];
    
    //3.发送请求
    /*
     如果不修改AFNetwork的源码，那么会请求失败，失败原因是“unacceptable content-type: text/plain”
     修改AFJSONResponseSerializer.m文件中的init方法，如下，acceptableContentTypes中加入@"text/plain"
     self.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", nil];
     */
    [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:pramdict success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        [MBProgressHUD hideHUD];
        NSLog(@"请求成功%@",responseObject);
        //存储账号信息
        MJAccount *account = [MJAccount accountWithDict:responseObject];
        
        [MJAccountTool saveAccount:account];
        
        //选择加载哪一个控制器
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window switchRootViewController];

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败%@",error);
        [MBProgressHUD hideHUD];
    }];
}

@end
