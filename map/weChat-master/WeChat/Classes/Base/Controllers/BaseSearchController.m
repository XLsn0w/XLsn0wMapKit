//
//  BaseSearchController.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/28.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "BaseSearchController.h"

@interface BaseSearchController ()

@end

@implementation BaseSearchController

- (instancetype)initWithSearchResultsController:(UIViewController *)searchResultsController{
    self = [super initWithSearchResultsController:searchResultsController];
    if(self){
        [self setup];
    }
    
    return self;
}

- (void)setup{
    [self.searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"widget_searchbar_textfield"] forState:UIControlStateNormal];
    
    [self.searchBar setFrame:CGRectMake(0, 0, 0, 50)];
    [self.searchBar setBackgroundColor:[UIColor clearColor]];

    //取消按钮
    [self.searchBar setValue:@"取消" forKey:@"_cancelButtonText"];
    
    
    //是否添加半透明覆盖层
    [self setDimsBackgroundDuringPresentation:YES];
    [self.searchBar sizeToFit];
    [self.searchBar setPlaceholder:@"微信号/手机号"];
    
    //删除默认灰色背景
    [[[self.searchBar.subviews.firstObject subviews] firstObject] removeFromSuperview];
    
    [self.searchBar setShowsCancelButton:YES];
    
    //输入的时候是否隐藏导航栏
//    [self setHidesNavigationBarDuringPresentation:YES];
    
    //搜索框光标颜色
    [self.searchBar setTintColor:[UIColor colorWithRed:31/255.0 green:185/255.0 blue:34/255.0 alpha:1.0]];
    
    //搜索输入框边框颜色
    UITextField *searchField = [self.searchBar valueForKey:@"_searchField"];
    
    searchField.layer.borderColor = [UIColor grayColor].CGColor;
    
    searchField.layer.borderWidth = 1;
    searchField.layer.cornerRadius = 5;
    searchField.layer.masksToBounds = YES;
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
