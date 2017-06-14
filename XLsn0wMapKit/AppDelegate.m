//
//  AppDelegate.m
//  XLsn0wMapKit
//
//  Created by XLsn0w on 2017/6/13.
//  Copyright © 2017年 XLsn0w. All rights reserved.
//

#import "AppDelegate.h"
#import "AliMapRootViewController.h"
#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor     = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    AliMapRootViewController *vc = [[AliMapRootViewController alloc] init];
    self.window.rootViewController  = [[UINavigationController alloc] initWithRootViewController:vc];

    
    
    [AMapServices sharedServices].apiKey = AMapAPIKey;
//    
//    [IFlySpeechUtility createUtility:[NSString stringWithFormat:@"appid=%@,timeout=%@",@"5565399b",@"20000"]];
//    
//    [IFlySetting setLogFile:LVL_NONE];
//    [IFlySetting showLogcat:NO];
//    
//    // 设置语音合成的参数
//    [[IFlySpeechSynthesizer sharedInstance] setParameter:@"50" forKey:[IFlySpeechConstant SPEED]];//合成的语速,取值范围 0~100
//    [[IFlySpeechSynthesizer sharedInstance] setParameter:@"50" forKey:[IFlySpeechConstant VOLUME]];//合成的音量;取值范围 0~100
//    
//    // 发音人,默认为”xiaoyan”;可以设置的参数列表可参考个 性化发音人列表;
//    [[IFlySpeechSynthesizer sharedInstance] setParameter:@"xiaoyan" forKey:[IFlySpeechConstant VOICE_NAME]];
//    
//    // 音频采样率,目前支持的采样率有 16000 和 8000;
//    [[IFlySpeechSynthesizer sharedInstance] setParameter:@"8000" forKey:[IFlySpeechConstant SAMPLE_RATE]];
//    
//    // 当你再不需要保存音频时，请在必要的地方加上这行。
//    [[IFlySpeechSynthesizer sharedInstance] setParameter:nil forKey:[IFlySpeechConstant TTS_AUDIO_PATH]];
//    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
