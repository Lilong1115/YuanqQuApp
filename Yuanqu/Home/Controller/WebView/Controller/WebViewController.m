//
//  WebViewController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/9.
//  Copyright © 2017年 李龙. All rights reserved.
//

//网页
#import "WebViewController.h"
#import <WebViewJavascriptBridge/WKWebViewJavascriptBridge.h>

@interface WebViewController ()<WKNavigationDelegate, WKUIDelegate>

@property WKWebViewJavascriptBridge *bridge;
@property (nonatomic, strong) WKWebView *wkWebView;           // webview

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.navTitle;
    [self setUpWKWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// viewWillAppear和viewWillDisappear对setWebViewDelegate处理，不处理会导致内存泄漏
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.bridge) {
        [self.bridge setWebViewDelegate:self];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.bridge setWebViewDelegate:nil];
}


- (void)setUpWKWebView {
    self.wkWebView =  [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    self.wkWebView.navigationDelegate = self;
    self.wkWebView.UIDelegate = self;
    [self.view addSubview:self.wkWebView];
    [WKWebViewJavascriptBridge enableLogging];
    _bridge = [WKWebViewJavascriptBridge bridgeForWebView:self.wkWebView];
    [_bridge setWebViewDelegate:self];
    self.wkWebView.scrollView.bounces = NO;
    
    // 注册一下
    
    [self loadExamplePage:self.wkWebView];
}


// 加载h5
- (void)loadExamplePage:(WKWebView*)webView {
    
    NSLog(@"%@", [NSString stringWithFormat:@"%@%@", BaseUrl, self.url]);
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", BaseUrl, self.url]]]];
}

@end
