//
//  MeTableViewCell.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/7.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "MeTableViewCell.h"
#import "MeArrowModel.h"
#import "MeArrowFrameModel.h"
#import "MeFrameConfig.h"
#import "MeRightItemView.h"

@interface MeTableViewCell ()
//头像
@property (nonatomic,strong)UIImageView *headerView;
//用户名
@property (nonatomic,strong)UILabel *nameView;
//账号描述
@property (nonatomic,strong)UILabel *textView;
//右边视图
@property (nonatomic,strong)MeRightItemView  *rightView;

@property (nonatomic,strong)NSArray *rightItems;
@end

@implementation MeTableViewCell

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

- (UILabel *)textView{
    if(!_textView){
        _textView = [[UILabel alloc] init];
        [_textView setFont:DetailTitelFontSize];
        
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

- (NSArray *)rightItems{
    if(!_rightItems){
       UIImage *myQR = [UIImage imageNamed:@"setting_myQR"];
       UIImage *arrow = [UIImage imageNamed:@"arrow_ico"];
       _rightItems = @[myQR,arrow];
    }
    return _rightItems;
}

- (void)setModel:(MeArrowModel *)model{
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
    //设置账户信息
    if(model.detailTitle.length){
        [self.textView setText:model.detailTitle];
    }
    
    //设置框架
    if(model.modelFrame){
        [self setCellFrame];
    }

   if([model isKindOfClass:[MeArrowModel class]]){
    
       [_rightView setImages:self.rightItems];
       [self setSelectionStyle:UITableViewCellSelectionStyleDefault];
    }
}

- (void)setCellFrame{
    //设置头像大小
    [self.headerView setFrame:self.model.modelFrame.headerFrame];
    //设置标题
    [self.nameView setFrame:self.model.modelFrame.nameFrame];
    //设置副标题
    [self.textView setFrame:self.model.modelFrame.textFrame];
    //设置右边视图
    [self.rightView setFrame:self.model.modelFrame.rightItemFrame];
}


+ (instancetype)cellWithTableView:(UITableView *)tableView {
    NSString *ID = @"me";
    
    MeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
            cell = [[MeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:ID];
    }
    return cell;
}
@end
