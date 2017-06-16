//
//  UIView+Observer.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/13.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "UIView+Observer.h"
#import "MUAssosiation.h"

@implementation UIView (Observer) 

- (void)setScorllObserveState:(BOOL)scorllObserveState{
    NSNumber *state = [NSNumber numberWithBool:scorllObserveState];
    [self setAssociatedObject:state forKey:@"ViewObserveStat" association:NSAssociationAssign isAtomic:NO];
}

- (BOOL)scorllObserveState{
    return [[self associatedObjectForKey:@"ViewObserveStat"] boolValue];
}

- (void)setScrollView:(UIScrollView *)scrollView{
    [self setAssociatedObject:scrollView forKey:@"ObserverScrollView" association:NSAssociationRetain isAtomic:NO];
    if(self.scorllObserveState){
        //添加观察者1 contentOffset
        [scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
        //添加观察者2 isDraging
        [scrollView addObserver:self forKeyPath:@"isDragging" options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (UIScrollView *)scrollView{
    return [self associatedObjectForKey:@"ObserverScrollView"];
}


- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (self.scorllObserveState&&!newSuperview) {
        self.scorllObserveState = NO;
        //移除观察者
        [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
        
        [self.scrollView removeObserver:self forKeyPath:@"isDragging"];
        
    }
}

#pragma mark - 监听scrollView 的滑动和拖拽事件
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if (![keyPath isEqualToString: @"contentOffset"]&&![keyPath isEqualToString: @"isDragging"]){
        return;
    }
    
//   DebugLog(@"监听scrollView 的滑动和拖拽事件 移动位置是:%@ ",NSStringFromCGPoint(self.scrollView.contentOffset));
    
    if([keyPath isEqualToString: @"isDragging"]){
        
    }else{
        
    }
    
}

#pragma mark - 取消选中与恢复

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.scrollView setCanCancelContentTouches:YES];
//    DebugLog(@"取消view选中");
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.scrollView setCanCancelContentTouches:NO];
//    DebugLog(@"允许view选中");
}

@end
