//
//  LoginAccountTabbarView.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/3.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "LoginAccountTabbarView.h"
#import "SplitLineView.h"

@interface LoginAccountTabbarView ()
@property (nonatomic,strong)UIButton *loginHelp;
@property (nonatomic,strong)UIButton *otherWayLogin;
@property (nonatomic,strong)SplitLineView *midleLine;
@end
@implementation LoginAccountTabbarView

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
        [self setLoginAccountTabbarView];
    }
    return self;
}

- (void)setLoginAccountTabbarView{
    [self setBackgroundColor:[UIColor clearColor]];
    
    UIButton *loginHelp = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginHelp setTitle:@"登录遇到问题？" forState:UIControlStateNormal];
    [loginHelp setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];

    [loginHelp setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [loginHelp addTarget:self action:@selector(loginHelp:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:loginHelp];
    self.loginHelp = loginHelp;
    
    SplitLineView *midleLine = [[SplitLineView alloc] init];
    [self addSubview:midleLine];
    self.midleLine = midleLine;
    
    UIButton *otherWayLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    [otherWayLogin setTitle:@"其他登录方式" forState:UIControlStateNormal];
   
    [otherWayLogin setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [otherWayLogin setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [otherWayLogin addTarget:self action:@selector(otherWayLoginHost:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:otherWayLogin];
    self.otherWayLogin = otherWayLogin;
    
      if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
           [loginHelp.titleLabel setFont:[UIFont systemFontOfSize:30.0]];
           [otherWayLogin.titleLabel setFont:[UIFont systemFontOfSize:30.0]];
      }else{
          [loginHelp.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
          [otherWayLogin.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
      }
    
}

- (void)layoutSubviews{
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
            [self.midleLine setFrame:CGRectMake(self.bounds.size.width*0.5, 0, 1, 40)];
            [self.loginHelp setFrame:CGRectMake(100, 0, self.bounds.size.width*0.5 - 100, 40)];
            [self.otherWayLogin setFrame:CGRectMake(self.bounds.size.width*0.5, 0, self.bounds.size.width*0.5 - 100, 40)];
        }else{
            [self.midleLine setFrame:CGRectMake(self.bounds.size.width*0.5, 0, 1, 20)];
            [self.loginHelp setFrame:CGRectMake(50, 0, self.bounds.size.width*0.5 - 50, 20)];
            [self.otherWayLogin setFrame:CGRectMake(self.bounds.size.width*0.5, 0, self.bounds.size.width*0.5 - 50, 20)];
        }
}

- (void)otherWayLoginHost:(UIButton *) button{
    if([self.delegate respondsToSelector:@selector(loginAccountTabbarViewDidOtherWayLogin:)]){
        [self.delegate loginAccountTabbarViewDidOtherWayLogin:self];
    }
}

- (void)loginHelp:(UIButton *) button{
    
}

@end
