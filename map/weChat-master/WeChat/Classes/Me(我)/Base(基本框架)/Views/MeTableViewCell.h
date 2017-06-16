//
//  MeTableViewCell.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/7.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MeArrowModel;

@interface MeTableViewCell : UITableViewCell
@property (nonatomic,strong)MeArrowModel *model;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
