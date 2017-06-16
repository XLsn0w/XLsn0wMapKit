//
//  WeChatTabbarController.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/3.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabbarConfig.h"
@class WeChatTabbarView;

typedef enum{
    WeChatTabbarHiderOptionStyleDefault     = 0,
    WeChatTabbarHiderOptionStyleFlipLeft    = 1,
    WeChatTabbarHiderOptionStyleFlipRight   = 2,
    WeChatTabbarHiderOptionStyleFlipBootom   = 3,
}WeChatTabbarHiderOptionStyle;

@interface WeChatTabbarController : UITabBarController
@property(nonatomic,strong)WeChatTabbarView *tabBarView;

- (void)setHidesBottomTabBarWhenPushed:(BOOL)hides withViewController:(UIViewController *) controller;
- (void)setWeChatTabBarBackgroudColor:(UIColor *)color;
- (void)setHidesBottomTabBarWhenPushed:(BOOL)hides withAnimationStyle:(WeChatTabbarHiderOptionStyle) style;
- (void)addTabBarItemWithItemNum:(NSInteger) buttonItemNumber andNameArray:(NSArray *) nameArray andImageNameArray:(NSArray *) imageNameArray;
@end
