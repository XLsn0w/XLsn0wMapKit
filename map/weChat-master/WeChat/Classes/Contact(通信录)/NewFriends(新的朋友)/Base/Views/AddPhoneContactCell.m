//
//  AddPhoneContactCell.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/26.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "AddPhoneContactCell.h"
#import "AddPhoneContactMode.h"
#import "GlobalConfig.h"


#define bMargin      10
#define LabelFontSize   [UIFont systemFontOfSize:13]

@interface AddPhoneContactCell ()

@property (nonatomic, strong)UIImageView *middleicon;
@property (nonatomic, strong)UILabel *cellDetailText;
@end

@implementation AddPhoneContactCell

- (UIImageView *)middleicon{
    if(!_middleicon){
        _middleicon = [[UIImageView alloc] init];
        [self addSubview:_middleicon];
    }
    return _middleicon;
}

- (UILabel *)cellDetailText{
    if(!_cellDetailText){
        _cellDetailText = [[UILabel alloc] init];
        [_cellDetailText setFont:LabelFontSize];
        [_cellDetailText setTextColor:[UIColor lightGrayColor]];
        [_cellDetailText setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_cellDetailText];
    }
    
    return _cellDetailText;
}

- (void)layoutSubviews{
    DebugLog(@"cell size:%@",NSStringFromCGRect(self.frame));
    //图片
    [self.middleicon setSize:CGSizeMake(36, 36)];
    [self.middleicon topOffSetFrom:self withOffset:bMargin];
    [self.middleicon leftOffSetFrom:self withOffset:(self.width - self.middleicon.width)*0.5];
    
    //标签
    [self.cellDetailText setSize:CGSizeMake(self.width, 20)];
    [self.cellDetailText topOffSetTo:self.middleicon withOffset:bMargin];

}

- (void)setModel:(AddPhoneContactMode *)model{
    _model = model;
    
    if(model.cellText){
        [self.cellDetailText setText:model.cellText];
    }

    if(model.middleIcon){
        [self.middleicon  setImage:model.middleIcon];
    }
    
    [self setNeedsDisplay];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    NSString *ID = @"addPhoneContact";
    
    AddPhoneContactCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:ID];
    }
    return cell;
}
@end
