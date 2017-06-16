//
//  SearchFriendsTableViewCell.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/29.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "SearchFriendsTableViewCell.h"
#import "SettingModel.h"

@interface SearchFriendsTableViewCell ()
@property (nonatomic,strong)UIImageView *imageIcon;
@property (nonatomic,strong)UILabel *searchLabel;
@property (nonatomic,strong)UILabel *text;
@end

@implementation SearchFriendsTableViewCell

- (UILabel *)text{
    
    if(!_text){
        _text = [[UILabel alloc] init];
        [_text setTextColor:[UIColor colorWithRed:31/255.0 green:185/255.0 blue:34/255.0 alpha:1.0]];
        [self.contentView addSubview:_text];
    }
    return _text;
}

- (UILabel *)searchLabel{
    
    if(!_searchLabel){
        _searchLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_searchLabel];
    }
    return _searchLabel;
}

- (UIImageView *)imageIcon{
    if(!_imageIcon){
        _imageIcon = [[UIImageView alloc] init];
        [_imageIcon.layer setCornerRadius:5];
        [_imageIcon.layer setMasksToBounds:YES];
        [self.contentView addSubview:_imageIcon];
    }
    return _imageIcon;
}

#define  bPadding     5
#define  bMargin      10

- (void)setModel:(SettingModel *)model{
    _model = model;

    if(model.icon.length){
        [self.imageIcon setImage:[UIImage imageNamed:model.icon]];
        
        [self.imageIcon setSize:CGSizeMake(model.cellHeight - bPadding*2, model.cellHeight - bPadding*2)];
        [self.imageIcon topOffSetFrom:self withOffset:bPadding];
        [self.imageIcon leftOffSetFrom:self withOffset:bMargin];
     
    }
    
    if(model.title.length){
        [self.searchLabel setText:model.title];
        
        [self.searchLabel sizeLevelHeight:model.cellHeight - bPadding*2];
        [self.searchLabel leftOffSetTo:self.imageIcon withOffset:bMargin];
        [self.searchLabel equalCenterYTo:self.imageIcon];
    }
    
    if(model.detailTitle){
        [self.text setText:model.detailTitle];
        
        [self.text sizeLevelWidth:self.width - CGRectGetMaxX(self.searchLabel.frame)];
        [self.text leftOffSetTo:self.searchLabel withOffset:0];
        [self.text equalCenterYTo:self.searchLabel];
    }
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    NSString *ID = @"SearchFriends";
    
    SearchFriendsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:ID];
        [cell.contentView setHidden:YES];
    }
    return cell;
}

@end
