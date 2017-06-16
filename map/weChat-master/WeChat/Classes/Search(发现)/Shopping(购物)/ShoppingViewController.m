//
//  ShoppingViewController.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/8.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "ShoppingViewController.h"
#import "ProgressHUD.h"

@interface ShoppingViewController ()<UIWebViewDelegate>

@end

@implementation ShoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setShoppingWebView];
}

- (void)setShoppingWebView{
    [self.navigationItem setTitle:@"京东购物"];
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

    NSURL *url = [NSURL URLWithString:@"https://wq.jd.com"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    [self.webView loadRequest:request];
    
    [self.webView setDelegate:self];
    
    [MBProgressHUD showMessage:@"请稍后..." toView:self.webView];
}

- (void)Finshed{
    // model方式返回
//    [self dismissViewControllerAnimated:YES completion:nil];
 
    //pop方式返回
    [self.navigationController popViewControllerAnimated:YES];
}

//加载完网页
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUDForView:webView];
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
