//
//  SplitLineView.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/3.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "SplitLineView.h"

@implementation SplitLineView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setSplitLineColor:[UIColor colorWithRed:227/255.0 green:227/255.0 blue:231/255.0 alpha:1.0]];
    }
    return self;
}



- (void)setSplitLineHeight:(CGFloat) height{
    CGRect frame = self.frame;
    
    frame.size.height = height;
    
    self.frame = frame;
     [self setNeedsDisplay];
}

- (void)setSplitLineWidth:(CGFloat) width{
    CGRect frame = self.frame;
    
    frame.size.width = width;
    
    self.frame = frame;
    [self setNeedsDisplay];
}

- (void)setSplitLineColor:(UIColor *) color{
    self.backgroundColor = color;
}

@end
