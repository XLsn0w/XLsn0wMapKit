//
//  RegisterAccountView.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/3.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "RegisterAccountView.h"
#import "PhoneNumberTextField.h"
#import "UIImage+ResizeImage.h"


@interface RegisterAccountView ()
@property (nonatomic,strong)UILabel *inputPhoneNumber;
@property (nonatomic,strong)UIButton *country;
@property (nonatomic,strong)UIButton *registerButton;
@end

@implementation RegisterAccountView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setRegisterAccountViewFrame];
    }
    return self;
}

- (void)setRegisterAccountViewFrame{
    UILabel *inputPhoneNumber = [[UILabel alloc] init];
    [inputPhoneNumber setText:@"请输入你的手机号"];

    [self addSubview:inputPhoneNumber];
    self.inputPhoneNumber = inputPhoneNumber;
    
    UIButton *country = [UIButton buttonWithType:UIButtonTypeCustom];
    [country setTitle:[NSString stringWithFormat:@"国家／地区    %@",@"中国"] forState:UIControlStateNormal];
    [country.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [country setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [country addTarget:self action:@selector(selectedCountry:) forControlEvents:UIControlEventTouchUpInside];
    
   
    [self addSubview:country];
    self.country = country;
    
    PhoneNumberTextField *phoneInput = [[PhoneNumberTextField alloc] init];
    [phoneInput.phoneNumber addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [phoneInput.phoneArea addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    
    [self addSubview:phoneInput];
    self.phoneInput = phoneInput;
    
    //注册按钮
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerButton setBackgroundImage:[UIImage resizeWithImageName:@"fts_green_btn"] forState:UIControlStateNormal];
    [registerButton setBackgroundImage:[UIImage resizeWithImageName:@"fts_green_btn_HL"] forState:UIControlStateHighlighted];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    
    [registerButton addTarget:self action:@selector(registerAccountHost:) forControlEvents:UIControlEventTouchUpInside];

    [registerButton setEnabled:NO];
    
    [self addSubview:registerButton];
    self.registerButton = registerButton;
    
     if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        [inputPhoneNumber setFont:[UIFont systemFontOfSize:40.0]];
        [country setImage:[UIImage scaleWithImageName:@"CellArrow" toScale:1.8] forState:UIControlStateNormal];
        [country setImageEdgeInsets:UIEdgeInsetsMake(0, 380, 0, 0)];
         
        [country.titleLabel setFont:[UIFont systemFontOfSize:30.0]];
         
        [registerButton.titleLabel setFont:[UIFont systemFontOfSize:30.0]];
     }else{
         [inputPhoneNumber setFont:[UIFont systemFontOfSize:20.0]];
         [country setImage:[UIImage imageNamed: @"CellArrow"] forState:UIControlStateNormal];
         [country setImageEdgeInsets:UIEdgeInsetsMake(0, 180, 0, 0)];
         
         [country.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
     }
    
}

- (void)layoutSubviews{
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        [self.inputPhoneNumber setFrame:CGRectMake(200, 80, 600, 60)];
        [self.country setFrame:CGRectMake(160, 200, 400, 60)];
        [self.phoneInput setFrame:CGRectMake(180, 280, self.bounds.size.width - 320, 80)];
        [self.registerButton setFrame:CGRectMake(180, 380,self.bounds.size.width - 320, 80)];
    }else{
        [self.inputPhoneNumber setFrame:CGRectMake(80, 30, 300, 40)];
        [self.country setFrame:CGRectMake(40, 120, 240, 40)];
        [self.phoneInput setFrame:CGRectMake(40, 160, self.bounds.size.width - 80, 40)];
        [self.registerButton setFrame:CGRectMake(40, 210,self.bounds.size.width - 80, 50)];
    }
}

- (void)textFieldDidChange{
    [self.registerButton setEnabled:self.phoneInput.phoneNumber.text.length&&self.phoneInput.phoneArea.text.length];
}

- (void)selectedCountry:(UIButton *) button{
    if([self.delegate respondsToSelector:@selector(registerAccountViewDidCountrySelect:)]){
        [self.delegate registerAccountViewDidCountrySelect:self];
    }
}

- (void)registerAccountHost:(UIButton *) button{
    if([self.delegate respondsToSelector:@selector(registerAccountViewDidRegister:)]){
        [self.delegate registerAccountViewDidRegister:self];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}
@end
