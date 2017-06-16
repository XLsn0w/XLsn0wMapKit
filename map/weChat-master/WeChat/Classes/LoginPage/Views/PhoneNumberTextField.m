//
//  PhoneNumberTextField.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/3.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "PhoneNumberTextField.h"
#import "SplitLineView.h"

@interface PhoneNumberTextField ()
@property (nonatomic,strong)SplitLineView *upLine;
@property (nonatomic,strong)SplitLineView *downLine;
@property (nonatomic,strong)SplitLineView *midleLine;
@property (nonatomic,strong)UILabel *phoneAreaHeader;
@end

@implementation PhoneNumberTextField

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setPhoneNumberTextFieldView];
    }
    return self;
}

- (void)setPhoneNumberTextFieldView{
    NSLog(@"%f",self.bounds.size.width);
    SplitLineView *upLine = [[SplitLineView alloc] init];
    [self addSubview:upLine];
    self.upLine = upLine;
    
    SplitLineView *downLine = [[SplitLineView alloc] init];
    [self addSubview:downLine];
    self.downLine = downLine;
    
    SplitLineView *midleLine = [[SplitLineView alloc] init];
    [self addSubview:midleLine];
    self.midleLine = midleLine;
    
    UILabel *phoneAreaHeader = [[UILabel alloc] init];
    [phoneAreaHeader setText:@"+"];
    [phoneAreaHeader setTextColor:[UIColor blackColor]];
    [self addSubview:phoneAreaHeader];
    
    UITextField *phoneArea = [[UITextField alloc] init];
    [phoneArea setText:@"+86"];
    [phoneArea setKeyboardType:UIKeyboardTypePhonePad];
    
    [phoneArea setTintColor:[UIColor greenColor]];
    [self addSubview:phoneArea];
    self.phoneArea = phoneArea;
    
    UITextField *phoneNumber = [[UITextField alloc] init];
    [phoneNumber setPlaceholder:@"请填写手机号码"];
    [phoneNumber setKeyboardType:UIKeyboardTypePhonePad];
   
    [phoneNumber setTintColor:[UIColor greenColor]];
    [self addSubview:phoneNumber];
    self.phoneNumber = phoneNumber;
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        [phoneArea setFont:[UIFont systemFontOfSize:30.0]];
        [phoneNumber setFont:[UIFont systemFontOfSize:30.0]];
    }else{
        [phoneArea setFont:[UIFont systemFontOfSize:16.0]];
        [phoneNumber setFont:[UIFont systemFontOfSize:16.0]];
    }
    
}

- (void)layoutSubviews{
    
     if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        [self.upLine setFrame:CGRectMake(0, 0, self.bounds.size.width, 1)];
        
        [self.downLine setFrame:CGRectMake(0, self.bounds.size.height - 1, self.bounds.size.width, 1)];
        [self.midleLine setFrame:CGRectMake(150, 0, 1, self.bounds.size.height)];
        
        [self.phoneAreaHeader setFrame:CGRectMake(0, 0, 20, self.bounds.size.height)];
        [self.phoneArea setFrame:CGRectMake(20, 0, 150, self.bounds.size.height)];
        [self.phoneNumber setFrame:CGRectMake(160, 0, self.bounds.size.width - 160, self.bounds.size.height)];
     }else{
         [self.upLine setFrame:CGRectMake(0, 0, self.bounds.size.width, 1)];
         
         [self.downLine setFrame:CGRectMake(0, self.bounds.size.height - 1, self.bounds.size.width, 1)];
         [self.midleLine setFrame:CGRectMake(60, 0, 1, self.bounds.size.height)];
         
         [self.phoneAreaHeader setFrame:CGRectMake(0, 0, 10, self.bounds.size.height)];
         [self.phoneArea setFrame:CGRectMake(10, 0, 60, self.bounds.size.height)];
         [self.phoneNumber setFrame:CGRectMake(70, 0, self.bounds.size.width - 70, self.bounds.size.height)];
     }
}
@end
