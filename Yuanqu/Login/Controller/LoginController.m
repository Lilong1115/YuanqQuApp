//
//  LoginController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/7.
//  Copyright © 2017年 李龙. All rights reserved.
//

//登录
#import "LoginController.h"
#import "UserInfo.h"
#import "TabBarController.h"
#import "RegisterController.h"
#import "NavigationController.h"
#import "QRCodeReaderViewController.h"


#pragma mark --宏
#define TextHeight 50
#define Margin 20

@interface LoginController ()<QRCodeReaderDelegate>

//账户
@property (nonatomic, weak) UITextField *username;
//密码
@property (nonatomic, weak) UITextField *password;

//
@property (nonatomic, weak) NavigationController *nav;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupLogo];
    [self setupText];
    [self setupLoginButton];
    
    //注册通知
    //登录成功的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(login:) name:AppLoginSuccessNotification object:nil];
    
}

//登陆成功
- (void)login:(NSNotification *)noti {
    
    [ProgressHUD showSuccess:@"登陆成功"];
    
    //提示登陆成功时间
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].delegate.window.rootViewController = [[TabBarController alloc]init];
    });
    
    
    
}

//设置logo
- (void)setupLogo {

    UIImageView *logoView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    logoView.image = [UIImage imageNamed:@"loginbj"];
    [self.view addSubview:logoView];
    
    UIView *backgView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenH / 2 - 50, ScreenW, ScreenH / 2 + 50)];
    backgView.backgroundColor = [UIColor colorWithHexString:@"#03AEFD"];
    [self.view addSubview:backgView];
}

//设置账户密码框
- (void)setupText {

    UITextField *username = [self creatTextWithPlaceholder:@"用户名" frame:CGRectMake(Margin, ScreenH / 2 + Margin, ScreenW - Margin * 2, TextHeight) keyboardType:UIKeyboardTypeNumberPad secureTextEntry:NO];
    self.username = username;
    UITextField *password = [self creatTextWithPlaceholder:@"密码" frame:CGRectMake(Margin, ScreenH / 2 + Margin * 2 + TextHeight, ScreenW - Margin * 2, TextHeight) keyboardType:UIKeyboardTypeASCIICapable secureTextEntry:YES];
    self.password = password;
    
    //是否隐藏按钮
    UIButton *secureTextButton = [[UIButton alloc]initWithFrame:CGRectMake(password.bounds.size.width - Margin - TextHeight / 3, (TextHeight  - TextHeight / 3) / 2, 25, TextHeight / 3)];
    [secureTextButton setBackgroundImage:[UIImage imageNamed:@"password_novisible"] forState:UIControlStateNormal];
    [secureTextButton setBackgroundImage:[UIImage imageNamed:@"password_visible"] forState:UIControlStateSelected];
    [password addSubview:secureTextButton];
    [secureTextButton addTarget:self action:@selector(showAndHidePassword:) forControlEvents:UIControlEventTouchUpInside];
    
}

//设置输入框
- (UITextField *)creatTextWithPlaceholder:(NSString *)placeholder frame:(CGRect)frame keyboardType:(UIKeyboardType)keyboardType secureTextEntry:(BOOL)secureTextEntry {

    UITextField *text = [[UITextField alloc]initWithFrame:frame];
    //首字母是否大写
    text.autocapitalizationType = UITextAutocapitalizationTypeNone;
    text.backgroundColor = [UIColor colorWithHexString:@"#4DC6FD"];
    text.keyboardType = keyboardType;
    text.secureTextEntry = secureTextEntry;
    text.borderStyle = UITextBorderStyleRoundedRect;
    text.placeholder = placeholder;
    [text setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    text.layer.cornerRadius = 5;
    text.layer.masksToBounds = YES;
    text.layer.borderColor = [UIColor whiteColor].CGColor;
    text.layer.borderWidth = 1;
    [self.view addSubview:text];
    return text;
}

//显示和隐藏登录视图的密码。
-(void)showAndHidePassword:(UIButton *)sender {
    //避免明文/密文切换后光标位置偏移
    self.password.enabled = NO;    // the first one;
    self.password.secureTextEntry = sender.selected;
    sender.selected = !sender.selected;
    self.password.enabled = YES;  // the second one;
    //[self.password becomeFirstResponder]; // the third one
}

//设置登录按钮
- (void)setupLoginButton {

    UIButton *loginButton = [[UIButton alloc]initWithFrame:CGRectMake(Margin, self.password.frame.origin.y + TextHeight + Margin, ScreenW - Margin * 2, TextHeight)];
    loginButton.layer.cornerRadius = 5;
    loginButton.layer.masksToBounds = YES;
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setBackgroundColor:[UIColor colorWithHexString:@"#0B49FC"]];
    [self.view addSubview:loginButton];
    [loginButton addTarget:self action:@selector(clickLoginButton) forControlEvents:UIControlEventTouchUpInside];
    
    
    //忘记密码
    UIButton *forgotButton = [self creatButtonWithTitle:@"忘记密码"];
    forgotButton.frame = CGRectMake(Margin, loginButton.frame.origin.y + TextHeight + Margin / 2, 80, 30);
    [forgotButton addTarget:self action:@selector(clickForgotButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgotButton];
    
    //注册用户
    UIButton *registerButton = [self creatButtonWithTitle:@"注册用户"];
    registerButton.frame = CGRectMake(ScreenW - Margin - 80, loginButton.frame.origin.y + TextHeight + Margin / 2, 80, 30);
    [registerButton addTarget:self action:@selector(clickRegisterButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    
}

//注册用户
- (void)clickRegisterButton {

    QRCodeReaderViewController *reader = [QRCodeReaderViewController new];
    reader.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    reader.navigationItem.rightBarButtonItem = nil;
    reader.navigationItem.title = @"扫一扫";
    reader.modalPresentationStyle = UIModalPresentationFormSheet;
    reader.delegate = self;
    
    NavigationController *nav = [[NavigationController alloc]initWithRootViewController:reader];
    self.nav = nav;
    [self presentViewController:nav animated:YES completion:nil];
    
    
//    RegisterController *registerVC = [[RegisterController alloc]init];
//    registerVC.navTitle = @"注册";
//    registerVC.url = AppRegister_URL;
//    NavigationController *registerNav = [[NavigationController alloc]initWithRootViewController:registerVC];
//    
//    
//    [self presentViewController:registerNav animated:YES completion:nil];
    

}


#pragma mark - QRCodeReader Delegate Methods

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{

    NSLog(@"%@", [NSString stringWithFormat:@"%@%@", BaseUrl, result]);
    RegisterController *registerVC = [[RegisterController alloc]init];
    registerVC.navTitle = @"注册";
    registerVC.url = [NSString stringWithFormat:@"http://222.35.27.156:8080/SMP/%@", result];
    NavigationController *registerNav = [[NavigationController alloc]initWithRootViewController:registerVC];
    
    [self.nav presentViewController:registerNav animated:YES completion:nil];
    
//    [self presentViewController:registerVC animated:YES completion:nil];
}


//忘记密码
- (void)clickForgotButton {

    
}



//返回按钮
- (void)back {

    [self.nav dismissViewControllerAnimated:YES completion:nil];
}

//登录
- (void)clickLoginButton {
    
    NSString *username = self.username.text;
    NSString *password = self.password.text;
    if (username.length > 0 && password.length > 0) {
        [ProgressHUD show:@"正在登陆..."];
        //登陆过程
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UserInfo loginWithPhone:username password:password];
        });
    } else {
    
        [ProgressHUD showError:@"请输入账号和密码"];
    }
    
}


//创建按钮
- (UIButton *)creatButtonWithTitle:(NSString *)title {

    UIButton *button = [[UIButton alloc]init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    return button;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UIStatusBarStyle)preferredStatusBarStyle {

    return UIStatusBarStyleLightContent;
}

@end
