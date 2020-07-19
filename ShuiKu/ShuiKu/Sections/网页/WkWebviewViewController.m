//
//  WkWebviewViewController.m
//  WuYeYuanGongDuan
//
//  Created by Mac on 2020/6/29.
//  Copyright © 2020 Mac. All rights reserved.
//

#import "WkWebviewViewController.h"
#import <WebKit/WebKit.h>

@interface WkWebviewViewController ()<WKNavigationDelegate>

@end

@implementation WkWebviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebView *webview = [[WKWebView alloc] init];
    [webview setNavigationDelegate:self];
    [self.view addSubview:webview];
    [webview mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        }else{
            make.edges.equalTo(self.view).insets(kPaddingNav);
        }
    }];
    
    if(_strurl.length>5)
    {
        [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_strurl]]];
    }
    else
    {
        if(_strcontnt.length>5)
        {
            [webview loadHTMLString:_strcontnt baseURL:nil];
        }
    }
    
}

#pragma mark - WKWebView
//在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
//    decisionHandler(WKNavigationActionPolicyCancel);
    // 没有这一句页面就不会显示
    decisionHandler(WKNavigationActionPolicyAllow);
    
}

/// 2 页面开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    

}

/// 4 开始获取到网页内容时返回
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    
    
}

/// 5 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
   

}

/// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    
}

@end
