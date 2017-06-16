//
//  UIView+layout.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/17.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    OscillatoryAnimationToBigger,
    OscillatoryAnimationToSmaller,
} OscillatoryAnimationType;
@interface UIView (layout)


+ (void)showOscillatoryAnimationWithLayer:(CALayer *)layer type:(OscillatoryAnimationType)type;

@end
