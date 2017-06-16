//
//  BaseReflashView.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/11.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "BaseReflashView.h"

@implementation BaseReflashView



- (void)setScrollView:(UIScrollView *)scrollView{
    _scrollView = scrollView;
    NSLog(@"----------2------------");
    //添加观察者1 contentOffset
    [scrollView addObserver:self forKeyPath:BaseRefreshViewObserveKeyPath options:NSKeyValueObservingOptionNew context:nil];
    //添加观察者2 isDraging
    [scrollView addObserver:self forKeyPath:BaseRefreshViewObserveDragginKeyPath options:NSKeyValueObservingOptionNew context:nil];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview) {
        //移除观察者
        [self.scrollView removeObserver:self forKeyPath:BaseRefreshViewObserveKeyPath];
        
        [self.scrollView removeObserver:self forKeyPath:BaseRefreshViewObserveDragginKeyPath];
    }
}

- (void)endRefreshing{
    NSLog(@"----------1------------");
    self.refreshState = RefreshViewStateNormal;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    NSLog(@"呵呵");
}

@end
