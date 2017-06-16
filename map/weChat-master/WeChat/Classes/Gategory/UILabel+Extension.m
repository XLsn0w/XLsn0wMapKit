//
//  UILabel+Extension.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/15.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)
- (void)sizeLevelWidth: (CGFloat) width{
    CGRect textFrame = CGRectZero;
    if(!self.width){
        textFrame = [self.text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil];
    }else{
        textFrame = [self.text boundingRectWithSize:CGSizeMake(self.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil];
        //再次使用原来设置的参数
        textFrame.size.width = self.width;
    }
    
    self.size = textFrame.size;
}

- (void)sizeLevelHeight: (CGFloat) height{
    
    CGRect textFrame = [self.text boundingRectWithSize:CGSizeMake(MAXFLOAT,height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil];
    
    self.size = textFrame.size;
}

@end
