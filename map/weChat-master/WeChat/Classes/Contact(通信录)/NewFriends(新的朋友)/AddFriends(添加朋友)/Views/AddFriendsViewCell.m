//
//  AddFriendsViewCell.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/27.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "AddFriendsViewCell.h"
#import "SettingModel.h"
#import "SettingArrowModel.h"

@interface AddFriendsViewCell ()
@property  (nonatomic,strong)UIImageView *imgView;
@end

@implementation AddFriendsViewCell

- (UIImageView *)imgView{
    if(!_imgView){
        _imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_ico"]];
    }
    return _imgView;
}

- (void)setModel:(SettingArrowModel *)model{
    _model = model;
    
    [self.textLabel setText:model.title];
    //如果没有设置图片
    if(model.icon.length){
            [self.imageView setImage:[UIImage imageNamed:model.icon]];
    }
    
    if(model.detailTitle.length){
        [self.detailTextLabel setText:model.detailTitle];
        [self.detailTextLabel setTextColor:[UIColor lightGrayColor]];
    }
    

    [self setAccessoryView:self.imgView];
    [self setSelectionStyle:UITableViewCellSelectionStyleDefault];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    NSString *ID = @"addFriends";
    
    AddFriendsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:ID];
    }
    return cell;
}

@end

@interface SearchFriendsViewCell ()
@property  (nonatomic,strong)UIImageView *iconView;
@property  (nonatomic,strong)UILabel *text;
@end
@implementation SearchFriendsViewCell

- (UIImageView *)iconView{
    if(!_iconView){
        _iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:_iconView];
    }
    return _iconView;
}

- (UILabel *)text{
    if(!_text){
        _text = [[UILabel alloc] init];
        [_text setTextColor:[UIColor lightGrayColor]];
        [_text setFont:[UIFont systemFontOfSize:16]];
        [self.contentView addSubview:_text];
    }
    return _text;
}

-(void)layoutSubviews{
    [self.iconView setSize:CGSizeMake(36, 30)];
    [self.iconView leftOffSetFrom:self withOffset:15];
    [self.iconView topOffSetFrom:self withOffset:(self.height - self.iconView.width)*0.5];
    DebugLog(@"icon view :%@",NSStringFromCGRect(self.iconView.frame));
    
    [self.text sizeLevelHeight:20];
    [self.text leftOffSetTo:self.iconView withOffset:15];
    [self.text equalCenterYTo:self.iconView];
}

- (void)setModel:(SettingArrowModel *)model{
    _model = model;
    
    [self.textLabel setText:model.title];
    //如果没有设置图片
    if(model.icon.length){
        [self.iconView setImage:[UIImage imageNamed:model.icon]];
    }
    
    if(model.detailTitle.length){
        [self.text setText:model.detailTitle];
    }
    
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    self.accessoryView = nil;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    NSString *ID = @"searchFriends";
    
    AddFriendsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        cell = [[self alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

@end
