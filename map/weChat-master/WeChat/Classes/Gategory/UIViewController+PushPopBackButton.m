//
//  UIViewController+PushPopBackButton.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/9.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "UIViewController+PushPopBackButton.h"
#import "MUAssosiation.h"

@implementation UIViewController (PushPopBackButton)

#pragma mark - 分类属性方法设置
- (void)setDelegate:(id<UIViewControllerDelegate>)delegate{
    [self setAssociatedObject:delegate forKey:@"delegateKey" association:NSAssociationWeak isAtomic:NO];
}

- (id<UIViewControllerDelegate>)delegate
{
    return [self associatedObjectForKey:@"delegateKey"];
}


- (void)setVcSchedStyle:(UIViewControllerSchedStyle)vcSchedStyle{
    NSNumber *schedStyle = [NSNumber numberWithInteger:vcSchedStyle];
    [self setAssociatedObject:schedStyle forKey:@"vcSchedStyle" association:NSAssociationAssign isAtomic:NO];
}

- (UIViewControllerSchedStyle)vcSchedStyle{
    return (UIViewControllerSchedStyle)[[self associatedObjectForKey:@"vcSchedStyle"] integerValue];
}

#pragma mark - 该方法用于拦截导航栏上返回按钮的执行
- (BOOL)navigationShouldPopOnBackButton{
    
    if([self.delegate respondsToSelector:@selector(baseUIViewDidListenNavigationShouldPopOnByBackButton)]){
        [self.delegate baseUIViewDidListenNavigationShouldPopOnByBackButton];
    }
    
    return YES;
}

@end
