//
//  SMSLoginAccountViewController.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/3.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "SMSLoginAccountViewController.h"
#import "CountrySelectedViewController.h"
#import "SMSLoginAccountView.h"
#import "WeChatNavigationController.h"
#import "WeChatTabbarController.h"


@interface SMSLoginAccountViewController () <SMSLoginAccountViewDelegate>
@property (nonatomic,strong)CountrySelectedViewController *countrySelect;
@property (nonatomic,strong)SMSLoginAccountView *SMSLoginView;
@end

@implementation SMSLoginAccountViewController
#pragma mark - 懒加载
- (CountrySelectedViewController *)countrySelect{
    if(!_countrySelect){
        _countrySelect = [[CountrySelectedViewController alloc] init];
    }
    return _countrySelect;
}

#pragma mark - 控制器方法

#define NAVIGATION_AND_TABBAR_HEIGH    10
- (void)viewDidLoad {
    [super viewDidLoad];
    SMSLoginAccountView *view = [[SMSLoginAccountView alloc] initWithFrame:self.view.frame];
    
    [view setContentSize:CGSizeMake(0, self.view.bounds.size.height + NAVIGATION_AND_TABBAR_HEIGH)];
    //    [view setContentInset:UIEdgeInsetsMake(NAVIGATION_AND_TABBAR_HEIGH*2, 0, NAVIGATION_AND_TABBAR_HEIGH*2, 0)];
    [view setDelegate:self];
    
    [self.view addSubview:view];
    self.SMSLoginView = view;
    
   
    
    [self setSMSLoginAccountView];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    // Do any additional setup after loading the view.
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    UIDeviceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        //翻转为竖屏时
        if (interfaceOrientation == UIDeviceOrientationPortrait || interfaceOrientation ==UIDeviceOrientationPortraitUpsideDown){
            [self.SMSLoginView setFrame:self.view.frame];

        }else if (interfaceOrientation==UIDeviceOrientationLandscapeLeft || interfaceOrientation ==UIDeviceOrientationLandscapeRight) {
            [self.SMSLoginView setFrame:self.view.frame];
        }
    }
}

- (void)setSMSLoginAccountView{
    
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
- (void)SMSLoginAccountViewDidCountrySelect:(SMSLoginAccountView *)view{
    WeChatNavigationController *navigation = [[WeChatNavigationController alloc] init];
    [navigation addChildViewController:self.countrySelect];
    
    [navigation setWeChatNavigationDefaultStyle];
    [self presentViewController:navigation animated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
