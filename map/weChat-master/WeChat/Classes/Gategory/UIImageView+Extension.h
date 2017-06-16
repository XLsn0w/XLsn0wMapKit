//
//  UIImageView+Extension.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/11.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Extension)


- (void)setBorderWidth:(CGFloat) width withColor:(UIColor *) color;

- (void)clipCircleImagewithBorderWidth:(CGFloat) width
                            andWithColor:(UIColor *)color;

- (void)clipCircleImageWithImageName:(NSString *) imageName withBorderWidth:(CGFloat) width;

+ (UIImageView *)clipCircleImageWithImageName:(NSString *) imageName withClipWidth:(CGFloat) imageWidth AndWithBorderWidth:(CGFloat) width andWithColor:(UIColor *) color;
+ (UIImageView *)clipCircleImageView:(UIImage *)image withClipWidth:(CGFloat) imageWidth andWithBorderWidth:(CGFloat) width andWithColor:(UIColor *) color;
@end
