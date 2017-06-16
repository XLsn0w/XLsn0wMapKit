//
//  MeInformTableViewCell.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/7.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MeInformArrowModel,MeRightItemView,BaseRightItemView;

@interface MeInformTableViewCell : UITableViewCell
@property (nonatomic,strong)MeInformArrowModel *model;
//右边视图
@property (nonatomic,strong)MeRightItemView  *rightView;

@property (nonatomic,strong)BaseRightItemView *rightViews;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
