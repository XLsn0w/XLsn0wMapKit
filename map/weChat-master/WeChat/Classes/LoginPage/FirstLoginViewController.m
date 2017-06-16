//
//  FirstLoginViewController.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/2.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "FirstLoginViewController.h"
#import "LanguageSelectedViewController.h"
#import "RegisterAccountViewController.h"
#import "LoginAccountViewController.h"
#import "WeChatNavigationController.h"
#import "UIImage+ResizeImage.h"
#import "UIImage+ColorImage.h"
#import "AppDelegate.h"

@interface FirstLoginViewController ()
@property (nonatomic,strong)UIImageView *launchImageView;
@property (nonatomic,strong)UIButton *loginButton;
@property (nonatomic,strong)UIButton *registerButton;
@property (nonatomic,strong)UIButton *languageButton;

@property (nonatomic,strong)LanguageSelectedViewController *languageSelect;
@property (nonatomic,strong)RegisterAccountViewController *registerAccount;
@property (nonatomic,strong)LoginAccountViewController *loginAccount;

@end

@implementation FirstLoginViewController

#pragma mark - 懒加载


- (LanguageSelectedViewController *)languageSelect{
    if(!_languageSelect) {
        _languageSelect = [[LanguageSelectedViewController alloc] init];
    }
    return _languageSelect;
}

- (RegisterAccountViewController *)registerAccount{
    if(!_registerAccount){
        _registerAccount = [[RegisterAccountViewController alloc] init];
    }
    return _registerAccount;
}

- (LoginAccountViewController *)loginAccount{
    if(!_loginAccount){
        _loginAccount = [[LoginAccountViewController alloc] init];
    }
    return _loginAccount;
}

#pragma mark - 控制器方法
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setFirstLoginView];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}





- (void)setFirstLoginView {
    CGSize viewSize = self.view.bounds.size;
    NSString*viewOrientation =@"Portrait";//横屏请设置成 @"Landscape"
    NSString*launchImage =nil;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for(NSDictionary* dict in imagesDict) {
        CGSize imageSize =CGSizeFromString(dict[@"UILaunchImageSize"]);
//        if(CGSizeEqualToSize(imageSize, viewSize) && [@"Portrait" isEqualToString:dict[@"UILaunchImageOrientation"]] &&[@"Landscape" isEqualToString:dict[@"UILaunchImageOrientation"]]) {
//            launchImage = dict[@"UILaunchImageName"];
//        }
        //适配iPad
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
            if([viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]){
            launchImage = dict[@"UILaunchImageName"];
            }
        }else if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            if(CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]) {
                launchImage = dict[@"UILaunchImageName"];
            }
        }
        
    }
    //背景图
    UIImageView *launchImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:launchImage]];
    [launchImageView setUserInteractionEnabled:YES];
    [self.view addSubview:launchImageView];
    self.launchImageView =launchImageView;
    
    //语言按钮
    UIButton *languageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [languageButton setTitle:@"简体中文" forState:UIControlStateNormal];

    [languageButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [languageButton addTarget:self action:@selector(languageSelected:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:languageButton];
    self.languageButton = languageButton;
    
    //登录按钮
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [loginButton setBackgroundImage:[UIImage imageWithColor:[UIColor grayColor]] forState:UIControlStateHighlighted];
    [loginButton.layer setCornerRadius:5];
    [loginButton.layer setMasksToBounds:YES];
   
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
   
    [loginButton addTarget:self action:@selector(loginAccount:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    self.loginButton = loginButton;
    
   
    
    //注册按钮
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerButton setBackgroundImage:[UIImage resizeWithImageName:@"fts_green_btn"] forState:UIControlStateNormal];
    [registerButton setBackgroundImage:[UIImage resizeWithImageName:@"fts_green_btn_HL"] forState:UIControlStateHighlighted];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
   
    [registerButton addTarget:self action:@selector(registerAccount:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    self.registerButton = registerButton;
    
   
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    UIDeviceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    //适配iPad
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        
        [self.loginButton.titleLabel setFont:[UIFont systemFontOfSize:20.0]];
        [self.registerButton.titleLabel setFont:[UIFont systemFontOfSize:20.0]];
        
         //翻转为竖屏时
        if (interfaceOrientation == UIDeviceOrientationPortrait || interfaceOrientation ==UIDeviceOrientationPortraitUpsideDown) {
            [self.launchImageView setFrame:self.view.frame];
            [self.languageButton setFrame:CGRectMake(600, 80, 100, 30)];
            [self.loginButton setFrame:CGRectMake(175, 804, 200, 54)];
            [self.registerButton setFrame:CGRectMake(425, 800, 200, 60)];
            
        }else if (interfaceOrientation==UIDeviceOrientationLandscapeLeft || interfaceOrientation ==UIDeviceOrientationLandscapeRight) {
            [self.launchImageView setFrame:self.view.frame];
            [self.languageButton setFrame:CGRectMake(800, 80, 100, 30)];
            [self.loginButton setFrame:CGRectMake(300, 604, 200, 54)];
            [self.registerButton setFrame:CGRectMake(550, 600, 200, 60)];
        }
    }else if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            [self.languageButton.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
            [self.loginButton.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
            [self.registerButton.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
        
            [self.launchImageView setFrame:self.view.frame];
            [self.languageButton setFrame:CGRectMake(200, 60, 100, 30)];
            [self.loginButton setFrame:CGRectMake(55, 454, 100, 34)];
            [self.registerButton setFrame:CGRectMake(175, 450, 100, 40)];
            NSLog(@"isphone %lf",[[UIScreen mainScreen] nativeScale]);

    }
}

#pragma mark - 登录与注册方法

- (void)languageSelected:(UIButton *) button{
    //选择语言
    NSLog(@"选择语言");
    WeChatNavigationController *controller = [[WeChatNavigationController alloc] initWithRootViewController:self.languageSelect];
      //设置导航栏属性
    [controller setWeChatNavigationDefaultStyle];
    [self presentViewController:controller animated:YES completion:nil];

}

- (void)loginAccount:(UIButton *) button{
//        AppDelegate *application = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    application.window.rootViewController = controller;   
    
    WeChatNavigationController *controller = [[WeChatNavigationController alloc] initWithRootViewController:self.loginAccount];
    
    [controller setWeChatNavigationBackgroudColor:[UIColor colorWithWhite:1.0 alpha:0.8]];
    
  //  [controller setModalPresentationStyle:UIModalPresentationFormSheet];
    //翻页效果 UIModalTransitionStylePartialCurl
    //水平翻页效果 UIModalTransitionStyleFlipHorizontal
    
//    [controller setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    

    [self presentViewController:controller animated:YES completion:nil];
}



- (void)registerAccount:(UIButton *) button{
   
    
//    AppDelegate *application = [[UIApplication sharedApplication] delegate];
//    application.window.rootViewController = controller;    
#warning :注意 uiviewcontroller 与导航控制器搭配使用
    WeChatNavigationController *controller = [[WeChatNavigationController alloc] initWithRootViewController:self.registerAccount];
    
    [controller setWeChatNavigationBackgroudColor:[UIColor colorWithWhite:1.0 alpha:0.8]];
//    [controller setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];

   [self presentViewController:controller animated:YES completion:nil];
   
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
