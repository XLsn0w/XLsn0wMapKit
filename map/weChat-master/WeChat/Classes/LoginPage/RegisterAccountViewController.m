//
//  RegisterAccountViewController.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/3.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "RegisterAccountViewController.h"
#import "RegisterAccountTabbarView.h"
#import "PhoneNumberTextField.h"
#import "CountrySelectedViewController.h"
#import "WeChatNavigationController.h"
#import "WeChatTabbarController.h"
#import "AllowMentWebViewController.h"
#import "RegisterAccountView.h"
#import "LoginedController.h"
#import "AppDelegate.h"
#import "ProgressHUD.h"
#import "ServersConfig.h"

@interface RegisterAccountViewController () <RegisterAccountViewDelegate,RegisterAccountTabbarViewDelegate>
@property (nonatomic,strong)CountrySelectedViewController *countrySelect;
@property (nonatomic,strong)AllowMentWebViewController *allowMent;

@property (nonatomic,strong)RegisterAccountTabbarView *tabbarView;
@property (nonatomic,strong)RegisterAccountView *registerView;
@end

@implementation RegisterAccountViewController

#pragma mark - 懒加载
- (CountrySelectedViewController *)countrySelect{
    if(!_countrySelect){
        _countrySelect = [[CountrySelectedViewController alloc] init];
    }
    return _countrySelect;
}

- (AllowMentWebViewController *)allowMent{
    if(!_allowMent){
        _allowMent = [[AllowMentWebViewController alloc] init];
    }
    return _allowMent;
}

#pragma mark - 控制器方法

#define NAVIGATION_AND_TABBAR_HEIGH    10
- (void)viewDidLoad {
    [super viewDidLoad];

    RegisterAccountView *view = [[RegisterAccountView alloc] initWithFrame:self.view.frame];
    
    [view setContentSize:CGSizeMake(0, self.view.bounds.size.height + NAVIGATION_AND_TABBAR_HEIGH)];
    //    [view setContentInset:UIEdgeInsetsMake(NAVIGATION_AND_TABBAR_HEIGH*2, 0, NAVIGATION_AND_TABBAR_HEIGH*2, 0)];
    [view setDelegate:self];
    
    [self.view addSubview:view];
    self.registerView = view;
    
    WeChatTabbarController *tabbar = [[WeChatTabbarController alloc] init];
    
    RegisterAccountTabbarView *tabbarView = [[RegisterAccountTabbarView alloc] initWithFrame:tabbar.tabBar.frame];
    [tabbarView setDelegate:self];
    
    [self.view addSubview:tabbarView];
    self.tabbarView = tabbarView;
    
    [self setRegisterAccountView];

    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    // Do any additional setup after loading the view.
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    UIDeviceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    WeChatTabbarController *tabbar = [[WeChatTabbarController alloc] init];
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        //翻转为竖屏时
        if (interfaceOrientation == UIDeviceOrientationPortrait || interfaceOrientation ==UIDeviceOrientationPortraitUpsideDown){
            [self.registerView setFrame:self.view.frame];
            [self.tabbarView setFrame:tabbar.tabBar.frame];
        }else if (interfaceOrientation==UIDeviceOrientationLandscapeLeft || interfaceOrientation ==UIDeviceOrientationLandscapeRight) {
            [self.registerView setFrame:self.view.frame];
            [self.tabbarView setFrame:tabbar.tabBar.frame];
        }
    }
}

- (void)setRegisterAccountView{
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(0, 0, 80, 30)];
    
    [backButton setTitle:@"取消" forState:UIControlStateNormal];
    [backButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    
    [backButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    
    [backButton addTarget:self action:@selector(backToLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backButtonItem];
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        [backButton.titleLabel setFont:[UIFont systemFontOfSize:24.0]];
    }else{
        [backButton.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    }
}

#pragma mark - 按键方法
- (void)backToLogin:(UIButton *) button{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 代理方法
// 注册按钮
- (void)registerAccountViewDidRegister:(RegisterAccountView *)view{
    
    [MBProgressHUD showMessage:@"连接服务器..." toView:self.view];
    
    XMPPTools *xmpp = [XMPPTools sharedXMPPTools];
    NSString  * newAccount = view.phoneInput.phoneNumber.text;
    weak_self weakSelf = self;
    [xmpp XmppUsrRegisterToHost:LOCALHOSTIP withHostPort:5222 andRegisterUsrName:newAccount andCallBackResult:^(XmppResultType result,AppDelegate *app) {
        [MBProgressHUD hideHUDForView:weakSelf.view];
        switch (result) {
            case XmppResultTypeNetWorkAuthenticatePassword:{
                // 输入密码提示
                [self regiterAccountWithPassword];
            }break;
            case XmppResultTypeNetWorkRegisterSuccess:{
                 [MBProgressHUD showNotice:@"注册成功！" toView:weakSelf.view];
                //存入沙盒
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:newAccount forKey:@"usr"];
                //抹掉前面用户的密码
                [defaults setObject:nil forKey:@"pwd"];

                
                [weakSelf dismissToRootViewController];
                //切换根控制器
                LoginedController *controller = [[LoginedController alloc] init];
                // 返回登录界面
                [app.window setBackgroundColor:[UIColor whiteColor]];
                [app.window setRootViewController:controller];
                
            }break;
            case XmppResultTypeNetWorkRegisterFailed:{
                 [MBProgressHUD showNotice:@"注册失败！" toView:weakSelf.view];
                //注册成功
                
            }break;
            case XmppResultTypeNetWorkConnectFailed:{
                [MBProgressHUD showNotice:@"网络不给力！" toView:weakSelf.view];
            }break;
            default:
                break;
        }
    }];
}

- (void)regiterAccountWithPassword{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"message:@"请输入密码"preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField*textField) {
        textField.placeholder = @"输入密码";
        textField.secureTextEntry = YES;
        
    }];
    
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField*textField) {
        textField.placeholder = @"请再次输入密码";
        textField.secureTextEntry = YES;
        
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        if(![alert.textFields[0].text isEqualToString:alert.textFields[1].text]){
            alert.title = @"错误";
            alert.message = @"两次输入的密码不一致！";
            [self presentViewController:alert animated:YES completion:nil];
        }else{
           
            [self.view endEditing:YES];
            [MBProgressHUD showMessage:@"注册中..." toView:self.view];
             //发送密码验证
            [[XMPPTools sharedXMPPTools] XmmpUsrReisterSendPasswordToHost:alert.textFields[0].text];
        }
    }]];
    
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}


//dismiss根控制器
- (void)dismissToRootViewController{
    UIViewController *controller = self;
    //遍历到最底层的控制器
    while (controller.presentingViewController) {
        controller = controller.presentingViewController;
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)registerAccountViewDidCountrySelect:(RegisterAccountView *)view{
   
    WeChatNavigationController *navigation = [[WeChatNavigationController alloc] init];
    [navigation addChildViewController:self.countrySelect];
    
    [navigation setWeChatNavigationDefaultStyle];
    [self presentViewController:navigation animated:YES completion:nil];
}

#pragma mark - tabbar代理方法
- (void)registerAccountTabbarViewDidSelectAllowMent:(RegisterAccountTabbarView *)view{
    WeChatNavigationController *navigation = [[WeChatNavigationController alloc] initWithRootViewController:self.allowMent];
    
    [navigation setWeChatNavigationDefaultStyle];
    [self presentViewController:navigation animated:YES completion:nil];
}


@end
