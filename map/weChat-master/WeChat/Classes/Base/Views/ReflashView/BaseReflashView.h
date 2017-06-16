//
//  BaseReflashView.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/11.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    RefreshViewStateNormal,
    RefreshViewStateWillRefresh,
    RefreshViewStateRefreshing,
} RefreshViewState;

#define BaseRefreshViewObserveKeyPath  @"contentOffset"
#define BaseRefreshViewObserveDragginKeyPath  @"isDragging"
@interface BaseReflashView : UIView

@property (nonatomic, assign) RefreshViewState refreshState;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) UIEdgeInsets scrollViewOriginalInsets;

- (void)endRefreshing;
@end
