//
//  SearchFriendsFooterView.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/27.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "SearchFriendsFooterView.h"

@interface SearchFriendsFooterView ()

@end

#define bPadding     5
@implementation SearchFriendsFooterView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setupSearchFriendsFooterView];
    }
    return self;
}

- (void)setupSearchFriendsFooterView{
    
    UILabel *title = [[UILabel alloc] init];
    [title setFont:[UIFont systemFontOfSize:13]];
    [self addSubview:title];
    self.title = title;
    
    UIImageView *icon = [[UIImageView alloc] init];
    [self addSubview:icon];
    self.icon = icon;
}

-(void)layoutSubviews{
    
    [self.icon setSize:CGSizeMake(20, 20)];
    [self.title sizeLevelHeight:20];
    
    [self.icon topOffSetFrom:self withOffset:bPadding];
    
    [self.title leftOffSetFrom:self withOffset:(self.width - self.title.width - self.icon.width - bPadding)*0.5];
    
    [self.icon leftOffSetTo:self.title withOffset:bPadding];

    [self.title equalCenterYTo:self.icon];
    
}

@end
