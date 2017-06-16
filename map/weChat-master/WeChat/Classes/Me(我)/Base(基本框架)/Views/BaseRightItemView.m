//
//  BaseRightItemView.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/7.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "BaseRightItemView.h"

@interface BaseRightItemView ()
@property (nonatomic,assign)CGSize maxItemSize;
@end

@implementation BaseRightItemView

- (void)setViews:(NSArray *)views{
    _views = views;
    
    CGSize frameSize = CGSizeZero;
    CGFloat maxHeight = 0.0;
    
    //清除所有的view
    if(self.subviews.count){
        for(UIView *view in self.subviews){
            [view removeFromSuperview];
        }
    }
    
    for(UIView *view in views){
        [self addSubview:view];
        
        if(view.frame.size.height > self.frame.size.height){
            frameSize.width += view.frame.size.width;
            maxHeight = self.frame.size.height;
        }else{
            frameSize.width += view.frame.size.width;
        }
        
        //X间距
        if(self.padding&&!frameSize.height){
            frameSize.width += self.padding;
        }
        
        
        if(!maxHeight){
            if(frameSize.height < view.frame.size.height){
                frameSize.height = view.frame.size.height;
            }
        }else{
            frameSize.height = maxHeight;
        }
        
    }
    
    [self setRightItemViewFrame:frameSize];
    [self setNeedsDisplay];
}

//重新设置宽高
- (void)setRightItemViewFrame:(CGSize ) size{
    
    CGRect frame = self.frame;
    //元素最大宽度为模型中设置的框高
    self.maxItemSize = frame.size;
    
    frame.origin.x = (frame.origin.x + frame.size.width) - size.width;
    frame.origin.y = self.center.y - size.height*0.5;
    frame.size = size;
    [self setFrame:frame];
}

- (void)layoutSubviews{
    
    CGFloat currentX = 0.0;
    NSUInteger num = 0;
    NSUInteger i = 0;
    for(UIView *view in self.subviews){
        if(view.frame.size.height > self.maxItemSize.height){
            [view setFrame:CGRectMake(currentX,0,view.frame.size.width, self.maxItemSize.height)];
            
            currentX += view.frame.size.width;
            
        }else{
            [view setFrame:CGRectMake(currentX, (self.frame.size.height - view.frame.size.height)*0.5, view.frame.size.width, view.frame.size.height)];
            
            currentX += view.frame.size.width;
        }
        
        //X间距
        if(self.padding&&(self.subviews.count - 2) == num){
            currentX  += self.padding;
        }else{
            num++;
        }
    }
}

@end
