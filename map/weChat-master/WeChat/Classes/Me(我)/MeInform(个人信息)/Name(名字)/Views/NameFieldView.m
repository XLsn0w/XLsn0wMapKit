//
//  NameFieldView.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/10.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "NameFieldView.h"


@implementation NameFieldView

-(UITextField *)name{
    if(!_name){
        _name = [[UITextField alloc] init];
        [_name setFrame:CGRectMake(0, 10, self.frame.size.width, 40)];
        [_name setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_name setBackgroundColor:[UIColor whiteColor]];
//        [_name setBorderStyle: UITextBorderStyleLine];
        
//        _name.layer.borderColor = [UIColor grayColor].CGColor;
//        
//        _name.layer.borderWidth = 1.0f;
        [self addSubview:_name];
    }
    
    return _name;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
