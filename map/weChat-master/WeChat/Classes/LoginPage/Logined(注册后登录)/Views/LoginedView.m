//
//  LoginedView.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/20.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "LoginedView.h"
#import "AccountTextField.h"
#import "GlobalConfig.h"

@interface LoginedView ()
@property (nonatomic,weak)UIImageView *headImage;
@property (nonatomic,weak)UILabel *account;
@property (nonatomic,weak)UIButton *loginButton;
@property (nonatomic,weak)UIButton *loginHelp;
@property (nonatomic,weak)UIButton *moreButton;
@end

@implementation LoginedView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setLoginedView];
    }
    return self;
}

- (void)setLoginedView{
    
    PersionModel *data = [PersionModel sharedPersionModel];
      NSString *User = [[NSUserDefaults standardUserDefaults] objectForKey:@"usr"];
    
    UIImageView *headImage = [[UIImageView alloc] init];
    //获取沙盒缓存图片
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
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
    [loginHelp setTitleColor:DefaultFontColor forState:UIControlStateNormal];
    [loginHelp setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    
    [loginHelp addTarget:self action:@selector(loginWithHelp:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:loginHelp];
    self.loginHelp = loginHelp;
    
    // 账号
    UILabel *account = [[UILabel alloc] init];
    [account setText:User];
    [self addSubview:account];
    self.account = account;
        
    AccountTextField *passwordInput = [AccountTextField accountTextFieldWithText:@"密码" andWithPlaceHolderText:@"请填写密码" andWithTextStartX:70];
    [passwordInput.textInput addTarget:self action:@selector(textFieldDidChange)
                      forControlEvents:UIControlEventEditingChanged];
    
//    NSString *Password = [[NSUserDefaults standardUserDefaults] objectForKey:@"pwd"];
//    [passwordInput.textInput setText:Password];
    
    [passwordInput.textInput setSecureTextEntry:YES];
    [self addSubview:passwordInput];
    self.passwordInput = passwordInput;
        
    [loginHelp.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    [self.loginButton setEnabled:self.passwordInput.textInput.text.length];
    
    
    //更多按钮
    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreButton setTitle:@"更多" forState:UIControlStateNormal];
    
    [moreButton setTitleColor:DefaultFontColor forState:UIControlStateNormal];
    [moreButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [moreButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [moreButton addTarget:self action:@selector(moreButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:moreButton];
    self.moreButton = moreButton;
    
}

- (void)layoutSubviews{
    [self.headImage setSize:CGSizeMake(100, 100)];
    [self.headImage.layer setCornerRadius:5];
    [self.headImage.layer setMasksToBounds:YES];
    [self.headImage topOffSetFrom:self withOffset:100];
    [self.headImage leftOffSetFrom:self withOffset:(self.width - self.headImage.width)*0.5];
    
    
    [self.account sizeLevelHeight:40];
    [self.account topOffSetFrom:self withOffset:210];
    [self.account leftOffSetFrom:self withOffset:(self.width - self.account.width)*0.5];
    

    [self.passwordInput setFrame:CGRectMake(40, 259, self.width - 80, 40)];
    [self.loginButton setFrame:CGRectMake(40, 310, self.width - 80, 50)];
    [self.loginHelp setFrame:CGRectMake(60, 360,self.width - 120, 40)];
    [self.moreButton setFrame:CGRectMake(0, 530, self.width, 30)];
}

- (void)textFieldDidChange{
    [self.loginButton setEnabled:self.passwordInput.textInput.text.length];

}

- (void)loginAccountHost:(UIButton *) button{
    [self endEditing:YES];
    
    if([self.delegate respondsToSelector:@selector(loginedViewDidLogin:)]){
        [self.delegate loginedViewDidLogin:self];
    }
}

//
- (void)loginWithHelp:(UIButton *) button{
    if([self.delegate respondsToSelector:@selector(loginedViewDidLoginHelp:)]){
        [self.delegate loginedViewDidLoginHelp:self];
    }
}

// 更多按钮
- (void)moreButton:(UIButton *) button{
    if([self.delegate respondsToSelector:@selector(loginedViewDidMoreButton:)]){
        [self.delegate loginedViewDidMoreButton:self];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}


@end
