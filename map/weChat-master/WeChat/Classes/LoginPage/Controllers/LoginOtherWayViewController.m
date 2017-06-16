//
//  LoginOtherWayViewController.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/3.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "LoginOtherWayViewController.h"
#import "OtherWayLoginAccountView.h"
#import "AccountTextField.h"
#import "ProgressHUD.h"
#import "HomePageViewController.h"
#import "ServersConfig.h"

@interface LoginOtherWayViewController () <OtherLoginAccountViewDelegate,XmppToolsDelegate>

@property (nonatomic,strong)OtherWayLoginAccountView *loginView;

@end

@implementation LoginOtherWayViewController

#pragma mark - 控制器方法

#define NAVIGATION_AND_TABBAR_HEIGH    10
- (void)viewDidLoad {
    [super viewDidLoad];
    
    OtherWayLoginAccountView *view = [[OtherWayLoginAccountView alloc] initWithFrame:self.view.frame];
    
    [view setContentSize:CGSizeMake(0, self.view.bounds.size.height + NAVIGATION_AND_TABBAR_HEIGH)];
    //    [view setContentInset:UIEdgeInsetsMake(NAVIGATION_AND_TABBAR_HEIGH*2, 0, NAVIGATION_AND_TABBAR_HEIGH*2, 0)];
    [view setDelegate:self];
    
    [self.view addSubview:view];
    self.loginView = view;
    
    [self setLoginOtherWayView];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    // Do any additional setup after loading the view.
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    UIDeviceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        //翻转为竖屏时
        if (interfaceOrientation == UIDeviceOrientationPortrait || interfaceOrientation ==UIDeviceOrientationPortraitUpsideDown){
            [self.loginView setFrame:self.view.frame];
            
        }else if (interfaceOrientation==UIDeviceOrientationLandscapeLeft || interfaceOrientation ==UIDeviceOrientationLandscapeRight) {
            [self.loginView setFrame:self.view.frame];
        }
    }
}

- (void)setLoginOtherWayView{
    
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

- (void)otherWayLoginAccountViewDidLoginHelp:(OtherWayLoginAccountView *)view{
    
}




- (void)otherWayLoginAccountViewDidLogin:(OtherWayLoginAccountView *)view{
    
    NSString *User = view.accountInput.textInput.text;
    NSString *Password = view.passwordInput.textInput.text;
    
    
    if(User.length&&Password.length){
        
        //存入沙盒
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults setObject:User forKey:@"usr"];
        [defaults setObject:Password forKey:@"pwd"];
        
        [MBProgressHUD showMessage:@"登录中..." toView:self.view];
        
        XMPPTools *xmpp = [XMPPTools sharedXMPPTools];
        [xmpp setDelegate:self];
        __weak typeof(self) vcSelf = self;
        [xmpp XmppUsrConnectToHost:LOCALHOSTIP withHostPort:5222 andCallBackResult:^(XmppResultType result) {
             [MBProgressHUD hideHUDForView:vcSelf.view];
            switch (result) {
                case XmppResultTypeAuthenticateFailed:{
                    [MBProgressHUD showError:@"用户名或者密码错误！" toView:vcSelf.view];
                }break;
                case XmppResultTypeAuthenticateSuccess:{
                     //注销所有的登录界面的控制器
                     [vcSelf dismissToRootViewController];
                     // 写入登录状态
                     [defaults setObject:@"hasLogined" forKey:@"loginState"];
                }break;
                case XmppResultTypeNetWorkConnectFailed:{
                    [MBProgressHUD showNotice:@"网络不给力！" toView:vcSelf.view];
                 }break;
                default:
                    break;
            }
        }];
        

    }
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


#pragma mark - xmppappdelegate
- (void)xmppToolsDelegate:(AppDelegate *) app didAuthenticate:(XMPPStream *)sender{
     //注销所有的登录界面的控制器
//    [self dismissToRootViewController];
    
    //切换根控制器
    HomePageViewController *controller = [[HomePageViewController alloc] init];
    //清除窗口颜色
    [app.window setBackgroundColor:[UIColor whiteColor]];
    [app.window setRootViewController:controller];
}

- (void)dealloc{
    NSLog(@"注销了啦！%s",__func__);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
