//
//  MeInformTableViewCell.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/7.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "MeInformTableViewCell.h"
#import "MeRightItemView.h"
#import "BaseRightItemView.h"
#import "MeInformArrowModel.h"
#import "MeInformArrowFrameModel.h"
#import "SettingViewArrowModel.h"
#import "MeFrameConfig.h"

@interface MeInformTableViewCell ()
//左边图标
@property (nonatomic,strong)UIImageView *iconView;

//标题
@property (nonatomic,strong)UILabel *textView;


@end
@implementation MeInformTableViewCell

- (UIImageView *)iconView{
    if(!_iconView){
        _iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:_iconView];
    }
    return _iconView;
}

-(UILabel *)textView{
    if(!_textView){
        _textView = [[UILabel alloc] init];
        [_textView setFont:CellTitelFontSize];
        [self.contentView addSubview:_textView];
    }
    return _textView;
}

- (MeRightItemView *)rightView{
    if(!_rightView){
        _rightView = [[MeRightItemView alloc] init];
        [self.contentView addSubview:_rightView];
    }
    return _rightView;
}

- (BaseRightItemView *)rightViews{
    if(!_rightViews){
        _rightViews = [[BaseRightItemView alloc] init];
        [self.contentView addSubview:_rightViews];
    }
    return _rightViews;
}

- (void)setModel:(MeInformArrowModel *)model{
    _model = model;
    
    //设置用户名
    if(model.title.length){
        [self.textView setText:model.title];
    }

    //如果没有设置图片
    if(model.icon.length){
//        [self.imageView setImage:[UIImage imageNamed:model.icon]];
        [self.iconView setImage:[UIImage imageNamed:model.icon]];
    }
    
    //设置框架
    if(model.modelFrame){
        [self setCellFrame];
    }

    if([model isKindOfClass:[SettingViewArrowModel class]]){
        
        [_rightViews setPadding:model.rightItemPadding];
        [_rightViews setViews:model.rightItemImages];
        [self setSelectionStyle:UITableViewCellSelectionStyleDefault];
    }else if([model isKindOfClass:[MeInformArrowModel class]]){
        //设置图片间距
        [_rightView setPadding:model.rightItemPadding];
        //设置图片
        [_rightView setImages:model.rightItemImages];
        [self setSelectionStyle:UITableViewCellSelectionStyleDefault];
        
    }else{
        self.accessoryView = nil;
    }
}

- (void)setCellFrame{
    //设置左边图标
    [self.iconView setFrame:self.model.modelFrame.iconFrame];
    //设置标题
    [self.textView setFrame:self.model.modelFrame.textFrame];
    //设置右边视图
    [self.rightView setFrame:self.model.modelFrame.rightItemFrame];
    [self.rightViews setFrame:self.model.modelFrame.rightItemFrame];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    NSString *ID = @"me";
    
    MeInformTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        cell = [[MeInformTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:ID];
    }
    return cell;
}
@end
