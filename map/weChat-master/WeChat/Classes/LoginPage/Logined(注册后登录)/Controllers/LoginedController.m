//
//  LoginedController.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/20.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "LoginedController.h"
#import "LoginedView.h"
#import "AccountTextField.h"
#import "ProgressHUD.h"
#import "HomePageViewController.h"
#import "RegisterAccountViewController.h"
#import "LoginOtherWayViewController.h"
#import "WeChatNavigationController.h"
#import "ServersConfig.h"
#import "ActionSheet.h"



#define NAVIGATION_AND_TABBAR_HEIGH    10
@interface LoginedController () <LoginedViewDelegate,XmppToolsDelegate,ActionSheetDelegate>
@property (nonatomic,strong)LoginedView *loginView;
@property (nonatomic,strong)RegisterAccountViewController *registerAccount;
@property (nonatomic,strong)LoginOtherWayViewController *loginOtherAccount;
@end

@implementation LoginedController

- (RegisterAccountViewController *)registerAccount{
    if(!_registerAccount){
        _registerAccount = [[RegisterAccountViewController alloc] init];
    }
    return _registerAccount;
}

- (LoginOtherWayViewController *)loginOtherAccount{
    if(!_loginOtherAccount){
        _loginOtherAccount = [[LoginOtherWayViewController alloc] init];
    }
    return _loginOtherAccount;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LoginedView *view = [[LoginedView alloc] initWithFrame:self.view.frame];
    
    [view setContentSize:CGSizeMake(0, self.view.bounds.size.height + NAVIGATION_AND_TABBAR_HEIGH)];
    
    [view setDelegate:self];
    [self.view addSubview:view];
    self.loginView = view;
    
}

- (void)viewDidLayoutSubviews{
      [self.loginView setFrame:self.view.frame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 登录页面代理方法 ------------------------------------------------------

- (void)loginedViewDidLogin:(LoginedView *)view{
    
    NSString *Password = view.passwordInput.textInput.text;
    
    
    if(Password.length){
        //存入沙盒
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:Password forKey:@"pwd"];
        
        [MBProgressHUD showMessage:@"请稍后..." toView:self.view];
        
      
        XMPPTools *xmpp = [XMPPTools sharedXMPPTools];
        [xmpp setDelegate:self];
        
        weak_self weakSelf = self;
        [xmpp XmppUsrConnectToHost:LOCALHOSTIP withHostPort:5222 andCallBackResult:^(XmppResultType result) {
            [MBProgressHUD hideHUDForView:weakSelf.view];
            switch (result) {
                case XmppResultTypeAuthenticateFailed:{
                    [MBProgressHUD showError:@"密码错误！" toView:weakSelf.view];
                }break;
                case XmppResultTypeAuthenticateSuccess:{
                    // 写入登录状态
                    [defaults setObject:@"hasLogined" forKey:@"loginState"];
                }break;
                case XmppResultTypeNetWorkConnectFailed:{
                    [MBProgressHUD showNotice:@"网络不给力！" toView:weakSelf.view];
                }break;
                default:
                    break;
            }
        }];
        
    }
}


- (void)loginedViewDidMoreButton:(LoginedView *)view{
    DebugLog(@"more");
    ActionSheet *actionSheet = [[ActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"切换账号",@"注册", @"前往微信安全中心", nil];
    
    [actionSheet show];
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    
//    
//    [alert addAction:[UIAlertAction actionWithTitle:@"切换账号" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        WeChatNavigationController *controller = [[WeChatNavigationController alloc] initWithRootViewController:self.loginOtherAccount];
//        
//        [controller setWeChatNavigationBackgroudColor:[UIColor colorWithWhite:1.0 alpha:0.8]];
//        
//        [self presentViewController:controller animated:YES completion:nil];
//        
//    }]];
//    
//    [alert addAction:[UIAlertAction actionWithTitle:@"注册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        WeChatNavigationController *controller = [[WeChatNavigationController alloc] initWithRootViewController:self.registerAccount];
//        
//        [controller setWeChatNavigationBackgroudColor:[UIColor colorWithWhite:1.0 alpha:0.8]];
//        
//        [self presentViewController:controller animated:YES completion:nil];
//        
//    }]];
//    
//    [alert addAction:[UIAlertAction actionWithTitle:@"前往微信安全中心" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//    }]];
//    
//    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        
//    }]];
//    
//    [self presentViewController:alert animated:YES completion:nil];
}

// 代理方法
- (void)actionSheet:(ActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(!buttonIndex){
        WeChatNavigationController *controller = [[WeChatNavigationController alloc] initWithRootViewController:self.loginOtherAccount];

        [controller setWeChatNavigationBackgroudColor:[UIColor colorWithWhite:1.0 alpha:0.8]];

        [self presentViewController:controller animated:YES completion:nil];
    }else if(buttonIndex == 1){
        // 采用系统默认的图片浏览器
        WeChatNavigationController *controller = [[WeChatNavigationController alloc] initWithRootViewController:self.registerAccount];

        [controller setWeChatNavigationBackgroudColor:[UIColor colorWithWhite:1.0 alpha:0.8]];

        [self presentViewController:controller animated:YES completion:nil];
    }
}

#pragma mark - xmpp 代理方法
- (void)xmppToolsDelegate:(AppDelegate *)app didAuthenticate:(XMPPStream *)sender{
    //切换根控制器
    HomePageViewController *controller = [[HomePageViewController alloc] init];
    //清除窗口颜色

    [app.window setBackgroundColor:[UIColor whiteColor]];
    [app.window setRootViewController:controller];
}


@end
