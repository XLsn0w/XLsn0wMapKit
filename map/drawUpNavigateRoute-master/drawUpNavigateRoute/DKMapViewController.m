//
//  DKMapViewController.m
//  drawUpNavigateRoute
//
//  Created by devzkn on 07/10/2016.
//  Copyright © 2016 DevKevin. All rights reserved.
//

#import "DKMapViewController.h"
#import <MapKit/MapKit.h>
#import "DKAnnotation.h"


@interface DKMapViewController () <MKMapViewDelegate>

@property (nonatomic,weak) MKMapView *mapview;

@property (nonatomic,strong) CLLocationManager *mgr;


@end

@implementation DKMapViewController

- (CLLocationManager *)mgr{
    if (nil == _mgr) {
        CLLocationManager *tmpView = [[CLLocationManager alloc]init];
        _mgr = tmpView;
    }
    return _mgr;
}


- (MKMapView *)mapview{
    if (nil == _mapview) {
        MKMapView *tmpView = [[MKMapView alloc]init];
        _mapview = tmpView;
//        tmpView.showsUserLocation = YES;
        tmpView.delegate = self;
        // 注意:在iOS8中, 如果想要追踪用户的位置, 必须自己主动请求隐私权限
        if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
            // 主动请求权限
            self.mgr = [[CLLocationManager alloc] init];
            [self.mgr requestWhenInUseAuthorization];
        }
        // 设置不允许地图旋转
        tmpView.rotateEnabled = NO;
        // 如果想利用MapKit获取用户的位置, 可以追踪
//        tmpView.userTrackingMode =  MKUserTrackingModeFollow;

        [self.view addSubview:_mapview];
    }
    return _mapview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = [UIScreen mainScreen].bounds;
    self.mapview.frame = self.view.bounds;
    [self setupRoute];
}
/**     // 绘制路线的本质：往地图添加图层，蒙板*/
-(void)setupRoute{
    //1.    // 设置地图显示的区域
    [self setCenterCoordinateAndRegionWithPlacemark:self.response.source.placemark];
    //2.获取路线信息
    for ( MKRoute *route in self.response.routes) {
        [self.mapview addOverlay:route.polyline];
    }
    //3.添加起点 和终点的大头针
    [self.mapview addAnnotation:[DKAnnotation annotationWithPlacemark:self.response.source.placemark]];
    [self.mapview addAnnotation:[DKAnnotation annotationWithPlacemark:self.response.destination.placemark]];
}
/** 切换视角到指定位置*/
- (void)setCenterCoordinateAndRegionWithPlacemark:(CLPlacemark*)placemark{
    //    // 获取开始的位置
    CLLocationCoordinate2D coordinate = placemark.location.coordinate;
    //    // 指定经纬度的跨度
    MKCoordinateSpan span = MKCoordinateSpanMake(16.735304 ,12.229443);
    //    // 将用户当前的位置作为显示区域的中心点, 并且指定需要显示的跨度范围
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);
    //    // 设置显示区域
    [self.mapview setRegion:region animated:YES];
    //地图的视角，切换到路径的起点
    [self.mapview setCenterCoordinate:coordinate animated:YES];
}

#pragma mark -MKMapViewDelegate

/** 自定义路线 ,使用MKOverlayRenderer 的子类*/
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    MKPolylineRenderer *overlayRenderer = [[MKPolylineRenderer alloc]initWithPolyline:overlay];
    overlayRenderer.strokeColor = [UIColor blueColor];
    overlayRenderer.lineWidth =  4;
    return overlayRenderer;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if (![annotation isKindOfClass:[DKAnnotation class]]) {
        return nil;
    }
    static NSString *identifier = @"MKPinAnnotationView";
    DKAnnotation *dkAnnotion = (DKAnnotation*)annotation;
    MKPinAnnotationView  *pinAnnotationView= (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (pinAnnotationView == nil) {
        pinAnnotationView = [[MKPinAnnotationView alloc]initWithAnnotation:dkAnnotion reuseIdentifier:identifier];
        pinAnnotationView.canShowCallout = YES;
    }
    return pinAnnotationView;
}



- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    NSLog(@"%f,%f",mapView.region.span.latitudeDelta,mapView.region.span.longitudeDelta);
}


@end
