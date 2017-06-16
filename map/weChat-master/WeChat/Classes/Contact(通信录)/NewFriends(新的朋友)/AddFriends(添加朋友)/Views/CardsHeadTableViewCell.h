//
//  CardsHeadTableViewCell.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/31.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CardsHeadModel;

@interface CardsHeadTableViewCell : UITableViewCell

@property (nonatomic,strong)CardsHeadModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
