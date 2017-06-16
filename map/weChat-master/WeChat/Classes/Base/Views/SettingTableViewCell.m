//
//  SettingTableViewCell.m
//  天天福彩
//
//  Created by 李莎鑫 on 2016/12/10.
//  Copyright © 2016年 李莎鑫. All rights reserved.
//

#import "SettingTableViewCell.h"
#import "SettingModel.h"
#import "SettingArrowModel.h"
#import "SettingSwitchModel.h"
#import "SettingLabelModel.h"
#import "MeArrowModel.h"
#import "ContactArrowModel.h"
#import "SettingViewArrowModel.h"


#import "LargeIconArrowModel.h"
#import "UIImage+ResizeImage.h"

@interface SettingTableViewCell ()
@property  (nonatomic,strong)UISwitch *switchView;
@property  (nonatomic,strong)UIImageView *imgView;
@property  (nonatomic,strong)UILabel *labelView;
@end

@implementation SettingTableViewCell



#pragma mark -
- (UISwitch *)switchView{
    if(!_switchView){
        _switchView = [[UISwitch alloc] init];
    }
    return _switchView;
}

- (UIImageView *)imgView{
    if(!_imgView){
        _imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_ico"]];
    }
    return _imgView;
}
- (UILabel *)labelView{
    if(!_labelView){
        _labelView = [[UILabel alloc] init];
        [_labelView setBounds:CGRectMake(0, 0, 100, 30)];
        [_labelView setTextColor:[UIColor redColor]];
        [_labelView setTextAlignment:NSTextAlignmentRight];
    }
    return _labelView;
}

- (void)setModel:(SettingModel *)model{
    _model = model;
    
    [self.textLabel setText:model.title];
    //如果没有设置图片
    if(model.icon.length){
        if([model isKindOfClass:[LargeIconArrowModel class]]){
            [self.imageView setImage:[UIImage sizeWithImageName:model.icon toSize:CGSizeMake(24, 28)]];
        }else{
            [self.imageView setImage:[UIImage imageNamed:model.icon]];
        }
    }
    
    if(model.detailTitle.length){
        [self.detailTextLabel setText:model.detailTitle];
    }
    
    
    if([model isKindOfClass:[SettingSwitchModel class]]){
        [self setAccessoryView:self.switchView];
#warning    带switch控件的cell不允许选中
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
    }else if([model isKindOfClass:[ContactArrowModel class]]){
        [self setAccessoryType:UITableViewCellAccessoryNone];
        [self setSelectionStyle:UITableViewCellSelectionStyleDefault];
    }
    else if([model isKindOfClass:[SettingArrowModel class]]){
        [self setAccessoryView:self.imgView];
        [self setSelectionStyle:UITableViewCellSelectionStyleDefault];

    }else if([model isKindOfClass:[SettingLabelModel class]]){
        SettingLabelModel *labelMode = (SettingLabelModel *)model;
        [self.labelView setText:labelMode.text];
        [self setAccessoryView:self.labelView];
        [self setSelectionStyle:UITableViewCellSelectionStyleDefault];
    }else{
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        self.accessoryView = nil;
    }
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    NSString *ID = @"setting";
    
    SettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

    if(!cell){
        cell = [[SettingTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    return cell;
}


@end
