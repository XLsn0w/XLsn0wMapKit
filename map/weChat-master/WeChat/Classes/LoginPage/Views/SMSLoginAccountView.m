//
//  SMSLoginAccountView.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/3.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "SMSLoginAccountView.h"
#import "PhoneNumberTextField.h"
#import "UIImage+ResizeImage.h"

@interface SMSLoginAccountView ()
@property (nonatomic,strong)UILabel *inputPhoneNumber;
@property (nonatomic,strong)UIButton *country;
@property (nonatomic,strong) PhoneNumberTextField *phoneInput;
@property (nonatomic,strong)UIButton *nextButton;
@end

@implementation SMSLoginAccountView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setSMSLoginAccountViewFrame];
    }
    return self;
}

- (void)setSMSLoginAccountViewFrame{
    UILabel *inputPhoneNumber = [[UILabel alloc] init];
    [inputPhoneNumber setText:@"通过短信验证码登录"];
  
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
    
    //注册按钮
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setBackgroundImage:[UIImage resizeWithImageName:@"fts_green_btn"] forState:UIControlStateNormal];
    [nextButton setBackgroundImage:[UIImage resizeWithImageName:@"fts_green_btn_HL"] forState:UIControlStateHighlighted];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    
    [nextButton addTarget:self action:@selector(SMSLoginAccountHost:) forControlEvents:UIControlEventTouchUpInside];
    
    [nextButton setEnabled:NO];
    
    [self addSubview:nextButton];
    self.nextButton = nextButton;
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        [inputPhoneNumber setFont:[UIFont systemFontOfSize:40.0]];
        [country setImage:[UIImage scaleWithImageName:@"CellArrow" toScale:1.8] forState:UIControlStateNormal];
        [country setImageEdgeInsets:UIEdgeInsetsMake(0, 380, 0, 0)];
        
        [country.titleLabel setFont:[UIFont systemFontOfSize:30.0]];
        [nextButton.titleLabel setFont:[UIFont systemFontOfSize:30.0]];
    }else{
        [inputPhoneNumber setFont:[UIFont systemFontOfSize:20.0]];
        [country setImage:[UIImage imageNamed:@"CellArrow"] forState:UIControlStateNormal];
        [country setImageEdgeInsets:UIEdgeInsetsMake(0, 190, 0, 0)];
    }
    
}

- (void)layoutSubviews{
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        [self.inputPhoneNumber setFrame:CGRectMake(200, 80, 600, 60)];
        [self.country setFrame:CGRectMake(160, 200, 400, 60)];
        [self.phoneInput setFrame:CGRectMake(180, 280, self.bounds.size.width - 320, 80)];
        [self.nextButton setFrame:CGRectMake(180, 380,self.bounds.size.width - 320, 80)];
    }else{
        [self.inputPhoneNumber setFrame:CGRectMake(70, 30, 200, 40)];
        [self.country setFrame:CGRectMake(60, 80, 200, 30)];
        [self.phoneInput setFrame:CGRectMake(60, 120, self.bounds.size.width - 120, 40)];
        [self.nextButton setFrame:CGRectMake(60, 170,self.bounds.size.width - 120, 40)];
    }
}

- (void)textFieldDidChange{
    [self.nextButton setEnabled:self.phoneInput.phoneNumber.text.length&&self.phoneInput.phoneArea.text.length];
}

- (void)selectedCountry:(UIButton *) button{
    if([self.delegate respondsToSelector:@selector(SMSLoginAccountViewDidCountrySelect:)]){
        [self.delegate SMSLoginAccountViewDidCountrySelect:self];
    }
}

- (void)SMSLoginAccountHost:(UIButton *) button{
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

@end
