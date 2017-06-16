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
    
    XLsn0wLog(@"Using XLsn0wKit");
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor     = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    AliMapRootViewController *vc = [[AliMapRootViewController alloc] init];
    self.window.rootViewController  = [[UINavigationController alloc] initWithRootViewController:vc];

    
    [self getAndSaveCookie];

    
    
    [AMapServices sharedServices].apiKey = AMapAPIKey;

    
    return YES;
}

- (void)downloadZip {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{// long-running task
        
        [XLsn0wNetworkManager downloadFileWithURL:@"http://cloud.lgcool.com/CityPark/resourceDownload/samecity_ios.zip"
                                    requestMethod:@"GET"
                                       parameters:nil
                                         savePath:[NSHomeDirectory() stringByAppendingString:@"/Documents/CityPark/"]
                                  downloadSuccess:^(NSURLResponse *response, NSURL *filePath) {
                                      
                                      XLsn0wLog(@"%@", filePath.path);
                                      
                                  } downloadFailure:^(NSError *error) {
                                      
                                      
                                  } downloadProgress:^(NSProgress *downloadProgress) {
                                      
                                      XLsn0wLog(@"%@", downloadProgress);
                                  }];
        
        dispatch_async(dispatch_get_main_queue(), ^{// update UI
            
        });
    });
    

}

#pragma mark 获取并保存cookie到userDefaults
- (void)getAndSaveCookie {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFCompoundResponseSerializer serializer];
    [manager POST:@"http://dev.skyfox.org/cookie.php" parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"\n======================================\n");
//        NSDictionary *fields = ((NSHTTPURLResponse*)task.response).allHeaderFields;
//        NSLog(@"fields = %@",[fields description]);
//        NSLog(@"---fields = %@",fields);
//        NSURL *url = [NSURL URLWithString:@"http://dev.skyfox.org/cookie.php"];
//        NSLog(@"\n======================================\n");
//        //获取cookie方法1
//        NSArray *cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:fields forURL:url];
//        for (NSHTTPCookie *cookie in cookies) {
//            NSLog(@"cookie,name:= %@,valuie = %@",cookie.name,cookie.value);
//            NSLog(@"cookie= %@",cookie);
//        }
//        NSLog(@"\n======================================\n");
//        //        //获取cookie方法2
//        //        NSString *cookies2 = [((NSHTTPURLResponse*)task.response) valueForKey:@"Set-Cookie"];
//        //        NSLog(@"cookies2 = %@",[cookies2 description]);
        
        
        NSArray *cookiesArray = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
        for (NSHTTPCookie *httpCookie in cookiesArray) {
   
            
            XLsn0wLog(@"httpCookie= %@", httpCookie);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
   

    
    //请求一个网址，即可分配到cookie
//   [XLsn0wNetworkManager POST:@"http://dev.skyfox.org/cookie.php" token:nil params:nil success:^(NSURLSessionDataTask *task, NSDictionary *JSONDictionary, NSString *JSONString) {
//       
//       //获取cookie
//       NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
//       for (NSHTTPCookie *tempCookie in cookies) {
//           //打印获得的cookie
//           NSLog(@"getCookie: %@", tempCookie);
//       }
//       
//       /*
//        * 把cookie进行归档并转换为NSData类型
//        * 注意：cookie不能直接转换为NSData类型，否则会引起崩溃。
//        * 所以先进行归档处理，再转换为Data
//        */
//       NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
//       
//       //存储归档后的cookie
//       
//       [[NSUserDefaults standardUserDefaults] setObject: cookiesData forKey: @"cookie"];
//       NSLog(@"\n");
//       
//       //[self deleteCookie];
//       
//       //[self setCoookie];
//       
//   } failure:^(NSURLSessionDataTask *task, NSError *error, NSInteger statusCode, NSString *requestFailedReason) {
//       
//       
//   }];

}

#pragma mark 删除cookie
- (void)deleteCookie
{
    NSLog(@"============删除cookie===============");
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    
    //删除cookie
    for (NSHTTPCookie *tempCookie in cookies) {
        [cookieStorage deleteCookie:tempCookie];
    }
    
    //把cookie打印出来，检测是否已经删除
    NSArray *cookiesAfterDelete = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (NSHTTPCookie *tempCookie in cookiesAfterDelete) {
        NSLog(@"cookieAfterDelete: %@", tempCookie);
    }
    NSLog(@"\n");
}

#pragma mark 再取出保存的cookie重新设置cookie
- (void)setCoookie
{
    NSLog(@"============再取出保存的cookie重新设置cookie===============");
    //取出保存的cookie
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //对取出的cookie进行反归档处理
    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"cookie"]];
    
    if (cookies) {
        NSLog(@"有cookie");
        //设置cookie
        NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (id cookie in cookies) {
            [cookieStorage setCookie:(NSHTTPCookie *)cookie];
        }
    }else{
        NSLog(@"无cookie");
    }
    
    //打印cookie，检测是否成功设置了cookie
    NSArray *cookiesA = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (NSHTTPCookie *cookie in cookiesA) {
        NSLog(@"setCookie: %@", cookie);
    }
    NSLog(@"\n");
}


- (void)setIFly {
    [IFlySpeechUtility createUtility:[NSString stringWithFormat:@"appid=%@,timeout=%@",@"5565399b",@"20000"]];
    
    [IFlySetting setLogFile:LVL_NONE];
    [IFlySetting showLogcat:NO];
    
    // 设置语音合成的参数
    [[IFlySpeechSynthesizer sharedInstance] setParameter:@"50" forKey:[IFlySpeechConstant SPEED]];//合成的语速,取值范围 0~100
    [[IFlySpeechSynthesizer sharedInstance] setParameter:@"50" forKey:[IFlySpeechConstant VOLUME]];//合成的音量;取值范围 0~100
    
    // 发音人,默认为”xiaoyan”;可以设置的参数列表可参考个 性化发音人列表;
    [[IFlySpeechSynthesizer sharedInstance] setParameter:@"xiaoyan" forKey:[IFlySpeechConstant VOICE_NAME]];
    
    // 音频采样率,目前支持的采样率有 16000 和 8000;
    [[IFlySpeechSynthesizer sharedInstance] setParameter:@"8000" forKey:[IFlySpeechConstant SAMPLE_RATE]];
    
    // 当你再不需要保存音频时，请在必要的地方加上这行。
    [[IFlySpeechSynthesizer sharedInstance] setParameter:nil forKey:[IFlySpeechConstant TTS_AUDIO_PATH]];
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
