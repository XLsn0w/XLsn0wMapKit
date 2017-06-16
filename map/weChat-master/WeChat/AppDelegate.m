//
//  AppDelegate.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/1.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "AppDelegate.h"
#import "UIDevice+IphoneType.h"
#import "FirstLoginViewController.h"
#import "LoginedController.h"

@interface AppDelegate ()
@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self LoginView];
    
    return YES;
}

//是否支持横竖屏
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        return UIInterfaceOrientationMaskPortrait;
    }else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)LoginView {
    DebugLog(@"%@-%@",[[UIDevice currentDevice] iphoneType],[[UIDevice currentDevice] iphoneOS]);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    UIViewController *controller = nil;
    
    if([[defaults objectForKey:@"loginState"] isEqualToString:@"hasLogined"]){
        controller = [[LoginedController alloc] init];
        
    }else{
        //首次登陆
        controller = [[FirstLoginViewController alloc] init];
    }

    self.window.rootViewController = controller;
}

@end
