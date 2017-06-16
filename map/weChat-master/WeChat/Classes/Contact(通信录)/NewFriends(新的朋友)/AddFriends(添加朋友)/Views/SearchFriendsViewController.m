//
//  SearchFriendsViewController.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/29.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "SearchFriendsViewController.h"
#import "WeChatNavigationController.h"
#import "BaseSearchBar.h"

@interface SearchFriendsViewController ()<BaseSearchBarProtocal>

@end

@implementation SearchFriendsViewController

- (BaseSearchBar *)searchBar{
    if(!_searchBar){
        _searchBar = [[BaseSearchBar alloc] init];
        [_searchBar setFrame:CGRectMake(10, 0, self.navigationBar.width - 10, 40)];
        [self.navigationBar addSubview:_searchBar];
    }
    return _searchBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.searchBar setProtocal:self];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

- (void)baseSearchBarCancelButtonClicked:(BaseSearchBar *)searchBar{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)baseSearchBar:(BaseSearchBar *)searchBar textDidChange:(NSString *)searchText{
    //返回刷新 跟新数据源
    NSNotification *notice = [NSNotification notificationWithName:@"reflushWechatSearchFriends" object:searchText];
    [[NSNotificationCenter defaultCenter] postNotification:notice];
}

@end
