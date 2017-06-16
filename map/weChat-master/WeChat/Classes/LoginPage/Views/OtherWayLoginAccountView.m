//
//  OtherWayLoginAccountView.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/3.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "OtherWayLoginAccountView.h"
#import "AccountTextField.h"
#import "UIImage+ResizeImage.h"

@interface OtherWayLoginAccountView ()
@property (nonatomic,strong)UILabel *inputPhoneNumber;
@property (nonatomic,strong)UIImageView *headImage;
@property (nonatomic,strong)UIButton *loginButton;
@property (nonatomic,strong)UIButton *loginHelp;
@property (nonnull,copy)NSString *path;
@end

@implementation OtherWayLoginAccountView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setOtherWayLoginAccountViewFrame];
    }
    return self;
}

- (void)setOtherWayLoginAccountViewFrame{
    UILabel *inputPhoneNumber = [[UILabel alloc] init];
    [inputPhoneNumber setText:@"使用账号和密码登录"];
    [self addSubview:inputPhoneNumber];
    self.inputPhoneNumber = inputPhoneNumber;
    
    
    PersionModel *data = [PersionModel sharedPersionModel];
    NSString *User = [[NSUserDefaults standardUserDefaults] objectForKey:@"usr"];
    
    UIImageView *headImage = [[UIImageView alloc] init];
    //获取沙盒缓存图片
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    self.path = path;
    
    // 判断是否更新头像
    if(data.headIcon){
        [headImage setImage:data.headIcon];
    }else{
        //如果获取到登录过用户的图片，则显示出来
        NSString *imageFilePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",User]];
        DebugLog(@"路径：%@",imageFilePath);
        NSData *data = [NSData dataWithContentsOfFile:imageFilePath];
        
        if(data){
            UIImage * currentImage = [UIImage imageWithData:data];
            [headImage setImage:currentImage];
        }else{
            [headImage setImage:[UIImage imageNamed:@"DefaultProfileHead"]];
        }
    }
    
    
    [self addSubview:headImage];
    self.headImage = headImage;
    
    
    
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
    UIButton *loginHelp = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginHelp setTitle:@"登录遇到问题" forState:UIControlStateNormal];
    [loginHelp setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [loginHelp setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];

    [loginHelp addTarget:self action:@selector(loginWithHelp:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:loginHelp];
    self.loginHelp = loginHelp;
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
      [inputPhoneNumber setFont:[UIFont systemFontOfSize:40.0]];
        
        AccountTextField *accountInput = [AccountTextField accountTextFieldWithText:@"账号" andWithPlaceHolderText:@"微信号／邮箱地址／QQ号" andWithTextStartX:100];
        [accountInput.textInput addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:accountInput];
        self.accountInput = accountInput;
        
        
        AccountTextField *passwordInput = [AccountTextField accountTextFieldWithText:@"密码" andWithPlaceHolderText:@"请填写密码" andWithTextStartX:100];
        [passwordInput.textInput addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
        [passwordInput.textInput setSecureTextEntry:YES];
        [self addSubview:passwordInput];
        self.passwordInput = passwordInput;
        
         [loginButton.titleLabel setFont:[UIFont systemFontOfSize:30.0]];
         [loginHelp.titleLabel setFont:[UIFont systemFontOfSize:20.0]];
    }else{
        [inputPhoneNumber setFont:[UIFont systemFontOfSize:20.0]];
        
        AccountTextField *accountInput = [AccountTextField accountTextFieldWithText:@"账号" andWithPlaceHolderText:@"微信号／邮箱地址／QQ号" andWithTextStartX:70];
        [accountInput.textInput addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
        NSString *User = [[NSUserDefaults standardUserDefaults] objectForKey:@"usr"];
        [accountInput.textInput setText:User];
        
        [self addSubview:accountInput];
        self.accountInput = accountInput;
        
        
        AccountTextField *passwordInput = [AccountTextField accountTextFieldWithText:@"密码" andWithPlaceHolderText:@"请填写密码" andWithTextStartX:70];
        [passwordInput.textInput addTarget:self action:@selector(textFieldDidChange)
                          forControlEvents:UIControlEventEditingChanged];
        NSString *Password = [[NSUserDefaults standardUserDefaults] objectForKey:@"pwd"];
        [passwordInput.textInput setText:Password];
        [passwordInput.textInput setSecureTextEntry:YES];
        [self addSubview:passwordInput];
        self.passwordInput = passwordInput;
        
        [loginHelp.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        [self.loginButton setEnabled:self.accountInput.textInput.text.length &&self.passwordInput.textInput.text.length];
    }
    

}
- (void)layoutSubviews{
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        [self.inputPhoneNumber setFrame:CGRectMake(230, 80, 600, 60)];
        [self.headImage setFrame:CGRectMake((self.bounds.size.width - 110)*0.5, 150, 132, 132)];
        [self.accountInput setFrame:CGRectMake(180, 300,self.bounds.size.width - 320, 80)];
        [self.passwordInput setFrame:CGRectMake(180, 379, self.bounds.size.width - 320, 80)];
        [self.loginButton setFrame:CGRectMake(180, 480, self.bounds.size.width - 320, 80)];
        [self.loginHelp setFrame:CGRectMake(180, 560,self.bounds.size.width - 320, 80)];
    }else{
        [self.inputPhoneNumber setFrame:CGRectMake(70, 30, 300, 30)];
        [self.headImage setFrame:CGRectMake((self.bounds.size.width - 60)*0.5, 70, 66, 66)];
        [self.accountInput setFrame:CGRectMake(60, 160,self.bounds.size.width - 120, 40)];
        [self.passwordInput setFrame:CGRectMake(60, 199, self.bounds.size.width - 120, 40)];
        [self.loginButton setFrame:CGRectMake(60, 250, self.bounds.size.width - 120, 40)];
        [self.loginHelp setFrame:CGRectMake(60, 290,self.bounds.size.width - 120, 40)];
    }
}


- (void)textFieldDidChange{
    [self.loginButton setEnabled:self.accountInput.textInput.text.length &&self.passwordInput.textInput.text.length];
    
    //如果获取到登录过用户的图片，则显示出来
    NSString *imageFilePath = [self.path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",self.accountInput.textInput.text]];
    DebugLog(@"路径：%@",imageFilePath);
    NSData *data = [NSData dataWithContentsOfFile:imageFilePath];
    
    if(data){
        UIImage * currentImage = [UIImage imageWithData:data];
        [self.headImage setImage:currentImage];
    }else{
        [self.headImage setImage:[UIImage imageNamed:@"DefaultProfileHead"]];
    }
}

- (void)loginAccountHost:(UIButton *) button{
    [self endEditing:YES];
    
    if([self.delegate respondsToSelector:@selector(otherWayLoginAccountViewDidLogin:)]){
        [self.delegate otherWayLoginAccountViewDidLogin:self];
    }
}

- (void)loginWithHelp:(UIButton *) button{
    if([self.delegate respondsToSelector:@selector(otherWayLoginAccountViewDidLoginHelp:)]){
        [self.delegate otherWayLoginAccountViewDidLoginHelp:self];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

@end
