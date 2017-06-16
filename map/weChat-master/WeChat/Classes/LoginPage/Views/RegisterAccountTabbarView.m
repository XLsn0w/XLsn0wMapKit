//
//  RegisterAccountTabbarView.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/3.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "RegisterAccountTabbarView.h"
#import "GlobalConfig.h"

@interface RegisterAccountTabbarView ()
@property (nonatomic,strong)UILabel *notice;
@property (nonatomic,strong)UIButton *allowMent;
@end

@implementation RegisterAccountTabbarView

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
        [self setRegisterAccountTabbarView];
    }
    return self;
}

- (void)setRegisterAccountTabbarView{
    [self setBackgroundColor:[UIColor clearColor]];
    
    UILabel *notice = [[UILabel alloc] init];
    [notice setText:@"轻触上面的“注册”按钮，即表示你同意"];
    [self addSubview:notice];
    self.notice = notice;
    
    UIButton *allowMent = [UIButton buttonWithType:UIButtonTypeCustom];
    [allowMent setTitle:@"《微信软件许可及服务协议》" forState:UIControlStateNormal];
    [allowMent setTitleColor:DefaultFontColor forState:UIControlStateNormal];
    [allowMent setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [allowMent addTarget:self action:@selector(jumpToAllowMent:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:allowMent];
    self.allowMent = allowMent;
    
}

- (void)layoutSubviews{
     if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        [self.notice setFrame:CGRectMake(250, 0, 400, 30)];
        [self.allowMent setFrame:CGRectMake(260, 30, 300, 30)];
     }else{
         [self.notice setFont:[UIFont systemFontOfSize:14.0]];
         [self.notice setFrame:CGRectMake(40, 0, 300, 20)];
         [self.allowMent setFrame:CGRectMake(60, 20, 200, 20)];
         [self.allowMent.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
     }
}

- (void)jumpToAllowMent:(UIButton *) button{
    //NSLog(@"tiaozhuan");
    if([self.delegate respondsToSelector:@selector(registerAccountTabbarViewDidSelectAllowMent:)]){
        NSLog(@"tiaozhuan");
        [self.delegate registerAccountTabbarViewDidSelectAllowMent:self];
    }
}
@end
