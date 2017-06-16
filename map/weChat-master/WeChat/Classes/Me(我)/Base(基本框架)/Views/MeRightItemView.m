//
//  MeRightItemView.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/7.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "MeRightItemView.h"

@interface MeRightItemView ()
@property (nonatomic,assign)CGSize maxItemSize;
@end

@implementation MeRightItemView

- (void)setPadding:(CGFloat)padding{
    _padding = padding;
}

- (void)setImages:(NSArray *)Images{
    _Images = Images;
    
    
    CGSize frameSize = CGSizeZero;
    CGFloat maxHeight = 0.0;
    
    //清除所有的view
    if(self.subviews.count){
        for(UIImageView *view in self.subviews){
            [view removeFromSuperview];
        }
    }
    
    for(UIImage *image in Images){
        UIImageView *view = [[UIImageView alloc] initWithImage:image];
        [self addSubview:view];
    
        
        if(image.size.height * image.scale > self.frame.size.height){
            frameSize.width += self.frame.size.width;
            maxHeight = self.frame.size.height;

        }else{
            frameSize.width += image.size.width * image.scale;
        }
      
        //X间距
        if(self.padding&&frameSize.height){
            frameSize.width += self.padding;
        }       
    
        if(!maxHeight){
            //像素宽度scale = 2.0 表示是 @2x 图
            if(frameSize.height < image.size.height * image.scale){
                frameSize.height = image.size.height * image.scale;
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
    if(self.subviews.count == self.Images.count){
        for(NSInteger i = 0; i < self.subviews.count;i++){
            UIImageView *imageView = (UIImageView *)self.subviews[i];
            UIImage *image = (UIImage *)self.Images[i];
        
            if(image.size.height* image.scale > self.maxItemSize.height ||
               image.size.width* image.scale > self.maxItemSize.width){
            
                [imageView setFrame:CGRectMake(currentX,0,self.maxItemSize.width, self.maxItemSize.height)];
                
                currentX += self.maxItemSize.width;
        
                
            }else{
                
                [imageView setFrame:CGRectMake(currentX, (self.frame.size.height - image.size.height)*0.5, image.size.width, image.size.height)];
                
                currentX += image.size.width * image.scale;
            }
            
            //X间距
            if(self.padding){
                currentX  += self.padding;
            }
        }
    }
}

@end
