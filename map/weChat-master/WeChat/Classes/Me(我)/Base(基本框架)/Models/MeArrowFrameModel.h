//
//  MeArrowFrameModel.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/7.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MeArrowModel;

@interface MeArrowFrameModel : NSObject
@property (nonatomic,assign,readonly)CGRect headerFrame;
@property (nonatomic,assign,readonly)CGRect nameFrame;
@property (nonatomic,assign,readonly)CGRect textFrame;
@property (nonatomic,assign,readonly)CGRect rightItemFrame;

+ (instancetype)initWithModel:(MeArrowModel *) model;
@end
