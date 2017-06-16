//
//  NSString+FontFrame.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/11.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "NSString+FontFrame.h"

@implementation NSString (FontFrame)

//字体无宽高限制的区域大小
+ (CGSize )stringSizeFreeWithText:(NSString *)text andFont:(UIFont *) font {
    
    return [text  boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}

//字体限制宽度的后的区域大小
+ (CGSize )stringSizeWithText:(NSString *)text andFont:(UIFont *) font andLimitWidth:(CGFloat) width{

    return [text  boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}

//字体限制高度的后的区域大小
+ (CGSize )stringSizeWithText:(NSString *)text andFont:(UIFont *) font andLimitHeight:(CGFloat) height{
    
    return [text  boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}

#pragma mark//Unicode转汉字   \u5f20\u4e09 → 张三
+ (NSString *)replaceUnicode:(NSString *)unicodeStr {
    //张三  \u5f20\u4e09
    
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    
    //  NSLog(@"Output = %@", returnStr);
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}

#pragma mark//汉字转 Unicode   张三 →  \u5f20\u4e09
+ (NSString *) utf8ToUnicode:(NSString *)string{
    
    NSUInteger length = [string length];
    NSMutableString *s = [NSMutableString stringWithCapacity:0];
    for (int i = 0;i < length; i++){
        unichar _char = [string characterAtIndex:i];
        //判断是否为英文和数字
        if (_char <= '9' && _char >='0'){
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i,1)]];
        }else if(_char >='a' && _char <= 'z'){
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i,1)]];
        }else if(_char >='A' && _char <= 'Z')
        {
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i,1)]];
        }else{
            [s appendFormat:@"\\u%x",[string characterAtIndex:i]];
        }
    }
    return s;
}
@end
