//
//  AccountTextField.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/3.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountTextField : UIView
@property (nonatomic,strong)UITextField *textInput;

+ (AccountTextField *)accountTextFieldWithText:(NSString *) text andWithPlaceHolderText:(NSString *) text andWithTextStartX:(CGFloat) x;
@end
