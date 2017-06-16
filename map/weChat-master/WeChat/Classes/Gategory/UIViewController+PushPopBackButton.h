//
//  UIViewController+PushPopBackButton.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/9.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BackButtonHandlerProtocol <NSObject>
@optional
// 重写下面的方法以拦截导航栏返回按钮点击事件，返回 YES 则 pop，NO 则不 pop
-(BOOL)navigationShouldPopOnBackButton;
@end

@protocol UIViewControllerDelegate <NSObject>

@optional

- (void)baseUIViewDidListenNavigationShouldPopOnByBackButton;

@end

#define  FristViewControllerIndexNumber    1
#define  SecondViewControllerIndexNumber   2

typedef enum{
    UIViewControllerSchedPopPushStyle = 0,
    UIViewControllerSchedModelStyle   = 1,
    UIViewControllerSchedToRootWindowStyle = 2,
}UIViewControllerSchedStyle;

@interface UIViewController (PushPopBackButton) <BackButtonHandlerProtocol>

@property (nonatomic,weak)id<UIViewControllerDelegate> delegate;

@property (nonatomic,assign)UIViewControllerSchedStyle vcSchedStyle;

@end
