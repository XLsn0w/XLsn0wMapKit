//
//  CardsNameFieldCell.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/31.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "CardsNameFieldCell.h"
#import "SettingModel.h"
#import "Constant.h"

@interface CardsNameFieldCell ()

@property (nonatomic,strong)UITextField *nameField;
@property (nonatomic,strong)UILabel *label;

@end

@implementation CardsNameFieldCell

- (UITextField *)nameField{
    if(!_nameField){
        _nameField = [[UITextField alloc] init];
        [_nameField setTintColor:SystemTintColor];
//        [_nameField becomeFirstResponder];
        [_nameField addTarget:self action:@selector(textFieldsDidChange:) forControlEvents:UIControlEventValueChanged];
        [self addSubview: _nameField];
    }
    return _nameField;
}

- (UILabel*)label{
    if(!_label){
        _label = [[UILabel alloc] init];\
        [self.contentView addSubview:_label];
    }
    return _label;
}

#define bPadding   10

- (void)setModel:(SettingModel *)model{
    _model = model;
    
    [self.label setText:model.detailTitle];
    [self.nameField setText:model.title];
    
    [self.label sizeLevelHeight:self.height];
    [self.label leftOffSetFrom:self withOffset:bPadding];
   
    
    [self.nameField setSize:CGSizeMake(self.width - CGRectGetMaxX(self.label.frame), self.height)];
    [self.nameField topOffSetFrom:self withOffset:0];
    [self.nameField leftOffSetTo:self.label withOffset:0];
    
     [self.label equalCenterYTo:self.nameField];
    

}

- (void)textFieldsDidChange:(UITextField *) textField{
    DebugLog(@"改变了文字");
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    NSString *ID = @"CardsNameField";
    
    CardsNameFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:ID];
    }
    return cell;
}

@end
