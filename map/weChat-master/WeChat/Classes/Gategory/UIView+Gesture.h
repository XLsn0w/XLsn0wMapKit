//
//  UIView+Gesture.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/11.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^GestureRecognizeBlock)(void);
@interface UIView (Gesture)

@property(nonatomic,strong)UITapGestureRecognizer *tapGesture;
@property(nonatomic,copy)GestureRecognizeBlock tapGestureBlock;
@property(nonatomic,strong)UILongPressGestureRecognizer *longPressGesture;
@property(nonatomic,copy)GestureRecognizeBlock longPressGestureBlock;

- (void)setTapActionWithBlock:(void (^)(void))block;
- (void)setLongPressActionWithBlock:(void (^)(void))block;
@end
