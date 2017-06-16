//
//  BaseSearchBar.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/29.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseSearchBar;

@protocol  BaseSearchBarProtocal <NSObject>

@optional
- (void)baseSearchBarCancelButtonClicked:(BaseSearchBar *)searchBar;
- (void)baseSearchBar:(BaseSearchBar *)searchBar textDidChange:(NSString *)searchText;

@end

@interface BaseSearchBar : UISearchBar
@property (nonatomic,weak)id<BaseSearchBarProtocal> protocal;

@end
