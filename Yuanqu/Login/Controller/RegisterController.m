//
//  RegisterController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/27.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "RegisterController.h"
#import <WebViewJavascriptBridge/WKWebViewJavascriptBridge.h>

@interface RegisterController ()<WKNavigationDelegate, WKUIDelegate>

@property WKWebViewJavascriptBridge *bridge;
@property (nonatomic, strong) WKWebView *wkWebView;           // webview

@end

@implementation RegisterController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.navTitle;
    
    [self setUpWKWebView];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
}

- (void)back {

    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
    //禁止滚动
//    self.wkWebView.scrollView.scrollEnabled = NO;
    // 注册一下
    //关闭按钮
    [_bridge registerHandler:@"close" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        NSString *str = (NSString *)data;
        NSInteger state = [str integerValue];
        
        switch (state) {
                //失败
            case 0:
                [self loadExamplePage:self.wkWebView];
                break;
                //成功
            case 1:
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                break;
            default:
                break;
        }
        
    }];
    
    
    [self loadExamplePage:self.wkWebView];
}


// 加载h5
- (void)loadExamplePage:(WKWebView*)webView {

    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", BaseUrl, self.url]]]];
    
//
    
    //@"http://192.168.100.232:8080/Apps/OpenTestPaper"
}




@end
