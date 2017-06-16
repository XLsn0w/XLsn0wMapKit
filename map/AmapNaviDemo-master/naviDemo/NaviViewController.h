//
//  NaviViewController.h
//  naviDemo
//
//  Created by 赵鹏 on 16/6/28.
//  Copyright © 2016年 zhaopeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>

@interface NaviViewController : UIViewController



@property(nonatomic,strong) NSString * startLocation;//设定起始位置;
@property(nonatomic,strong) NSString * endLocation;//设定结束位置;
@property(nonatomic,strong) NSString * currentCity;//当前城市;

@property(nonatomic,assign) CLLocation  *center;
@end
