//
//  MeInformArrowFrameModel.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/7.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MeInformArrowModel;

@interface MeInformArrowFrameModel : NSObject
@property (nonatomic,assign)CGRect iconFrame;
@property (nonatomic,assign,readonly)CGRect textFrame;
@property (nonatomic,assign,readonly)CGRect rightItemFrame;

+ (instancetype)initWithModel:(MeInformArrowModel *) model andWithIconSize:(CGSize) size;
@end
