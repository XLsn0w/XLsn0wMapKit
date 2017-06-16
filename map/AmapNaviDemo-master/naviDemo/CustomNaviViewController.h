//
//  CustomNaviViewController.h
//  AMapNaviKit
//
//  Created by 刘博 on 16/3/14.
//  Copyright © 2016年 AutoNavi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapNaviKit/AMapNaviKit.h>

@interface CustomNaviViewController : UIViewController

@property (nonatomic, strong) AMapNaviDriveManager *driveManager;

@property (nonatomic, strong) AMapNaviDriveView *driveView;

//@property(nonatomic,strong) NSString * startLocation;//设定起始位置;
//@property(nonatomic,strong) NSString * endLocation;//设定结束位置;
//@property(nonatomic,strong) NSString * currentCity;//当前城市;
@property (nonatomic, strong) AMapNaviPoint *startPoint;
@property (nonatomic, strong) AMapNaviPoint *endPoint;


@property(nonatomic,assign) CLLocation  *center;

@end
