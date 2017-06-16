//
//  BaseSearchBar.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/29.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "BaseSearchBar.h"

@interface BaseSearchBar ()<UISearchBarDelegate>

@end

@implementation BaseSearchBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setup];
    }
    return self;
}

- (void)setup{
    [self setSearchFieldBackgroundImage:[UIImage imageNamed:@"widget_searchbar_textfield"] forState:UIControlStateNormal];
    
    [self setBackgroundColor:[UIColor clearColor]];
    
    
    [self setValue:@"取消" forKey:@"_cancelButtonText"];
    
    [self setDelegate:self];
    //是否
    [self sizeToFit];
    [self setPlaceholder:@"微信号/手机号"];
    
    //删除默认灰色背景
    [[[self.subviews.firstObject subviews] firstObject] removeFromSuperview];
    
    [self setShowsCancelButton:YES];
    
    //搜索框光标颜色
    [self setTintColor:[UIColor colorWithRed:31/255.0 green:185/255.0 blue:34/255.0 alpha:1.0]];
    
    //搜索输入框边框颜色
    UITextField *searchField = [self valueForKey:@"_searchField"];
    
    [searchField addTarget:self action:@selector(textFielddidChange:) forControlEvents:UIControlEventValueChanged];
    
//    searchField.layer.borderColor = [UIColor grayColor].CGColor;
//    
//    searchField.layer.borderWidth = 1;
//    searchField.layer.cornerRadius = 5;
//    searchField.layer.masksToBounds = YES;
    
    //进入搜索状态
    [searchField becomeFirstResponder];
}



- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    UITextField *searchField = [self valueForKey:@"_searchField"];
    [searchField resignFirstResponder];
    
    if([self.protocal respondsToSelector:@selector(baseSearchBarCancelButtonClicked:)]){
        [self.protocal baseSearchBarCancelButtonClicked:self];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if([self.protocal respondsToSelector:@selector(baseSearchBar:textDidChange:)]){
        [self.protocal baseSearchBar:self textDidChange:searchText];
    }
}


@end
