//
//  UIView+Extension.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/11.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

//布局器的view
@property (nonatomic,strong)UIView *layoutView;


- (UIView *)equalCenterXTo:(UIView *)view;
- (UIView *)equalCenterYTo:(UIView *)view;
- (UIView *)leftOffSetTo:(UIView *)view withOffset:(CGFloat) offset;
- (UIView *)rightOffSetTo:(UIView *)view withOffset:(CGFloat) offset;
- (UIView *)topOffSetTo:(UIView *)view withOffset:(CGFloat) offset;
- (UIView *)downtOffSetTo:(UIView *)view withOffset:(CGFloat) offset;
- (UIView *)leftOffSetFrom:(UIView *)view withOffset:(CGFloat) offset;
- (UIView *)rightOffSetFrom:(UIView *)view withOffset:(CGFloat) offset;
- (UIView *)topOffSetFrom:(UIView *)view withOffset:(CGFloat) offset;
- (UIView *)bottomOffSetFrom:(UIView *)view withOffset:(CGFloat) offset;
- (UIView *)bottomOffSetTo:(UIView *)view withOffset:(CGFloat) offset;

- (UIView *)topEqualTo:(UIView *)view;
- (UIView *)leftEqualTo:(UIView *)view;
- (UIView *)rightEqualTo:(UIView *)view;
- (UIView *)bottomEqualTo:(UIView *)view;
- (UIView *)resetLayout;
- (UIView *)resetLayoutView;
- (UIView *)resetLayoutSubView;
- (CGSize)endLayoutWithEndMarginRightX:(CGFloat)xMargin andMarginBottomY:(CGFloat)yMargin;
@end
