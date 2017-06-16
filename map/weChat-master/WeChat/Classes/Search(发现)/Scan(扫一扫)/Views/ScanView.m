//
//  ScanView.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/19.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "ScanView.h"
#import "ScanTabbarView.h"





@interface ScanView ()
@property (nonatomic, strong) CAShapeLayer *overlay;
@end

@implementation ScanView

#pragma mark - 懒加载 ------------------------------

- (CAShapeLayer *)overlay{
    if(!_overlay){
        _overlay = [[CAShapeLayer alloc] init];
        [_overlay setBackgroundColor:[UIColor greenColor].CGColor];
        [_overlay setFillColor:[UIColor clearColor].CGColor];
        [_overlay setStrokeColor:[UIColor lightGrayColor].CGColor];
        [_overlay setLineWidth:1];
        [_overlay setLineDashPattern:@[@50,@0]];
        [_overlay setLineDashPhase:1];
        [self.layer addSublayer:_overlay];
    }
    
    return _overlay;
}


#pragma mark - 视图加载方法 ---------------------------------------------------

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self addOverlay];
    }
    return self;
}

- (void)addOverlay{
    // 设置遮盖层不透明度
    [self.overlay setOpacity:0.4];
}

- (void)drawRect:(CGRect)rect
{
    CGRect innerRect = CGRectInset(rect, 50, 50);
    
    CGFloat minSize = MIN(innerRect.size.width, innerRect.size.height);
    if (innerRect.size.width != minSize) {
        innerRect.origin.x   += 50;
        innerRect.size.width = minSize;
    }
    else if (innerRect.size.height != minSize) {
        innerRect.origin.y   += (rect.size.height - minSize) / 2 - rect.size.height / 6;
        innerRect.size.height = minSize;
    }
    CGRect offsetRect = CGRectOffset(innerRect, 0, 15);
    
    self.innerViewRect = offsetRect;
    if([self.delegate respondsToSelector:@selector(scanViewLoadView:)])
    {
        [self.delegate scanViewLoadView:self.innerViewRect];
    }
    _overlay.path = [UIBezierPath bezierPathWithRect:offsetRect].CGPath;
    
    [self addOtherLay:offsetRect];
}

// 添加边框
- (void)addOtherLay:(CGRect)rect
{
    CAShapeLayer* layerTop   = [[CAShapeLayer alloc] init];
    layerTop.fillColor       = [UIColor blackColor].CGColor;
    layerTop.opacity         = 0.5;
    layerTop.path            = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, rect.origin.y)].CGPath;
    [self.layer addSublayer:layerTop];
    
    CAShapeLayer* layerLeft   = [[CAShapeLayer alloc] init];
    layerLeft.fillColor       = [UIColor blackColor].CGColor;
    layerLeft.opacity         = 0.5;
    layerLeft.path            = [UIBezierPath bezierPathWithRect:CGRectMake(0, rect.origin.y, 50, [UIScreen mainScreen].bounds.size.height)].CGPath;
    [self.layer addSublayer:layerLeft];
    
    CAShapeLayer* layerRight   = [[CAShapeLayer alloc] init];
    layerRight.fillColor       = [UIColor blackColor].CGColor;
    layerRight.opacity         = 0.5;
    layerRight.path            = [UIBezierPath bezierPathWithRect:CGRectMake([UIScreen mainScreen].bounds.size.width - 50, rect.origin.y, 50, [UIScreen mainScreen].bounds.size.height)].CGPath;
    [self.layer addSublayer:layerRight];
    
    CAShapeLayer* layerBottom   = [[CAShapeLayer alloc] init];
    layerBottom.fillColor       = [UIColor blackColor].CGColor;
    layerBottom.opacity         = 0.5;
    layerBottom.path            = [UIBezierPath bezierPathWithRect:CGRectMake(50, rect.origin.y + rect.size.height, [UIScreen mainScreen].bounds.size.width - 100, [UIScreen mainScreen].bounds.size.height - rect.origin.y - rect.size.height)].CGPath;
    [self.layer addSublayer:layerBottom];
    
}



@end
