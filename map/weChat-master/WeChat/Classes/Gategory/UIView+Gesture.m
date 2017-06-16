//
//  UIView+Gesture.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/11.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "UIView+Gesture.h"
#import <objc/runtime.h>
#import "MUAssosiation.h"



      
@implementation UIView (Gesture)

- (void)setTapGesture:(UITapGestureRecognizer *)tapGesture{
    [self setAssociatedObject:tapGesture forKey:@"TapGesture" association:NSAssociationRetain isAtomic:NO];
}

- (UITapGestureRecognizer *)tapGesture{
    return [self associatedObjectForKey:@"TapGesture"];
}

- (void)setTapGestureBlock:(GestureRecognizeBlock)tapGestureBlock{
    [self setAssociatedObject:tapGestureBlock forKey:@"TapGestureBlock" association:NSAssociationCopy isAtomic:NO];
}
- (GestureRecognizeBlock)tapGestureBlock{
    return [self associatedObjectForKey:@"TapGestureBlock"];
}

- (void)setLongPressGesture:(UITapGestureRecognizer *)longPressGesture{
    [self setAssociatedObject:longPressGesture forKey:@"LongPressGesture" association:NSAssociationRetain isAtomic:NO];
}

- (UITapGestureRecognizer *)longPressGesture{
    return [self associatedObjectForKey:@"LongPressGesture"];
}

- (void)setLongPressGestureBlock:(GestureRecognizeBlock)longPressGestureBlock{
    [self setAssociatedObject:longPressGestureBlock forKey:@"LongPressGestureBlock" association:NSAssociationCopy isAtomic:NO];
}

- (GestureRecognizeBlock)longPressGestureBlock{
    return [self associatedObjectForKey:@"LongPressGestureBlock"];
}

- (void)setTapActionWithBlock:(void (^)(void))block
{
    self.tapGestureBlock = block;
    
    if (!self.tapGesture){
        self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForTapGesture:)];
        [self addGestureRecognizer:self.tapGesture];
    }
}

- (void)handleActionForTapGesture:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized){
        if (self.tapGestureBlock){
            self.tapGestureBlock();
           
        }
    }
}


- (void)setLongPressActionWithBlock:(void (^)(void))block
{
    self.longPressGestureBlock = block;
    
    if (!self.longPressGesture)
    {
        self.longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForLongPressGesture:)];
        [self addGestureRecognizer:self.longPressGesture];
        
    }
    
}

- (void)handleActionForLongPressGesture:(UITapGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan){
        if (self.longPressGestureBlock){
            self.longPressGestureBlock();
        }
    }
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   
    
}

@end
