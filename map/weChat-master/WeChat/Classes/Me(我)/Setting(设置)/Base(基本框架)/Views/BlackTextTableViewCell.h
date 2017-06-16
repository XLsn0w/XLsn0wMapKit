//
//  BlackTextTableViewCell.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/9.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BlackArrowModel;

@interface BlackTextTableViewCell : UITableViewCell
@property (nonatomic,strong)BlackArrowModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
