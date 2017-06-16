//
//  MeArrowFrameModel.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/7.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "MeArrowFrameModel.h"
#import "MeArrowModel.h"
#import "Constant.h"
#import "MeFrameConfig.h"


@implementation MeArrowFrameModel



+ (instancetype)initWithModel:(MeArrowModel *) model{
    MeArrowFrameModel *frameModel = [[self alloc] init];
    [frameModel setFrameWithModel:model];
    return frameModel;
}

//设置模型
- (void)setFrameWithModel:(MeArrowModel *) model{
    _headerFrame = CGRectMake(bPadding_10, bPadding_10, model.cellHeight - bPadding_10*2, model.cellHeight - bPadding_10*2);
    
    CGRect nameFrame = [model.title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:NameTitelFontSize} context:nil];
    
    CGRect textFrame = [model.detailTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:DetailTitelFontSize} context:nil];
    
    nameFrame.origin.x = bPadding_10 + CGRectGetMaxX(_headerFrame);
    nameFrame.origin.y = bPadding_10 + (_headerFrame.size.height - nameFrame.size.height - textFrame.size.height - bPadding_10)*0.5;
    
    textFrame.origin.x = nameFrame.origin.x;
    textFrame.origin.y = bPadding_10 + CGRectGetMaxY(nameFrame);
    
    _nameFrame = nameFrame;
    _textFrame = textFrame;
    
    _rightItemFrame =  CGRectMake(bScreenWidth - bPadding_10 - bRightViewWidth, (model.cellHeight - bRightViewHeight)*0.5, bRightViewWidth, bRightViewHeight);
}
@end
