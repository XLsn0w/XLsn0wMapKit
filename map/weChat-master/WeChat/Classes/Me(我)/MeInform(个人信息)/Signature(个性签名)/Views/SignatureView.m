//
//  SignatureView.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/23.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "SignatureView.h"

@implementation SignatureView

-(UITextField *)signature{
    if(!_signature){
        _signature = [[UITextField alloc] init];
        [_signature setFrame:CGRectMake(0, 10, self.frame.size.width, 160)];
        [_signature setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_signature setBackgroundColor:[UIColor whiteColor]];
    
        //        [_name setBorderStyle: UITextBorderStyleLine];
        
        //        _name.layer.borderColor = [UIColor grayColor].CGColor;
        //
        //        _name.layer.borderWidth = 1.0f;
        [self addSubview:_signature];
    }
    
    return _signature;
}

@end
