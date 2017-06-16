//
//  UIView+Extension.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/11.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "UIView+Extension.h"
#import "MUAssosiation.h"

@implementation UIView (Extension)

- (void)setLayoutView:(UIView *)layoutView{
    [self setAssociatedObject:layoutView forKey:@"layoutView" association:NSAssociationRetain isAtomic:NO];
}

- (UIView *)layoutView{
    return [self associatedObjectForKey:@"layoutView"];
}


- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

#pragma mark - 视图相对外部视图的位置
//距外部视图的左边
- (UIView *)leftOffSetTo:(UIView *)view withOffset:(CGFloat) offset{
    self.x = view.x + (offset + view.width);
    return self;
}
//距视图的右边
- (UIView *)rightOffSetTo:(UIView *)view withOffset:(CGFloat) offset{
    self.x = view.x - (offset + self.width) ;
    return self;
}
//距视图的顶部
- (UIView *)topOffSetTo:(UIView *)view withOffset:(CGFloat) offset{
   
        self.y = view.y + view.height + offset;
    return self;
}
//距视图的底部
- (UIView *)bottomOffSetTo:(UIView *)view withOffset:(CGFloat) offset{
    self.y = CGRectGetMaxY(view.frame) - (offset + self.height);
    return self;
}

#pragma mark - 子视图相对父视图的位置
//距父视图的左边
- (UIView *)leftOffSetFrom:(UIView *)view withOffset:(CGFloat) offset{
    self.x =  offset;
    return self;
}
//距父视图的右边
- (UIView *)rightOffSetFrom:(UIView *)view withOffset:(CGFloat) offset{
    if(!self.x){
        self.x = CGRectGetMaxX(view.frame) - (offset + self.width);
    }else{
        self.width = (view.x + view.width) - (offset + self.x);
    }
    
    return self;
}
//距父视图的顶部
- (UIView *)topOffSetFrom:(UIView *)view withOffset:(CGFloat) offset{
    self.y =  offset ;
    return self;
}
//距父视图的底部
- (UIView *)bottomOffSetFrom:(UIView *)view withOffset:(CGFloat) offset{
    self.y = CGRectGetMaxY(view.frame) - (offset + self.height);
    return self;
}

- (UIView *)equalCenterXTo:(UIView *)view{
    self.centerX = view.centerX;
    return self;
}

- (UIView *)equalCenterYTo:(UIView *)view{
    self.centerY = view.centerY;
    return self;
}

//顶点相同
- (UIView *)topEqualTo:(UIView *)view{
    self.y = view.y;
    return self;
}

//左边距相同
- (UIView *)leftEqualTo:(UIView *)view{
    self.x = view.x;
    return self;
}

//右边距相同
- (UIView *)rightEqualTo:(UIView *)view{
    self.x = view.x + (view.width - self.width);
    
    return self;
}

//顶部边距相同
- (UIView *)bottomEqualTo:(UIView *)view{
    self.y = view.y + (view.height - self.height);
    return self;
}

//重置子视图布局
- (UIView *)resetLayoutSubView{
    
    for(UIView *view in self.subviews){
        view.frame = CGRectZero;
    }
    
    return self;
}

- (UIView *)resetLayout{
    self.frame = CGRectZero;
    return self;
}

- (UIView *)resetLayoutView{
    self.origin = CGPointZero;
    [self resetLayoutSubView];
    return self;
}

- (CGSize)endLayoutWithEndMarginRightX:(CGFloat)xMargin andMarginBottomY:(CGFloat)yMargin{
    CGSize size = CGSizeZero;
    CGFloat lastHeight = 0;
    CGFloat lastWidth = 0;
    
    for(UIView *view in self.subviews){
        if((view.y + view.height) > lastHeight){
            lastHeight = (view.y + view.height);
        }
        
        if((view.x + view.width) > lastWidth){
            lastWidth = (view.x + view.width);
        }
    }
    
     size.height = lastHeight + yMargin;
     size.width  = lastWidth + xMargin;
     self.layoutView.size = size;
    
    return size;
}
@end
