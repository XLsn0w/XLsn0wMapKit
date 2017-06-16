//
//  MomentsHeaderView.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/11.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "MomentsHeaderView.h"

#define HeaderIconYOffset    20


@interface MomentsHeaderView ()
@property(nonatomic,strong) UIView  *topUpView;
@property(nonatomic,strong) UIImageView *backgroundImageView;
@property(nonatomic,strong) UIImageView *iconView;
@property(nonatomic,strong) UILabel *nameLabel;
@end

@implementation MomentsHeaderView

- (UIView *)topUpView{
    if(!_topUpView){
        _topUpView = [[UIView alloc] init];
        [self addSubview:_topUpView];
    }
    return _topUpView;
}
- (UIImageView *)backgroundImageView{
    if(!_backgroundImageView){
        _backgroundImageView = [[UIImageView alloc] init];
        [_backgroundImageView setUserInteractionEnabled:YES];
        [_backgroundImageView setContentMode:UIViewContentModeScaleAspectFill];
        [self addSubview:_backgroundImageView];
    }
    return _backgroundImageView;
}

- (UIImageView *)iconView{
    if(!_iconView){
        _iconView = [[UIImageView alloc] init];
        [_iconView setUserInteractionEnabled:YES];
        [_iconView setBorderWidth:3 withColor:[UIColor whiteColor]];
        [self addSubview:_iconView];
    }
    return _iconView;
}

- (UILabel *)nameLabel{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc] init];
        [self addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setMomentsHeaderView];
    }
    return self;
}

- (void)setMomentsHeaderView{
    weak_self weakSelf = self;
    // 设置默认背景颜色
    [self setBackgroundColor:[UIColor whiteColor]];

    [self.topUpView setBackgroundColor:[UIColor darkGrayColor]];
    
    [self.backgroundImageView setImage:[UIImage imageNamed:@"AlbumHeaderBackgrounImage.jpg"]];
    [self.backgroundImageView setTapActionWithBlock:^{
        weakSelf.backGroudImageClick();
    }];
    
    PersionModel *data = [PersionModel sharedPersionModel];
    
    [data asyLocalDataFormServers];
    
    if(data.headIcon){
       [self.iconView setImage:data.headIcon];
    }else{
    [self.iconView setImage:[UIImage imageNamed:@"DefaultProfileHead"]];
    }
    
    [self.iconView setTapActionWithBlock:^{
        weakSelf.iconImageClick();
    }];
    
    [self.nameLabel setText:data.name];
    [self.nameLabel setTextColor:[UIColor whiteColor]];
    [self.nameLabel setFont:[UIFont boldSystemFontOfSize:16]];

   
}

- (void)layoutSubviews{
    [self.topUpView setSize:CGSizeMake(self.width, TopViewOnHeaderViewHeight)];
    [self.topUpView topOffSetFrom:self withOffset:0];
    
    [self.backgroundImageView setSize:CGSizeMake(self.width, AllImageViewHeight - HeaderIconYOffset*2)];
    [self.backgroundImageView bottomOffSetFrom:self withOffset:HeaderIconYOffset*2];
    
    [self.iconView setSize:CGSizeMake(70, 70)];
    [self.iconView rightOffSetFrom:self withOffset:15];
    [self.iconView bottomOffSetFrom:self.backgroundImageView withOffset:-HeaderIconYOffset];
    
    [self.nameLabel setSize:[NSString stringSizeFreeWithText:self.nameLabel.text andFont:self.nameLabel.font]];
    
    [self.nameLabel rightOffSetTo:self.iconView withOffset:15];
    [self.nameLabel equalCenterYTo:self.iconView];
    DebugLog(@"空间 name Label %@",NSStringFromCGRect (self.nameLabel.frame));
}



@end
