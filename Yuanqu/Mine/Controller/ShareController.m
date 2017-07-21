//
//  ShareController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/7/20.
//  Copyright © 2017年 李龙. All rights reserved.
//

#import "ShareController.h"
#import "XHShareView.h"
#import "OpenShareHeader.h"
#import <MessageUI/MessageUI.h>


@interface ShareController ()<XHShareViewDelegate>

@property (nonatomic, weak) XHShareView *shareView;

@end

@implementation ShareController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *dismissButton = [[UIButton alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:dismissButton];
    [dismissButton addTarget:self action:@selector(dismissButton) forControlEvents:UIControlEventTouchUpInside];
    
    
    XHShareView *shareView = [[XHShareView alloc] initWithFrame:CGRectMake(0 , 0, ScreenW * 0.8, 200)];
    shareView.center = self.view.center;
    
    shareView.delegate = self;
    [self.view addSubview:shareView];
    self.shareView = shareView;
    
    if (![self jugleAppWithURLScheme:WeixinURLScheme]) {
        [shareView setDisabledWeixin];
    }
    
    if (![self jugleAppWithURLScheme:SinaURLScheme]) {
        [shareView setDisabledSina];
    }
    if (![self jugleAppWithURLScheme:QQURLScheme]) {
        [shareView setDisabledQQ];
    }
    
}

//判断是否安装某应用
- (BOOL)jugleAppWithURLScheme:(NSString *)urlScheme {
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://", urlScheme]]]) {  //说明此设备有安装app
        
        return YES;
    } else {
        
        //说明此设备没有安装app
        return NO;
        
    }
    
    
}


//返回
- (void)dismissButton {

    if (self.delegate && [self.delegate respondsToSelector:@selector(didDismissKYShareVC:)]) {
        [self.delegate didDismissKYShareVC:self];
    }
    
}

#pragma mark -- XHShareViewDelegate
- (void) XHDidClickShareBtn:(ShareBtn)type{
    switch (type) {
        case SharePyQuan:{
            // 分享到朋友圈
            [self pyqClick];
            break;
        }
        case ShareWeix:{
            // 发给微信好友
            [self wxFriendClick];

            break;
        }case ShareMsg:{
            // 复制链接
            [self sendMessage];
            break;
        }case ShareSina:{
            // 分享到微博
            [self sinaWBClick];
            break;
        }case ShareQQ:{
            // 发给QQ好友
            [self qqFriend];
            break;
        }case ShareQzone:{
            // 分享到QQ空间
            [self qzone];
            break;
        }default:{
            NSLog(@"默认");
            break;
        }
    }
}



#pragma mark - 配置分享信息
- (OSMessage *)shareMessage {
    OSMessage *message = [[OSMessage alloc] init];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy年MM月dd日HH时mm分ss秒";
    NSString *now = [fmt stringFromDate:[NSDate date]];
    message.title = [NSString stringWithFormat:@"李龙的分享，分享时间%@",now];
    message.image = UIImagePNGRepresentation([UIImage imageNamed:@"icon"]);
    // 缩略图
    message.thumbnail = UIImagePNGRepresentation([UIImage imageNamed:@"icon"]);
    message.desc = [NSString stringWithFormat:@"李龙的分享，分享时间%@",now];
    message.link=@"http://www.baidu.com";
    return message;
}

#pragma mark - 分享到微博
- (void)sinaWBClick {
    OSMessage *message = [self shareMessage];
    [OpenShare shareToWeibo:message Success:^(OSMessage *message) {
        [ProgressHUD showSuccess:@"分享新浪微博成功"];
    } Fail:^(OSMessage *message, NSError *error) {
        [ProgressHUD showError:@"分享新浪微博失败"];
    }];
}

#pragma mark - 分享给QQ好友
- (void)qqFriend {
    OSMessage *message = [self shareMessage];
    [OpenShare shareToQQFriends:message Success:^(OSMessage *message) {
        [ProgressHUD showSuccess:@"分享QQ好友成功"];
    } Fail:^(OSMessage *message, NSError *error) {
        [ProgressHUD showError:@"分享QQ好友失败"];
    }];
    
}

#pragma mark - 分享到QQ空间
- (void)qzone{
    OSMessage *message = [self shareMessage];
    [OpenShare shareToQQZone:message Success:^(OSMessage *message) {
        [ProgressHUD showSuccess:@"分享QQ空间成功"];
    } Fail:^(OSMessage *message, NSError *error) {
        [ProgressHUD showError:@"分享QQ空间失败"];
    }];
}

#pragma mark - 分享给微信好友
- (void)wxFriendClick{
    OSMessage *message = [self shareMessage];
    [OpenShare shareToWeixinSession:message Success:^(OSMessage *message) {
        [ProgressHUD showSuccess:@"微信分享会话成功"];
    } Fail:^(OSMessage *message, NSError *error) {
        [ProgressHUD showError:@"微信分享会话失败"];
    }];
}

#pragma mark - 分享到朋友圈
- (void)pyqClick{
    OSMessage *message = [self shareMessage];
    [OpenShare shareToWeixinTimeline:message Success:^(OSMessage *message) {
        [ProgressHUD showSuccess:@"微信分享朋友圈成功"];
    } Fail:^(OSMessage *message, NSError *error) {
        [ProgressHUD showError:@"微信分享朋友圈失败"];
    }];
}

#pragma mark - 复制链接
- (void)sendMessage{
    
    OSMessage *message = [self shareMessage];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = message.link;
    [ProgressHUD showSuccess:@"复制成功"];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
