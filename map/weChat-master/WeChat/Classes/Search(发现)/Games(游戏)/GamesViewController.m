//
//  GamesViewController.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/22.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "GamesViewController.h"
#import "ProgressHUD.h"

@interface GamesViewController ()<UIWebViewDelegate>

@end

@implementation GamesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setGamesWebView];
}

- (void)setGamesWebView{
    [self.navigationItem setTitle:@"微信游戏"];
    self.navigationItem.leftBarButtonItem.title =@"返回";
    self.navigationController.navigationItem.leftBarButtonItem.title = @"返回";
    
    
    //    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(Finshed)];
    //    [back setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:24.0]} forState:UIControlStateNormal];
    //    [self.navigationItem setLeftBarButtonItem:back];
    //
    //    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
    //        [back setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:24.0]} forState:UIControlStateNormal];
    //    }else{
    //        [back setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0]} forState:UIControlStateNormal];
    //    }
    
    //加载网页
    
    NSURL *url = [NSURL URLWithString:@"http://m.le890.com"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    [self.webView loadRequest:request];
    
    [self.webView setDelegate:self];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_set"] style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClick)];
    self.navigationItem.rightBarButtonItem = right;
    
  
    [MBProgressHUD showMessage:@"请稍后..." toView:self.webView];
}

- (void)rightButtonClick{
    
}

//加载完网页
- (void)webViewDidFinishLoad:(UIWebView *)webView{
  [MBProgressHUD hideHUDForView:webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
