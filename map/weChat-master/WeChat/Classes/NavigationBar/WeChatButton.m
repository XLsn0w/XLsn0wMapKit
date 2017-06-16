//
//  TarBarButton.m
//  天天福彩
//
//  Created by 李莎鑫 on 2016/12/8.
//  Copyright © 2016年 李莎鑫. All rights reserved.
//

#import "WeChatButton.h"

@interface WeChatButton ()
@property (nonatomic,assign)CGFloat scaleWidth;
@property (nonatomic,assign)CGFloat scaleHeight;
@property (nonatomic,assign)CGFloat scale;
@property (nonatomic,assign)CGPoint pos;
@property (nonatomic,assign)CGRect rect;


@end

@implementation WeChatButton

- (void)setImageViewscaleSize:(CGFloat)scale newPostion:(CGPoint) postion withBackGroudColor:(UIColor *)color{
    if(scale > 1){
        return;
    }
    _scale = scale;
    _pos = postion;
    [self setBackgroundColor:color];
    [self setNeedsDisplay];
}

- (void)setImageViewsWithScaleWidth:(CGFloat) scaleWidth andScaleHeight:(CGFloat)scaleHeight newPostion:(CGPoint) postion withBackGroudColor:(UIColor *)color{
    if(_scaleWidth > 1 || _scaleHeight > 1){
        return;
    }
    _scaleWidth = scaleWidth;
    _scaleHeight = scaleHeight;
    
    _pos = postion;
    [self setBackgroundColor:color];
    [self setNeedsDisplay];
}


- (void)setTitleViewRect:(CGRect) rect {
      _rect = rect;
      [self setNeedsDisplay];
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    //如果设置了值
    
    
    if(_scale){
        CGFloat width = contentRect.size.width*_scale;
        CGFloat height = contentRect.size.height*_scale;
        
        if(_pos.x || _pos.y)
        {
            return CGRectMake(_pos.x,_pos.y, width, height);
        }
        
        return CGRectMake((contentRect.size.width - width)*0.5,(contentRect.size.height - height)*0.5, width, height);
    }else if(_scaleWidth || _scaleWidth){
        
        CGFloat width = 0;
        CGFloat height = 0;
        
        if(_scaleWidth){
            width = contentRect.size.width*_scaleWidth;
        }else{
            width = contentRect.size.width;
        }
        if(_scaleHeight){
            height = contentRect.size.height*_scaleHeight;
        }else{
            height = contentRect.size.height;
        }
        
        if(_pos.x || _pos.y)
        {
            return CGRectMake(_pos.x,_pos.y, width, height);
        }
        
        return CGRectMake((contentRect.size.width - width)*0.5,(contentRect.size.height - height)*0.5, width, height);
    }
    
    return contentRect;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect;{
    if(_rect.origin.x|| _rect.origin.y ||
       _rect.size.width || _rect.size.height){
        return _rect;
    }
    return contentRect;
}

- (void)setHighlighted:(BOOL)highlighted{
    
    //如果需要取消高亮状态可以注释该行代码
    [super setHighlighted:highlighted];
}

@end
