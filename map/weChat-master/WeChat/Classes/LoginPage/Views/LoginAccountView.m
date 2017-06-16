//
//  LoginAccountView.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/3.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "LoginAccountView.h"
#import "PhoneNumberTextField.h"
#import "AccountTextField.h"
#import "UIImage+ResizeImage.h"

@interface LoginAccountView () 
@property (nonatomic,strong)UILabel *inputPhoneNumber;
@property (nonatomic,strong)UIButton *country;
@property (nonatomic,strong) PhoneNumberTextField *phoneInput;
@property (nonatomic,strong)AccountTextField *passwordInput;
@property (nonatomic,strong)UIButton *loginButton;
@property (nonatomic,strong)UIButton *SMSLoginButton;

@end

@implementation LoginAccountView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setLoginAccountViewFrame];
    }
    return self;
}

- (void)setLoginAccountViewFrame{
    UILabel *inputPhoneNumber = [[UILabel alloc] init];
    [inputPhoneNumber setText:@"使用手机号登录"];
    [self addSubview:inputPhoneNumber];
    self.inputPhoneNumber = inputPhoneNumber;
    
    UIButton *country = [UIButton buttonWithType:UIButtonTypeCustom];
    [country setTitle:[NSString stringWithFormat:@"国家／地区    %@",@"中国"] forState:UIControlStateNormal];
  
    [country setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [country addTarget:self action:@selector(selectedCountry:) forControlEvents:UIControlEventTouchUpInside];
    
 
    [self addSubview:country];
    self.country = country;
    
    PhoneNumberTextField *phoneInput = [[PhoneNumberTextField alloc] init];
    [phoneInput.phoneNumber addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [phoneInput.phoneArea addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    
    [self addSubview:phoneInput];
    self.phoneInput = phoneInput;
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        AccountTextField *passwordInput = [AccountTextField accountTextFieldWithText:@"密码" andWithPlaceHolderText:@"请填写密码" andWithTextStartX:160];
        
        [passwordInput.textInput addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
        [passwordInput.textInput setSecureTextEntry:YES];
        [self addSubview:passwordInput];
        self.passwordInput = passwordInput;
        
    }else{
         AccountTextField *passwordInput = [AccountTextField accountTextFieldWithText:@"密码" andWithPlaceHolderText:@"请填写密码" andWithTextStartX:70];
        
        [passwordInput.textInput addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
        [passwordInput.textInput setSecureTextEntry:YES];
        [self addSubview:passwordInput];
        self.passwordInput = passwordInput;
    }
  
    
    //登录按钮
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginButton setBackgroundImage:[UIImage resizeWithImageName:@"fts_green_btn"] forState:UIControlStateNormal];
    [loginButton setBackgroundImage:[UIImage resizeWithImageName:@"fts_green_btn_HL"] forState:UIControlStateHighlighted];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
  
    [loginButton addTarget:self action:@selector(loginAccountHost:) forControlEvents:UIControlEventTouchUpInside];
    
    [loginButton setEnabled:NO];
    
    [self addSubview:loginButton];
    self.loginButton = loginButton;
    
    
    //短信验证按钮
    UIButton *SMSLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [SMSLoginButton setTitle:@"通过短信验证码登录" forState:UIControlStateNormal];
    [SMSLoginButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [SMSLoginButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
   
     [SMSLoginButton addTarget:self action:@selector(SMSLoginAccountHost:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:SMSLoginButton];
    self.SMSLoginButton = SMSLoginButton;
    
     if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
          [inputPhoneNumber setFont:[UIFont systemFontOfSize:40.0]];
          [country setImage:[UIImage scaleWithImageName:@"CellArrow" toScale:1.8] forState:UIControlStateNormal];
           [loginButton.titleLabel setFont:[UIFont systemFontOfSize:30.0]];
            [country.titleLabel setFont:[UIFont systemFontOfSize:30.0]];
           [SMSLoginButton.titleLabel setFont:[UIFont systemFontOfSize:20.0]];
     }else{
         [inputPhoneNumber setFont:[UIFont systemFontOfSize:20.0]];
         [country setImage:[UIImage imageNamed: @"CellArrow"] forState:UIControlStateNormal];
         [SMSLoginButton.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
     }
    
    
}

- (void)layoutSubviews{
    UIDeviceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        //翻转为竖屏时
        if (interfaceOrientation == UIDeviceOrientationPortrait || interfaceOrientation ==UIDeviceOrientationPortraitUpsideDown){
            [self.inputPhoneNumber setFrame:CGRectMake(250, 80, 600, 60)];
            [self.country setFrame:CGRectMake(160, 200, 400, 60)];
            [self.country setImageEdgeInsets:UIEdgeInsetsMake(0, 380, 0, 0)];
            [self.phoneInput setFrame:CGRectMake(180, 280, self.bounds.size.width - 320, 80)];
            [self.passwordInput setFrame:CGRectMake(180, 359, self.bounds.size.width - 320, 80)];
            [self.loginButton setFrame:CGRectMake(180, 460,self.bounds.size.width - 320, 80)];
            [self.SMSLoginButton setFrame:CGRectMake(180, 540, self.bounds.size.width - 320, 80)];
            
        }else if (interfaceOrientation==UIDeviceOrientationLandscapeLeft || interfaceOrientation ==UIDeviceOrientationLandscapeRight) {
            [self.inputPhoneNumber setFrame:CGRectMake(350, 40, 600, 60)];
            [self.country setFrame:CGRectMake(40, 160, 800, 60)];
            [self.country setImageEdgeInsets:UIEdgeInsetsMake(0, 700, 0, 0)];
            [self.phoneInput setFrame:CGRectMake(180, 240, self.bounds.size.width - 320, 80)];
            [self.passwordInput setFrame:CGRectMake(180, 319, self.bounds.size.width - 320, 80)];
            [self.loginButton setFrame:CGRectMake(180, 420,self.bounds.size.width - 320, 80)];
            [self.SMSLoginButton setFrame:CGRectMake(180, 500, self.bounds.size.width - 320, 80)];
        }
    }else{
        [self.inputPhoneNumber setFrame:CGRectMake(90, 30, 300, 60)];
        [self.country setFrame:CGRectMake(60, 100, 200, 30)];
        [self.country setImageEdgeInsets:UIEdgeInsetsMake(0, 190, 0, 0)];
        [self.phoneInput setFrame:CGRectMake(60, 140, self.bounds.size.width - 120, 40)];
        [self.passwordInput setFrame:CGRectMake(60, 179, self.bounds.size.width - 120, 40)];
        [self.loginButton setFrame:CGRectMake(60, 230,self.bounds.size.width - 120, 40)];
        [self.SMSLoginButton setFrame:CGRectMake(60, 270, self.bounds.size.width - 120, 40)];
    }
   
}

- (void)textFieldDidChange{
    [self.loginButton setEnabled:self.phoneInput.phoneNumber.text.length&&self.phoneInput.phoneArea.text.length &&self.passwordInput.textInput.text.length];
}

- (void)selectedCountry:(UIButton *) button{
    if([self.delegate respondsToSelector:@selector(LoginAccountViewDidCountrySelect:)]){
        [self.delegate LoginAccountViewDidCountrySelect:self];
    }
}

- (void)loginAccountHost:(UIButton *) button{
    
}

- (void)SMSLoginAccountHost:(UIButton *) button{
    if([self.delegate respondsToSelector:@selector(LoginAccountViewDidSMSLogin:)]){
        [self.delegate LoginAccountViewDidSMSLogin:self];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}
@end
