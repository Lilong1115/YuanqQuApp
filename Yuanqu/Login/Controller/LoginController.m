//
//  LoginController.m
//  Yuanqu
//
//  Created by 李龙 on 2017/6/7.
//  Copyright © 2017年 李龙. All rights reserved.
//

//登录
#import "LoginController.h"

#pragma mark --宏
#define TextHeight 50
#define Margin 20

@interface LoginController ()

//账户
@property (nonatomic, weak) UITextField *username;
//密码
@property (nonatomic, weak) UITextField *password;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupLogo];
    [self setupText];
    [self setupLoginButton];
    
}

//设置logo
- (void)setupLogo {

    UIImageView *logoView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH / 2)];
    logoView.image = [UIImage imageNamed:@"meinv"];
    [self.view addSubview:logoView];
}

//设置账户密码框
- (void)setupText {

    UITextField *username = [self creatTextWithPlaceholder:@"账户" frame:CGRectMake(Margin, ScreenH / 2 + Margin, ScreenW - Margin * 2, TextHeight) keyboardType:UIKeyboardTypeNumberPad secureTextEntry:NO];
    self.username = username;
    UITextField *password = [self creatTextWithPlaceholder:@"密码" frame:CGRectMake(Margin, ScreenH / 2 + Margin * 2 + TextHeight, ScreenW - Margin * 2, TextHeight) keyboardType:UIKeyboardTypeASCIICapable secureTextEntry:YES];
    self.password = password;
    
    //是否隐藏按钮
    UIButton *secureTextButton = [[UIButton alloc]initWithFrame:CGRectMake(password.bounds.size.width - Margin - TextHeight / 2, TextHeight / 2 / 2, 40, TextHeight / 2)];
    [secureTextButton setBackgroundImage:[UIImage imageNamed:@"location_bank"] forState:UIControlStateNormal];
    [secureTextButton setBackgroundImage:[UIImage imageNamed:@"location_hospital"] forState:UIControlStateSelected];
    [password addSubview:secureTextButton];
    [secureTextButton addTarget:self action:@selector(showAndHidePassword:) forControlEvents:UIControlEventTouchUpInside];
    
}

//设置输入框
- (UITextField *)creatTextWithPlaceholder:(NSString *)placeholder frame:(CGRect)frame keyboardType:(UIKeyboardType)keyboardType secureTextEntry:(BOOL)secureTextEntry {

    UITextField *text = [[UITextField alloc]initWithFrame:frame];
    //首字母是否大写
    text.autocapitalizationType = UITextAutocapitalizationTypeNone;
    text.keyboardType = keyboardType;
    text.secureTextEntry = secureTextEntry;
    text.borderStyle = UITextBorderStyleRoundedRect;
    text.placeholder = placeholder;
    text.layer.cornerRadius = 5;
    text.layer.masksToBounds = YES;
    text.layer.borderColor = [UIColor blackColor].CGColor;
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
    [self.password becomeFirstResponder]; // the third one
}

//设置登录按钮
- (void)setupLoginButton {

    UIButton *loginButton = [[UIButton alloc]initWithFrame:CGRectMake(Margin, ScreenH - Margin - TextHeight, ScreenW - Margin * 2, TextHeight)];
    loginButton.layer.cornerRadius = 5;
    loginButton.layer.masksToBounds = YES;
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:loginButton];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
