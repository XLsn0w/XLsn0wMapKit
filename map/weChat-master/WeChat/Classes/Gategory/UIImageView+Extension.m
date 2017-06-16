//
//  UIImageView+Extension.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/11.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "UIImageView+Extension.h"

@implementation UIImageView (Extension)

- (void)setBorderWidth:(CGFloat) width withColor:(UIColor *) color{
    [self.layer setBorderColor:color.CGColor];
    [self.layer setBorderWidth:width];
}

- (void)clipCircleImagewithBorderWidth:(CGFloat) width
                        andWithColor:(UIColor *)color{
    
    [self.layer setCornerRadius:self.width*0.5];
    [self.layer setMasksToBounds:YES];
    [self.layer setBorderColor:color.CGColor];
    [self.layer setBorderWidth:width];
}
//该方法适用于设置了imageview的宽度后裁剪
- (void)clipCircleImageWithImageName:(NSString *) imageName withBorderWidth:(CGFloat) width
                        andWithColor:(UIColor *)color{
    [self setImage:[UIImage imageNamed:imageName]];
    
    [self.layer setCornerRadius:self.width*0.5];
    [self.layer setMasksToBounds:YES];
    [self.layer setBorderColor:color.CGColor];
    [self.layer setBorderWidth:width];
}

//该方法在创建图片前必须设置裁剪宽度
+ (UIImageView *)clipCircleImageWithImageName:(NSString *) imageName withClipWidth:(CGFloat) imageWidth AndWithBorderWidth:(CGFloat) width andWithColor:(UIColor *) color{
    return [self clipCircleImageView:[UIImage imageNamed:imageName] withClipWidth:imageWidth andWithBorderWidth:width andWithColor:color];
}

+ (UIImageView *)clipCircleImageView:(UIImage *)image withClipWidth:(CGFloat) imageWidth andWithBorderWidth:(CGFloat) width andWithColor:(UIColor *) color{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [imageView.layer setCornerRadius:imageWidth*0.5];
    [imageView.layer setMasksToBounds:YES];
    [imageView.layer setBorderColor:color.CGColor];
    [imageView.layer setBorderWidth:width];
    
    return imageView;
}

@end
