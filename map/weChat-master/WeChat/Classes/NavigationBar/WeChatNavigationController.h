//
//  WeChatNavigationController.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/2.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WeChatNavigationController : UINavigationController

typedef enum{
    WeChatNavigationbarHiderOptionStyleDefault     = 0,
    WeChatNavigationbarHiderOptionStyleFlipLeft    = 1,
    WeChatNavigationbarHiderOptionStyleFlipRight   = 2,
    WeChatNavigationbarHiderOptionStyleFlipUpNormal = 3,
    WeChatNavigationbarHiderOptionStyleFlipUpBubble = 4,
}WeChatNavigationbarHiderOptionStyle;

#define     AppearFlipBubbleOffset      5
#define     NavigationBarDefaultOffsetY  20
- (void)setNavigationBarSize:(CGFloat) height;

@property (nonatomic,assign)BOOL NavigationBarHider;

- (void)setWeChatNavigationDefaultStyle;
- (void)setWeChatNavigationHideStyle;
- (void)setWeChatNavigationBackgroudColor:(UIColor *)color;
- (void)setHidesNavigationBar:(BOOL)hides withAnimationStyle:(WeChatNavigationbarHiderOptionStyle) style;
@end
