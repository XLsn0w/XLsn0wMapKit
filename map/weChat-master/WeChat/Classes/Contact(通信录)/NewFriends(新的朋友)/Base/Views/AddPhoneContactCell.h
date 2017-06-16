//
//  AddPhoneContactCell.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/26.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddPhoneContactMode;

@interface AddPhoneContactCell : UITableViewCell
@property (nonatomic, strong)AddPhoneContactMode *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
