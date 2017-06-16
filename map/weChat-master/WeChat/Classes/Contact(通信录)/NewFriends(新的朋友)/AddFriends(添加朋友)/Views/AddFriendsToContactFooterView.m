//
//  AddFriendsToContactFooterView.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/29.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "AddFriendsToContactFooterView.h"

@interface AddFriendsToContactFooterView ()
@property (nonatomic,strong)UIButton *addFriends;
@end

@implementation AddFriendsToContactFooterView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setupAddFriendToContactFooterView];
    }
    return self;
}

- (void)setupAddFriendToContactFooterView{
    //登录按钮
    UIButton *addFriends = [UIButton buttonWithType:UIButtonTypeCustom];
    [addFriends setBackgroundImage:[UIImage resizeWithImageName:@"fts_green_btn"] forState:UIControlStateNormal];
    [addFriends setBackgroundImage:[UIImage resizeWithImageName:@"fts_green_btn_HL"] forState:UIControlStateHighlighted];
    [addFriends setTitle:@"添加到通讯录" forState:UIControlStateNormal];
    [addFriends addTarget:self action:@selector(addFriendsToContact:) forControlEvents:UIControlEventTouchUpInside];
    
    [self setUserInteractionEnabled:YES];
    
    [self addSubview:addFriends];
    self.addFriends = addFriends;
}

- (void)addFriendsToContact:(UIButton *)button{
    DebugLog(@"添加朋友");
    if([self.protocal respondsToSelector:@selector(addFriendsToContactDidAdd)]){
        [self.protocal addFriendsToContactDidAdd];
    }
}


- (void)layoutSubviews{
    [self.addFriends setFrame:CGRectMake(20, 0, self.width - 40, 50)];
}

@end
