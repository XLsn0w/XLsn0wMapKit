//
//  NaviViewController.m
//  naviDemo
//
//  Created by 赵鹏 on 16/6/28.
//  Copyright © 2016年 zhaopeng. All rights reserved.
//

#import "NaviViewController.h"
#import <AMapNaviKit/AMapNaviKit.h>
#import <MapKit/MapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

#define kCollectionCellIdentifier   @"kCollectionCellIdentifier"


@interface NaviViewController ()<AMapNaviDriveManagerDelegate,MAMapViewDelegate,AMapSearchDelegate>
/**驾车导航管理*/
@property (nonatomic,strong ) AMapNaviDriveManager *driveManager;
/**3D地图*/
@property (nonatomic,strong ) MAMapView            *mapView;
/**当前导航的路径信息*/
@property (nonatomic, strong) AMapNaviPoint        *startPoint;
@property (nonatomic, strong) AMapNaviPoint        *endPoint;

@property (nonatomic,assign ) BOOL                 isOrigin;//是否是起点
@property (nonatomic,strong ) AMapSearchAPI        *search;//搜索对象
@end

@implementation NaviViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isOrigin = YES;
    [self initMapView];
    [self  initSearch];
    [self GeoCoding];
    [self GeoCoding];
    [self centerMap];
    [self initAnnotatons];
    
//    [self routeCalculate];
}
//把地图的中心点一到两点之间
-(void)centerMap{

    self.mapView.centerCoordinate = self.center.coordinate;
}
-(void)initMapView{
    if (_mapView == nil) {
        _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
        
        _mapView.delegate = self;
        
        [self.view addSubview:_mapView];
    }
    
}
#pragma mark serach初始化
-(void)initSearch{
    
    _search =[[AMapSearchAPI alloc] init];
    _search.delegate=self;
    
}

#pragma mark - 正向地理编码部分

-(void)GeoCoding{
    
    if (_isOrigin == YES) {
        if (self.startLocation) {
            /**构建正向搜索对象*/
            AMapGeocodeSearchRequest *request =[[AMapGeocodeSearchRequest alloc] init];
            
            request.address = self.startLocation;//设置正向编码地址
            request.city    = self.currentCity;//设置当前搜索城市
            [self.search AMapGeocodeSearch:request];
            _isOrigin = NO;
        }else{
            return;
        }

    }else{
        if (self.endLocation) {
            /**构建正向搜索对象*/
            AMapGeocodeSearchRequest *request =[[AMapGeocodeSearchRequest alloc] init];
            
            request.address = self.endLocation;//设置正向编码地址
            request.city    = self.currentCity;//设置当前搜索城市
            [self.search AMapGeocodeSearch:request];
            _isOrigin = YES;
        }else{
            return;
        }
        

        
    }
}

- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response{
    if (response.count == 0) {
        return;
    }
    if (self.isOrigin == YES) {
        AMapGeocode *p = (AMapGeocode *)response.geocodes[0];
        self.startPoint = (AMapNaviPoint*)p.location;
        NSLog(@"startPoint = %@",self.startPoint);
    }
    else{
        AMapGeocode *p = (AMapGeocode *)response.geocodes[0];
        
        self.endPoint = (AMapNaviPoint *)p.location;
        NSLog(@"destinationPoint = %@",self.endPoint);
    }
}
-(void)initDriveManager
{
    if (self.driveManager == nil) {
        
        self.driveManager = [[AMapNaviDriveManager alloc] init];
        self.driveManager.delegate = self;
    }
    
}
//初始化大头针
-(void)initAnnotatons
{
    MAPointAnnotation *beginAnnotation = [[MAPointAnnotation alloc ] init];
    
    [beginAnnotation setCoordinate:CLLocationCoordinate2DMake(self.startPoint.latitude, self.startPoint.longitude)];
    beginAnnotation.title = self.startLocation;
    
    
    [_mapView addAnnotation:beginAnnotation];
    
    MAPointAnnotation *endAnnotation = [[MAPointAnnotation alloc] init];
    [endAnnotation setCoordinate:CLLocationCoordinate2DMake(self.endPoint.latitude, self.endPoint.longitude)];
    endAnnotation.title = self.endLocation;
    
    
    [_mapView addAnnotation:endAnnotation];
    
    
}
-(void)routeCalculate
{
    
    //驾车路劲规划（若未设置途经点则导航策略为速度优先）
    if (self.startPoint) {
        [self.driveManager calculateDriveRouteWithStartPoints:@[self.startPoint]
                                                    endPoints:@[self.endPoint]
                                                    wayPoints:nil
                                              drivingStrategy:AMapNaviDrivingStrategyDefault];
        
    }
    
}
#pragma mark AMapNaviDriveManagerDelegate

/**
 *  驾车路径规划成功后的回调函数
 */
- (void)driveManagerOnCalculateRouteSuccess:(AMapNaviDriveManager *)driveManager{
    
    NSLog(@"路线规划成功!");
//    [self showNaviRoutes];
}

/**
 *  驾车路径规划失败后的回调函数
 *
 *  @param error 错误信息,error.code参照AMapNaviCalcRouteState
 */
- (void)driveManager:(AMapNaviDriveManager *)driveManager onCalculateRouteFailure:(NSError *)error{
    NSLog(@"%@",error.localizedDescription);
    
}
-(void)driveManager:(AMapNaviDriveManager *)driveManager playNaviSoundString:(NSString *)soundString soundStringType:(AMapNaviSoundType)soundStringType{
//    [[SpeechSynthesizer sharedSpeechSynthesizer] speakString:soundString];
    
    NSLog(@"开始语音播报");
}

@end
