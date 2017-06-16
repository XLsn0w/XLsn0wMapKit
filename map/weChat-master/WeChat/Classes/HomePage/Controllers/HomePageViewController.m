//
//  HomePageViewController.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/6.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "HomePageViewController.h"
#import "WeChatNavigationController.h"
#import "WeChatTabbarView.h"
#import "BaseGroupTableViewController.h"
#import "MeViewController.h"
#import "SearchViewController.h"
#import "ContactViewController.h"

@interface HomePageViewController () <WeChatTabbarViewDelegate>

@end


@implementation HomePageViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [self addNavigationBar];
    [self addTabBar:self.childViewControllers.count];
}

- (void)addNavigationBar{
  #ifdef USE_DEFAULT_NAVIGATION
    NSArray *TabbarImageNames = @[@"tabbar_mainframe",@"tabbar_contacts",@"tabbar_discover",@"tabbar_me"];
    NSArray *TabBarItemNames = @[@"微信",@"通信录",@"发现",@"我"];
   #endif
    
    //微信
    WeChatNavigationController *weChatNavigationController = [[WeChatNavigationController alloc] init];
    BaseGroupTableViewController *weChatViewController = [[BaseGroupTableViewController alloc] init];
#ifdef USE_DEFAULT_NAVIGATION
        UITabBarItem * wechat = [[UITabBarItem alloc] initWithTitle:[TabBarItemNames objectAtIndex:0] image:[UIImage imageNamed:[NSString stringWithFormat:@"%@",TabbarImageNames[0]]] selectedImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@HL",TabbarImageNames[0]]]];
    [wechat setBadgeValue:@"1"];
    [weChatViewController setTabBarItem:wechat];
#endif
    [weChatViewController.view setBackgroundColor:[UIColor greenColor]];
    [weChatNavigationController addChildViewController:weChatViewController];
    [weChatNavigationController setWeChatNavigationDefaultStyle];
    [self addChildViewController:weChatNavigationController];
    
    //通信录
    WeChatNavigationController *contactNavigationController = [[WeChatNavigationController alloc] init];
    ContactViewController *contactViewController = [[ContactViewController alloc] init];
#ifdef USE_DEFAULT_NAVIGATION
    UITabBarItem * contact = [[UITabBarItem alloc] initWithTitle:[TabBarItemNames objectAtIndex:1] image:[UIImage imageNamed:[NSString stringWithFormat:@"%@",TabbarImageNames[1]]] selectedImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@HL",TabbarImageNames[1]]]];
    [contactViewController setTabBarItem:contact];
#endif
//    [contactViewController.view setBackgroundColor:[UIColor yellowColor]];
    [contactNavigationController addChildViewController:contactViewController];
    [contactNavigationController setWeChatNavigationDefaultStyle];
    [self addChildViewController:contactNavigationController];
    
    //发现
    WeChatNavigationController *searchNavigationController = [[WeChatNavigationController alloc] init];
    
    SearchViewController *searchViewController = [[SearchViewController alloc] init];
#ifdef USE_DEFAULT_NAVIGATION
    UITabBarItem * discover = [[UITabBarItem alloc] initWithTitle:[TabBarItemNames objectAtIndex:2] image:[UIImage imageNamed:[NSString stringWithFormat:@"%@",TabbarImageNames[2]]] selectedImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@HL",TabbarImageNames[2]]]];
    [searchViewController setTabBarItem:discover];
#endif
//    [searchViewController.view setBackgroundColor:[UIColor blueColor]];
    [searchNavigationController addChildViewController:searchViewController];
    [searchNavigationController setWeChatNavigationDefaultStyle];
    [self addChildViewController:searchNavigationController];
    
    //我
    WeChatNavigationController *meNavigationController = [[WeChatNavigationController alloc] init];
    MeViewController *meViewController = [[MeViewController alloc] init];
#ifdef USE_DEFAULT_NAVIGATION
    UITabBarItem * me = [[UITabBarItem alloc] initWithTitle:[TabBarItemNames objectAtIndex:3] image:[UIImage imageNamed:[NSString stringWithFormat:@"%@",TabbarImageNames[3]]] selectedImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@HL",TabbarImageNames[3]]]];
    [meNavigationController setTabBarItem:me];
#endif
    //[meViewController.view setBackgroundColor:[UIColor purpleColor]];
    [meNavigationController addChildViewController:meViewController];
    [meNavigationController setWeChatNavigationDefaultStyle];
    [self addChildViewController:meNavigationController];
    
}

- (void) addTabBar:(NSInteger) buttonItemNumber{
    NSArray  *TabbarImageNames = @[@"tabbar_mainframe",@"tabbar_contacts",@"tabbar_discover",@"tabbar_me"];
    NSArray  *TabBarItemNames = @[@"微信",@"通信录",@"发现",@"我"];
    
    [self.tabBarView setDelegate:self];
    
    [self addTabBarItemWithItemNum:buttonItemNumber andNameArray:TabBarItemNames andImageNameArray:TabbarImageNames];
}

- (void)dealloc{
    DebugLog(@"主界面控制器释放了");
}

#pragma mark - 实现代理方法
- (void)WeChatTabbarView:(WeChatTabbarView *)tabBarView didSelectedBarButtonItemAtIndex:(NSInteger)index{
#ifndef USE_DEFAULT_NAVIGATION
    self.selectedIndex = index;
#endif
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
