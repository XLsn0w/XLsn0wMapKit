//
//  UINavigationController+p.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/14.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (p)

- (void)pushViewController: (UIViewController*)controller
    animatedWithTransition: (UIViewAnimationTransition)transition;
- (UIViewController*)popViewControllerAnimatedWithTransition:(UIViewAnimationTransition)transition ;
@end
