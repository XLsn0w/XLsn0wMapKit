//
//  AllowMentWebViewController.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/3.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "AllowMentWebViewController.h"

@interface AllowMentWebViewController () <UIWebViewDelegate>

@end

@implementation AllowMentWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setAllowMentWebView];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setAllowMentWebView{
    [self.navigationItem setTitle:@"使用条款和隐私政策"];
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(Finshed)];
    [back setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:24.0]} forState:UIControlStateNormal];
    [self.navigationItem setLeftBarButtonItem:back];
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        [back setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:24.0]} forState:UIControlStateNormal];
    }else{
        [back setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.0]} forState:UIControlStateNormal];
    }
    
    //加载网页
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    NSURL *url = [NSURL URLWithString:@"http://weixin.qq.com/agreement?lang=zh_CN"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    [webView loadRequest:request];
    
    [webView setDelegate:self];
    [self setView:webView];
}

- (void)Finshed{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//加载完网页
- (void)webViewDidFinishLoad:(UIWebView *)webView{

    NSLog(@"加载网页");
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
