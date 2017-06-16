//
//  AddressNaviViewController.m
//  XLsn0wMapKit
//
//  Created by XLsn0w on 2017/6/16.
//  Copyright © 2017年 XLsn0w. All rights reserved.
//

#import "AddressNaviViewController.h"
#import "AliMapViewSystemNaviDriveController.h"
#import "MainViewController.h"

@interface AddressNaviViewController () <UITextFieldDelegate>

@property (nonatomic,strong) UITextField *startTextField;
@property (nonatomic,strong) UITextField *endTextField;
@property (strong, nonatomic) AMapNaviPoint *startPoint;
@property (strong, nonatomic) AMapNaviPoint *endPoint;

@end

@implementation AddressNaviViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _startTextField  = [[UITextField alloc]initWithFrame:CGRectMake(50, 100, kScreenWidth - 100, 30)];
    _startTextField.layer.borderWidth = 1.0;
    _startTextField.layer.cornerRadius = 5.0;
    _startTextField.layer.borderColor = [UIColor redColor].CGColor;
    [self.view addSubview:_startTextField];
    _startTextField.delegate = self;
    
    _endTextField  = [[UITextField alloc]initWithFrame:CGRectMake(50, 200, kScreenWidth - 100, 30)];
    _endTextField.layer.borderWidth = 1.0;
    _endTextField.layer.cornerRadius = 5.0;
    _endTextField.layer.borderColor = [UIColor redColor].CGColor;
    [self.view addSubview:_endTextField];
    _endTextField.delegate = self;

    UIButton *naviButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.view addSubview:naviButton];
    naviButton.frame = CGRectMake(50, 300, kScreenWidth - 100, 30);
    [naviButton setTitle:@"开始导航" forState:(UIControlStateNormal)];
    [naviButton setTitleColor:[UIColor redColor]];
    [naviButton addTarget:self action:@selector(naviAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *mainButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.view addSubview:mainButton];
    mainButton.frame = CGRectMake(50, 400, kScreenWidth - 100, 30);
    [mainButton setTitle:@"Main" forState:(UIControlStateNormal)];
    [mainButton setTitleColor:[UIColor redColor]];
    [mainButton addTarget:self action:@selector(mainButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    
}

- (void)mainButtonAction {
    MainViewController *vc = [MainViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == _startTextField) {
        Mapcoding * map = [[Mapcoding alloc] init];
        [map getMapcoding:_startTextField.text getMapcoding:^(NSMutableDictionary *mapCodDic) {
            XLsn0wLog(@"%@", mapCodDic);
            self.startPoint = [AMapNaviPoint locationWithLatitude:[mapCodDic[@"latitude"] floatValue] longitude:[mapCodDic[@"longitude"] floatValue]];
        }];
    } else {
        Mapcoding * map = [[Mapcoding alloc] init];
        [map getMapcoding:_endTextField.text getMapcoding:^(NSMutableDictionary *mapCodDic) {
            XLsn0wLog(@"%@", mapCodDic);
            self.endPoint = [AMapNaviPoint locationWithLatitude:[mapCodDic[@"latitude"] floatValue] longitude:[mapCodDic[@"longitude"] floatValue]];
        }];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _startTextField) {
        Mapcoding * map = [[Mapcoding alloc] init];
        [map getMapcoding:_startTextField.text getMapcoding:^(NSMutableDictionary *mapCodDic) {
            XLsn0wLog(@"%@", mapCodDic);
            self.startPoint = [AMapNaviPoint locationWithLatitude:[mapCodDic[@"latitude"] floatValue] longitude:[mapCodDic[@"longitude"] floatValue]];
        }];
    } else {
        Mapcoding * map = [[Mapcoding alloc] init];
        [map getMapcoding:_endTextField.text getMapcoding:^(NSMutableDictionary *mapCodDic) {
            XLsn0wLog(@"%@", mapCodDic);
            self.endPoint = [AMapNaviPoint locationWithLatitude:[mapCodDic[@"latitude"] floatValue] longitude:[mapCodDic[@"longitude"] floatValue]];
        }];
    }

    
    return YES;
}

- (void)naviAction {
    AliMapViewSystemNaviDriveController *vc = [AliMapViewSystemNaviDriveController new];
    vc.startPoint = self.startPoint;
    vc.endPoint = self.endPoint;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
