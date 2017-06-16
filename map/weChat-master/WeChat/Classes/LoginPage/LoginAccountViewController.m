//
//  LoginAccountViewController.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/3.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "LoginAccountViewController.h"
#import "CountrySelectedViewController.h"
#import "WeChatTabbarController.h"
#import "WeChatNavigationController.h"
#import "LoginAccountTabbarView.h"
#import "LoginAccountView.h"
#import "SMSLoginAccountViewController.h"
#import "LoginOtherWayViewController.h"
#import "Constant.h"
#import "AppDelegate.h"


@interface LoginAccountViewController () <LoginAccountViewDelegate,LoginAccountTabbarViewDelegate>
@property (nonatomic,strong)CountrySelectedViewController *countrySelect;
@property (nonatomic,strong)SMSLoginAccountViewController *smsLogin;
@property (nonatomic,strong)LoginOtherWayViewController *otherWayLogin;


@property (nonatomic,strong)LoginAccountView *loginView;
@property (nonatomic,strong)LoginAccountTabbarView *tabbarView;
@end

@implementation LoginAccountViewController

#pragma mark - 懒加载
- (CountrySelectedViewController *)countrySelect{
    if(!_countrySelect){
        _countrySelect = [[CountrySelectedViewController alloc] init];
    }
    return _countrySelect;
}

- (SMSLoginAccountViewController *)smsLogin{
    if(!_smsLogin){
        _smsLogin = [[SMSLoginAccountViewController alloc] init];
    }
    return _smsLogin;
}

- (LoginOtherWayViewController *)otherWayLogin{
    if(!_otherWayLogin){
        _otherWayLogin = [[LoginOtherWayViewController alloc] init];
    }
    return _otherWayLogin;
}

#pragma mark - 控制器方法

#define NAVIGATION_AND_TABBAR_HEIGH    10
- (void)viewDidLoad {
    [super viewDidLoad];
    LoginAccountView *view = [[LoginAccountView alloc] initWithFrame:self.view.frame];
    
    [view setContentSize:CGSizeMake(0, self.view.bounds.size.height + NAVIGATION_AND_TABBAR_HEIGH)];
    //    [view setContentInset:UIEdgeInsetsMake(NAVIGATION_AND_TABBAR_HEIGH*2, 0, NAVIGATION_AND_TABBAR_HEIGH*2, 0)];
    [view setDelegate:self];
    
    [self.view addSubview:view];
    self.loginView = view;
    
    WeChatTabbarController *tabbar = [[WeChatTabbarController alloc] init];
    
    LoginAccountTabbarView *tabbarView = [[LoginAccountTabbarView alloc] initWithFrame:tabbar.tabBar.frame];
    [tabbarView setDelegate:self];
    
    [self.view addSubview:tabbarView];
    self.tabbarView = tabbarView;
    
    [self setLoginAccountView];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    //监听键盘通知,键盘将要改变的时候
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}


-(void)dealloc{
    NSLog(@"注销了啦！%s",__func__);
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark - 键盘监听通知方法
- (void)keyboardDidChangeFrame:(NSNotification *)notification{
    
     UIDeviceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    CGRect frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        //翻转为竖屏时
        if (interfaceOrientation == UIDeviceOrientationPortrait || interfaceOrientation ==UIDeviceOrientationPortraitUpsideDown){
            
                //动画效果
                [UIView animateWithDuration:1.0 animations:^{
                    [self.view setTransform:CGAffineTransformMakeTranslation(0, frame.origin.y - bScreenHeigh)];
                }];
        }else if (interfaceOrientation==UIDeviceOrientationLandscapeLeft || interfaceOrientation ==UIDeviceOrientationLandscapeRight) {
            //动画效果
            CGFloat offsetY = frame.origin.y - bScreenHeigh;
            
            if(offsetY < 0){
                offsetY = -130;
            }
            
            [UIView animateWithDuration:1.0 animations:^{
                [self.view setTransform:CGAffineTransformMakeTranslation(0, offsetY)];
            }];
        }
        NSLog(@"%lf",frame.origin.y - bScreenHeigh);
    }
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    UIDeviceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
     WeChatTabbarController *tabbar = [[WeChatTabbarController alloc] init];
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        //翻转为竖屏时
        if (interfaceOrientation == UIDeviceOrientationPortrait || interfaceOrientation ==UIDeviceOrientationPortraitUpsideDown){
            [self.loginView setFrame:self.view.frame];
            [self.tabbarView setFrame:tabbar.tabBar.frame];
        }else if (interfaceOrientation==UIDeviceOrientationLandscapeLeft || interfaceOrientation ==UIDeviceOrientationLandscapeRight) {
            [self.loginView setFrame:self.view.frame];
            [self.tabbarView setFrame:tabbar.tabBar.frame];
        }
    }else{
        //翻转为竖屏时
            [self.loginView setFrame:self.view.frame];
            [self.tabbarView setFrame:tabbar.tabBar.frame];
    }
}



- (void)setLoginAccountView{
    
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

#pragma mark - 代理方法

- (void)LoginAccountViewDidCountrySelect:(LoginAccountView *)view{
    WeChatNavigationController *navigation = [[WeChatNavigationController alloc] init];
    [navigation addChildViewController:self.countrySelect];
    
    [navigation setWeChatNavigationDefaultStyle];
    [self presentViewController:navigation animated:YES completion:nil];
}

- (void)LoginAccountViewDidSMSLogin:(LoginAccountView *)view{
    WeChatNavigationController *navigation = [[WeChatNavigationController alloc] initWithRootViewController:self.smsLogin];
    
     [navigation setWeChatNavigationBackgroudColor:[UIColor colorWithWhite:1.0 alpha:0.8]];
    
    [self presentViewController:navigation animated:YES completion:nil];
}

- (void)loginAccountTabbarViewDidOtherWayLogin:(LoginAccountTabbarView *)view{
    WeChatNavigationController *navigation = [[WeChatNavigationController alloc] initWithRootViewController:self.otherWayLogin];
    
    [navigation setWeChatNavigationBackgroudColor:[UIColor colorWithWhite:1.0 alpha:0.8]];
    
    [self presentViewController:navigation animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
