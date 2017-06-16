//
//  NSString+FontFrame.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/11.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FontFrame)
+ (CGSize )stringSizeFreeWithText:(NSString *)text andFont:(UIFont *) font;
+ (CGSize )stringSizeWithText:(NSString *)text andFont:(UIFont *) font andLimitWidth:(CGFloat) width;
+ (CGSize )stringSizeWithText:(NSString *)text andFont:(UIFont *) font andLimitHeight:(CGFloat) height;

+ (NSString *)replaceUnicode:(NSString *)unicodeStr ;
+ (NSString *) utf8ToUnicode:(NSString *)string;
@end
