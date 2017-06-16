//
//  BlackTextTableViewCell.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/9.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "BlackTextTableViewCell.h"
#import "BlackArrowModel.h"

@interface BlackTextTableViewCell ()
@property (nonatomic,strong)UILabel *cellTextField;
@end

@implementation BlackTextTableViewCell

- (UILabel *)cellTextField{
    if(!_cellTextField){
        _cellTextField = [[UILabel alloc] init];
        [self addSubview:_cellTextField];
    }
    return _cellTextField;
}

- (void)setModel:(BlackArrowModel *)model{
    _model = model;
    
    [self.cellTextField setText:model.cellText];
    [self.cellTextField setFont:model.fontType];
    
    [self setNeedsDisplay];
}


- (void)layoutSubviews{
    CGRect frame = [self.model.cellText boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.model.fontType} context:nil];
    
    [self.cellTextField setFrame:CGRectMake((self.frame.size.width - frame.size.width)*0.5, (self.frame.size.height - frame.size.height)*0.5, frame.size.width, frame.size.height)];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    NSString *ID = @"black";
    
    BlackTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:ID];
    }
    return cell;
}

@end
