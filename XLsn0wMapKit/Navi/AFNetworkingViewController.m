//
//  AFNetworkingViewController.m
//  iOS-Cookie
//
//  Created by Jakey on 2016/12/7.
//  Copyright © 2016年 www.skyfox.org. All rights reserved.
//

#import "AFNetworkingViewController.h"
#import "AFNetworking.h"
@interface AFNetworkingViewController ()

@end

@implementation AFNetworkingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
   
    
    [AFHTTPSessionManager manager].responseSerializer = [AFCompoundResponseSerializer serializer];
    [[AFHTTPSessionManager manager] POST:@"http://dev.skyfox.org/cookie.php"
                              parameters:nil
                                progress:^(NSProgress * _Nonnull uploadProgress) {
                                    
                                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                    
                                    
                                    NSDictionary *fields = ((NSHTTPURLResponse*)task.response).allHeaderFields;
                                    
                                    
                                    NSArray *cookiesArray = [NSHTTPCookie cookiesWithResponseHeaderFields:fields
                                                                                                   forURL:[NSURL URLWithString:@"http://dev.skyfox.org/cookie.php"]];
                                    
                                    
                                    for (NSHTTPCookie *cookie in cookiesArray) {
                                        
                                        
                                        NSLog(@"cookie= %@",cookie);
                                    }
                              
                                    
                                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                    
                                }];
}

//合适的时机持久化Cookie
- (void)saveCookies{
    NSData *cookiesData = [NSKeyedArchiver archivedDataWithRootObject: [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
  
    
    [[NSUserDefaults standardUserDefaults] setObject:cookiesData forKey:@"org.skyfox.cookiesave"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}




//合适的时机加载持久化后Cookie 一般都是app刚刚启动的时候
- (void)loadSavedCookies{
    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey: @"org.skyfox.cookiesave"]];
   
    
    for (NSHTTPCookie *cookie in cookies){
        NSLog(@"cookie,name:= %@,valuie = %@",cookie.name,cookie.value);
    }

}

@end
