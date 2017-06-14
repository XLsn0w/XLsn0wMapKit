//
//  MainViewController.m
//  XLsn0wMapKit
//
//  Created by XLsn0w on 2017/6/13.
//  Copyright © 2017年 XLsn0w. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController () <MAMapViewDelegate>

@property (nonatomic, strong) MAMapView *mapView;

@property (strong, nonatomic) AMapLocationManager *locationManager;//定位管理者

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"MainViewController";

    ///初始化地图
    _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    ///把地图添加至view
    [self.view addSubview:_mapView];
    ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    _mapView.showsScale= YES;  //设置成NO表示不显示比例尺；YES表示显示比例尺
    _mapView.scaleOrigin= CGPointMake(_mapView.scaleOrigin.x, 22);  //设置比例尺位置
    
    _mapView.delegate = self;

    
    
    //创建定位管理者
    self.locationManager = [[AMapLocationManager alloc] init];
    [self setLocationManagerForHundredMeters];
    
    //一次获取定位信息（带反编码）
    //[XYQProgressHUD showMessage:@"正在定位"];
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        //[XYQProgressHUD hideHUD];
        if (error){
            //[XYQProgressHUD showError:@"定位失败"];
            if(error.code == AMapLocationErrorLocateFailed) return;
        }
        if (location && regeocode){
            //[XYQProgressHUD showSuccess:@"定位成功"];
            [self showLocationInfomation:location ReGeocode:regeocode];
        }
    }];
    
}

//设置百米精确度
-(void)setLocationManagerForHundredMeters{
    
    //1.带逆地理信息的一次定位（返回坐标和地址信息）
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    
    //2.定位超时时间，最低2s，此处设置为2s
    self.locationManager.locationTimeout =2;
    
    //3.逆地理请求超时时间，最低2s，此处设置为2s
    self.locationManager.reGeocodeTimeout = 2;
}

//设置十米精确度
-(void)setLocationManagerForAccuracyBest{
    
    //1.带逆地理信息的一次定位（返回坐标和地址信息）
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    //2定位超时时间，最低2s，此处设置为10s
    self.locationManager.locationTimeout =10;
    
    //3.逆地理请求超时时间，最低2s，此处设置为10s
    self.locationManager.reGeocodeTimeout = 10;
}

//显示定位信息
- (void)showLocationInfomation:(CLLocation *)location ReGeocode:(AMapLocationReGeocode *)regeocode{
    NSLog(@"%@", [NSString stringWithFormat:@"%lf", location.coordinate.longitude]);
    NSLog(@"%@", [NSString stringWithFormat:@"%lf", location.coordinate.latitude]);
    
    NSLog(@"%@", regeocode.province);
    NSLog(@"%@", regeocode.city);
    NSLog(@"%@", regeocode.district);

    
}


- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(39.989631, 116.481018);
    pointAnnotation.title = @"方恒国际";
    pointAnnotation.subtitle = @"阜通东大街6号";
   
    
    
    [_mapView addAnnotation:pointAnnotation];
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor clearColor] size:CGSizeMake(self.view.frame.size.width, 64)] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:nil];
//}
//
//- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
//{
//    if (!color || size.width <= 0 || size.height <= 0) return nil;
//    CGRect rect = CGRectMake(0, 0, size.width, size.height);
//    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, color.CGColor);
//    CGContextFillRect(context, rect);
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return image;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
