//
//  CustomNaviViewController.m
//  AMapNaviKit
//
//  Created by 赵鹏 on 16/6/28.
//  Copyright © 2016年 AutoNavi. All rights reserved.
//

#import "CustomNaviViewController.h"
#import "SpeechSynthesizer.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import "ViewController.h"

@interface CustomNaviViewController ()<AMapNaviDriveManagerDelegate, AMapNaviDriveViewDelegate, AMapNaviDriveDataRepresentable,AMapSearchDelegate>
{
    NSInteger _routeLength;
}


@property (nonatomic, strong) UILabel *turnRemainInfoLabel;
@property (nonatomic, strong) UILabel *roadInfoLabel;
@property (nonatomic, strong) UILabel *routeRemainInfoLabel;
@property (nonatomic, strong) UILabel *cameraInfoLabel;

@property (nonatomic, strong) UIImageView *laneInfoView;
@property (nonatomic, strong) UIImageView *crossImageView;

@property (nonatomic, strong) UIButton *trackingModeButton;
@property (nonatomic, strong) UIButton *trafficLayerButton;
@property (nonatomic, strong) UIButton *showModeButton;



@end

@implementation CustomNaviViewController

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
//    [self GeoCoding];

//    [self initProperties];
    
    [self initDriveView];
    
    [self initDriveManager];
//    [self initSearch];
    
    [self configSubViews];
    [self calculateRoute];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.toolbarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
   }

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //停止语音
    [[SpeechSynthesizer sharedSpeechSynthesizer] stopSpeak];
}

- (void)initProperties
{
    //为了方便展示驾车多路径规划，选择了固定的起终点
    self.startPoint = [AMapNaviPoint locationWithLatitude:39.993135 longitude:116.474175];
    self.endPoint   = [AMapNaviPoint locationWithLatitude:39.908791 longitude:116.321257];
    
//    self.routeIndicatorInfoArray = [NSMutableArray array];
}


- (void)initDriveManager
{
    if (self.driveManager == nil)
    {
        self.driveManager = [[AMapNaviDriveManager alloc] init];
        [self.driveManager setDelegate:self];
        
        [self.driveManager addDataRepresentative:self.driveView];
        [self.driveManager addDataRepresentative:self];
    }
}

- (void)initDriveView
{
    if (self.driveView == nil)
    {
        self.driveView = [[AMapNaviDriveView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 250)];
        [self.driveView setDelegate:self];
        
        //可以将导航界面的界面元素进行隐藏，然后通过自定义的控件展示导航信息
        [self.driveView setShowUIElements:NO];
        
        [self.view addSubview:self.driveView];
    }
}
#pragma mark serach初始化
//-(void)initSearch{
//    
//    _search =[[AMapSearchAPI alloc] init];
//    _search.delegate=self;
//    
//}

#pragma mark - Subviews

- (void)configSubViews
{
    self.turnRemainInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 260, CGRectGetWidth(self.view.bounds), 20)];
    self.turnRemainInfoLabel.textAlignment = NSTextAlignmentCenter;
    self.turnRemainInfoLabel.font = [UIFont systemFontOfSize:14];
    self.turnRemainInfoLabel.text = [NSString stringWithFormat:@"转向剩余距离"];
    [self.view addSubview:self.turnRemainInfoLabel];
    
    self.roadInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 280, CGRectGetWidth(self.view.bounds), 20)];
    self.roadInfoLabel.textAlignment = NSTextAlignmentCenter;
    self.roadInfoLabel.font = [UIFont systemFontOfSize:14];
    self.roadInfoLabel.text = [NSString stringWithFormat:@"道路信息"];
    [self.view addSubview:self.roadInfoLabel];
    
    self.routeRemainInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 300, CGRectGetWidth(self.view.bounds), 20)];
    self.routeRemainInfoLabel.textAlignment = NSTextAlignmentCenter;
    self.routeRemainInfoLabel.font = [UIFont systemFontOfSize:14];
    self.routeRemainInfoLabel.text = [NSString stringWithFormat:@"道路剩余信息"];
    [self.view addSubview:self.routeRemainInfoLabel];
    
    self.cameraInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 320, CGRectGetWidth(self.view.bounds), 20)];
    self.cameraInfoLabel.textAlignment = NSTextAlignmentCenter;
    self.cameraInfoLabel.font = [UIFont systemFontOfSize:14];
    self.cameraInfoLabel.text = [NSString stringWithFormat:@"电子眼信息"];
    [self.view addSubview:self.cameraInfoLabel];
    
    self.laneInfoView = [[UIImageView alloc] init];
    [self.laneInfoView setCenter:CGPointMake(160, 360)];
    [self.view addSubview:self.laneInfoView];
    
    self.crossImageView = [[UIImageView alloc] initWithFrame:CGRectMake(90, 390, 150, 100)];
    [self.view addSubview:self.crossImageView];
    
    self.trackingModeButton = [self createToolButton];
    [self.trackingModeButton setFrame:CGRectMake(0, 390, 80, 30)];
    [self.trackingModeButton setTitle:@"跟随模式" forState:UIControlStateNormal];
    [self.trackingModeButton addTarget:self action:@selector(trackingModeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.trackingModeButton];
    
    self.trafficLayerButton = [self createToolButton];
    [self.trafficLayerButton setFrame:CGRectMake(0, 430, 80, 30)];
    [self.trafficLayerButton setTitle:@"交通信息" forState:UIControlStateNormal];
    [self.trafficLayerButton addTarget:self action:@selector(trafficLayerAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.trafficLayerButton];
    
    self.showModeButton = [self createToolButton];
    [self.showModeButton setFrame:CGRectMake(0, 470, 80, 30)];
    [self.showModeButton setTitle:@"显示模式" forState:UIControlStateNormal];
    [self.showModeButton addTarget:self action:@selector(showModeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.showModeButton];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backButton setFrame:CGRectMake(200, 500, 50, 50)];
    [self.view addSubview:backButton];
}

- (UIButton *)createToolButton
{
    UIButton *toolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    toolBtn.layer.borderColor  = [UIColor lightGrayColor].CGColor;
    toolBtn.layer.borderWidth  = 0.5;
    toolBtn.layer.cornerRadius = 5;
    
    [toolBtn setBounds:CGRectMake(0, 0, 80, 30)];
    [toolBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    toolBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    
    return toolBtn;
}

#pragma mark - Button Action
-(void)back{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)trackingModeAction
{
    if (self.driveView.trackingMode == AMapNaviViewTrackingModeCarNorth)
    {
        self.driveView.trackingMode = AMapNaviViewTrackingModeMapNorth;
    }
    else if (self.driveView.trackingMode == AMapNaviViewTrackingModeMapNorth)
    {
        self.driveView.trackingMode = AMapNaviViewTrackingModeCarNorth;
    }
}

- (void)trafficLayerAction
{
    [self.driveView setShowTrafficLayer:!self.driveView.showTrafficLayer];
}

- (void)showModeAction
{
    if (self.driveView.showMode == AMapNaviDriveViewShowModeCarPositionLocked)
    {
        [self.driveView setShowMode:AMapNaviDriveViewShowModeNormal];
    }
    else if (self.driveView.showMode == AMapNaviDriveViewShowModeNormal)
    {
        [self.driveView setShowMode:AMapNaviDriveViewShowModeOverview];
    }
    else if (self.driveView.showMode == AMapNaviDriveViewShowModeOverview)
    {
        [self.driveView setShowMode:AMapNaviDriveViewShowModeCarPositionLocked];
    }
}

#pragma mark - Route Plan

- (void)calculateRoute
{
    [self.driveManager calculateDriveRouteWithStartPoints:@[self.startPoint]
                                                endPoints:@[self.endPoint]
                                                wayPoints:nil
                                          drivingStrategy:AMapNaviDrivingStrategyDefault];
}
//#pragma mark - 正向地理编码部分
//
//-(void)GeoCoding{
//    
//    if (_isOrigin == YES) {
//        if (self.startLocation) {
//            /**构建正向搜索对象*/
//            AMapGeocodeSearchRequest *request =[[AMapGeocodeSearchRequest alloc] init];
//            
//            request.address = self.startLocation;//设置正向编码地址
//            request.city    = self.currentCity;//设置当前搜索城市
//            [self.search AMapGeocodeSearch:request];
//            _isOrigin = NO;
//        }else{
//            return;
//        }
//        
//    }else{
//        if (self.endLocation) {
//            /**构建正向搜索对象*/
//            AMapGeocodeSearchRequest *request =[[AMapGeocodeSearchRequest alloc] init];
//            
//            request.address = self.endLocation;//设置正向编码地址
//            request.city    = self.currentCity;//设置当前搜索城市
//            [self.search AMapGeocodeSearch:request];
//            _isOrigin = YES;
//        }else{
//            return;
//        }
//        
//        
//        
//    }
//}
//
//- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response{
//    if (response.count == 0) {
//        return;
//    }
//    if (self.isOrigin == YES) {
//        AMapGeocode *p = (AMapGeocode *)response.geocodes[0];
//        self.startPoint = (AMapNaviPoint*)p.location;
//        NSLog(@"startPoint = %@",self.startPoint);
//    }
//    else{
//        AMapGeocode *p = (AMapGeocode *)response.geocodes[0];
//        
//        self.endPoint = (AMapNaviPoint *)p.location;
//        NSLog(@"destinationPoint = %@",self.endPoint);
//    }
//}
//

#pragma mark - AMapNaviDriveDataRepresentable

- (void)driveManager:(AMapNaviDriveManager *)driveManager updateNaviMode:(AMapNaviMode)naviMode
{
    NSLog(@"updateNaviMode:%ld", (long)naviMode);
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager updateNaviRouteID:(NSInteger)naviRouteID
{
    NSLog(@"updateNaviRouteID:%ld", (long)naviRouteID);
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager updateNaviRoute:(nullable AMapNaviRoute *)naviRoute
{
    NSLog(@"updateNaviRoute");
    
    _routeLength = naviRoute.routeLength;
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager updateNaviInfo:(nullable AMapNaviInfo *)naviInfo
{
    //转向剩余距离
    NSString *turnStr = [NSString stringWithFormat:@"%@ 后，转向类型:%ld", [self normalizedRemainDistance:naviInfo.segmentRemainDistance], (long)naviInfo.iconType];
    [self.turnRemainInfoLabel setText:turnStr];
    
    //道路信息
    NSString *roadStr = [NSString stringWithFormat:@"从 %@ 进入 %@", naviInfo.currentRoadName, naviInfo.nextRoadName];
    [self.roadInfoLabel setText:roadStr];
    
    //路径剩余信息
    NSString *routeStr = [NSString stringWithFormat:@"剩余距离:%@ 剩余时间:%@", [self normalizedRemainDistance:naviInfo.routeRemainDistance], [self normalizedRemainTime:naviInfo.routeRemainTime]];
    [self.routeRemainInfoLabel setText:routeStr];
    
    //距离最近的下个电子眼信息
    NSString *cameraStr = @"暂无";
    if (naviInfo.cameraDistance > 0)
    {
        if (naviInfo.cameraType == 0) cameraStr = [NSString stringWithFormat:@"测速(%ld)", (long)naviInfo.cameraLimitSpeed];
        else if (naviInfo.cameraType >= 1) cameraStr = @"监控";
    }
    [self.cameraInfoLabel setText:[NSString stringWithFormat:@"电子眼信息:%@", cameraStr]];
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager updateNaviLocation:(nullable AMapNaviLocation *)naviLocation
{
    NSLog(@"updateNaviLocation");
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager showCrossImage:(UIImage *)crossImage
{
    NSLog(@"showCrossImage");
    
    [self.crossImageView setImage:crossImage];
}

- (void)driveManagerHideCrossImage:(AMapNaviDriveManager *)driveManager
{
    NSLog(@"hideCrossImage");
    
    [self.crossImageView setImage:nil];
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager showLaneBackInfo:(NSString *)laneBackInfo laneSelectInfo:(NSString *)laneSelectInfo
{
    NSLog(@"showLaneInfo");
    
    UIImage *laneInfoImage = CreateLaneInfoImageWithLaneInfo(laneBackInfo, laneSelectInfo);
    
    [self.laneInfoView setImage:laneInfoImage];
    [self.laneInfoView setBounds:CGRectMake(0, 0, laneInfoImage.size.width, laneInfoImage.size.height)];
}

- (void)driveManagerHideLaneInfo:(AMapNaviDriveManager *)driveManager
{
    NSLog(@"hideLaneInfo");
    
    [self.laneInfoView setImage:nil];
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager updateTrafficStatus:(nullable NSArray<AMapNaviTrafficStatus *> *)trafficStatus
{
    NSLog(@"updateTrafficStatus");
}

#pragma mark - AMapNaviDriveManager Delegate

- (void)driveManager:(AMapNaviDriveManager *)driveManager error:(NSError *)error
{
    NSLog(@"error:{%ld - %@}", (long)error.code, error.localizedDescription);
}

- (void)driveManagerOnCalculateRouteSuccess:(AMapNaviDriveManager *)driveManager
{
    NSLog(@"onCalculateRouteSuccess");
    
    [self.driveManager startEmulatorNavi];
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager onCalculateRouteFailure:(NSError *)error
{
    NSLog(@"onCalculateRouteFailure:{%ld - %@}", (long)error.code, error.localizedDescription);
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager didStartNavi:(AMapNaviMode)naviMode
{
    NSLog(@"didStartNavi");
}

- (void)driveManagerNeedRecalculateRouteForYaw:(AMapNaviDriveManager *)driveManager
{
    NSLog(@"needRecalculateRouteForYaw");
}

- (void)driveManagerNeedRecalculateRouteForTrafficJam:(AMapNaviDriveManager *)driveManager
{
    NSLog(@"needRecalculateRouteForTrafficJam");
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager onArrivedWayPoint:(int)wayPointIndex
{
    NSLog(@"onArrivedWayPoint:%d", wayPointIndex);
}

- (void)driveManager:(AMapNaviDriveManager *)driveManager playNaviSoundString:(NSString *)soundString soundStringType:(AMapNaviSoundType)soundStringType
{
    NSLog(@"playNaviSoundString:{%ld:%@}", (long)soundStringType, soundString);
    
    [[SpeechSynthesizer sharedSpeechSynthesizer] speakString:soundString];
}

- (void)driveManagerDidEndEmulatorNavi:(AMapNaviDriveManager *)driveManager
{
    NSLog(@"didEndEmulatorNavi");
}

- (void)driveManagerOnArrivedDestination:(AMapNaviDriveManager *)driveManager
{
    NSLog(@"onArrivedDestination");
}

#pragma mark - AMapNaviDriveViewDelegate

- (void)driveView:(AMapNaviDriveView *)driveView didChangeShowMode:(AMapNaviDriveViewShowMode)showMode
{
    NSLog(@"didChangeShowMode:%ld", (long)showMode);
}

#pragma mark - Utility

- (NSString *)normalizedRemainDistance:(NSInteger)remainDistance
{
    if (remainDistance < 0)
    {
        return nil;
    }
    
    if (remainDistance >= 1000)
    {
        CGFloat kiloMeter = remainDistance / 1000.0;
        
        if (remainDistance % 1000 >= 100)
        {
            kiloMeter -= 0.05f;
            return [NSString stringWithFormat:@"%.1f公里", kiloMeter];
        }
        else
        {
            return [NSString stringWithFormat:@"%.0f公里", kiloMeter];
        }
    }
    else
    {
        return [NSString stringWithFormat:@"%ld米", (long)remainDistance];
    }
}

- (NSString *)normalizedRemainTime:(NSInteger)remainTime
{
    if (remainTime < 0)
    {
        return nil;
    }
    
    if (remainTime < 60)
    {
        return [NSString stringWithFormat:@"< 1分钟"];
    }
    else if (remainTime >= 60 && remainTime < 60*60)
    {
        return [NSString stringWithFormat:@"%ld分钟", (long)remainTime/60];
    }
    else
    {
        NSInteger hours = remainTime / 60 / 60;
        NSInteger minute = remainTime / 60 % 60;
        if (minute == 0)
        {
            return [NSString stringWithFormat:@"%ld小时", (long)hours];
        }
        else
        {
            return [NSString stringWithFormat:@"%ld小时%ld分钟", (long)hours, (long)minute];
        }
    }
}

@end
