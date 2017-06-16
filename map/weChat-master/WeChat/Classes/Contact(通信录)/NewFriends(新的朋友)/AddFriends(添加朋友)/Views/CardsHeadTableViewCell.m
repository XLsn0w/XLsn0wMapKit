//
//  CardsHeadTableViewCell.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/31.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "CardsHeadTableViewCell.h"
#import "CardsHeadFrameModel.h"
#import "CardsHeadModel.h"


#define NameTitelFontSize  [UIFont systemFontOfSize:16]

@interface CardsHeadTableViewCell ()
//头像
@property (nonatomic,strong)UIImageView *headerView;
//用户名
@property (nonatomic,strong)UILabel *nameView;
//性别头像
@property (nonatomic,strong)UIImageView *genderView;

@end

@implementation CardsHeadTableViewCell

- (UIImageView *)headerView{
    if(!_headerView){
        _headerView = [[UIImageView alloc] init];
        [self.contentView addSubview:_headerView];
    }
    return _headerView;
}

- (UILabel *)nameView{
    if(!_nameView){
        _nameView = [[UILabel alloc] init];
        [_nameView setFont:NameTitelFontSize];
        
        [self.contentView addSubview:_nameView];
    }
    return _nameView;
}

- (UIImageView *)genderView{
    if(!_genderView){
        _genderView = [[UIImageView alloc] init];
        [self.contentView addSubview:_genderView];
    }
    
    return _genderView;
}


- (void)setModel:(CardsHeadModel *)model{
    _model = model;
    
    //设置用户名
    if(model.title.length){
        [self.nameView setText:model.title];
    }
    //如果没有设置图片
    if(model.icon.length){
        [self.headerView setImage:[UIImage imageNamed:model.icon]];
        // 圆角
        //        [self.headerView.layer setCornerRadius:self.headerView.frame.size.width*0.5];
        //        [self.headerView.layer setMasksToBounds:YES];
    }else if(model.iconImage){
        [self.headerView setImage:model.iconImage];
    }
    //设置性别信息
    if(model.genderIcon.length){
        [self.genderView setImage:[UIImage imageNamed:model.genderIcon]];
    }
    
    //设置框架
    if(model.modelFrame){
        [self setCellFrame];
    }
}

- (void)setCellFrame{
    //设置头像大小
    [self.headerView setFrame:self.model.modelFrame.headerFrame];
    //设置标题
    [self.nameView setFrame:self.model.modelFrame.nameFrame];
    //设置性别图标
    [self.genderView setFrame:self.model.modelFrame.genderFrame];
}


+ (instancetype)cellWithTableView:(UITableView *)tableView {
    NSString *ID = @"CardsHead";
    
    CardsHeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:ID];
    }
    return cell;
}
@end
