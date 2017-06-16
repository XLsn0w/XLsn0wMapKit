

#import "AliMapViewSystemNaviDriveController.h"

@interface AliMapViewSystemNaviDriveController () <AMapNaviDriveViewDelegate, AMapNaviDriveManagerDelegate>

@property (strong ,nonatomic) AMapNaviDriveView *naviDriveView;       //导航界面
@property (strong ,nonatomic) AMapNaviDriveManager *naviDriveManager; //导航管理者


@end

@implementation AliMapViewSystemNaviDriveController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDriveView];
    [self initDriveManager];
}

- (void)initDriveView {//初始化导航界面
    self.naviDriveView = [[AMapNaviDriveView alloc] initWithFrame:CGRectMake(0,64, kScreenWidth, kScreenHeight-64)];
    self.naviDriveView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.naviDriveView.showTrafficButton = YES;
    self.naviDriveView.delegate = self;
    [self.view addSubview:self.naviDriveView];
}

- (void)initDriveManager {//初始化导航管理者
    self.naviDriveManager = [[AMapNaviDriveManager alloc] init];
    self.naviDriveManager.delegate = self;
    
    
    //设置驾车出行路线规划
    [self.naviDriveManager calculateDriveRouteWithStartPoints:@[self.startPoint]
                                                    endPoints:@[self.endPoint]
                                                    wayPoints:nil
                                              drivingStrategy:AMapNaviDrivingStrategyMultipleAvoidHighwayAndCostAndCongestion];
    //将driveView添加为导航数据的Representative，使其可以接收到导航诱导数据
    [self.naviDriveManager addDataRepresentative:self.naviDriveView];
}

#pragma mark -  AMapNaviDriveViewDelegate
/**
 *  导航界面关闭按钮点击时的回调函数
 */
- (void)driveViewCloseButtonClicked:(AMapNaviDriveView *)driveView {
    NSLog(@"%s",__func__);
}

/**
 *  导航界面更多按钮点击时的回调函数
 */
- (void)driveViewMoreButtonClicked:(AMapNaviDriveView *)driveView {
    NSLog(@"%s",__func__);
}

/**
 *  导航界面转向指示View点击时的回调函数
 */
- (void)driveViewTrunIndicatorViewTapped:(AMapNaviDriveView *)driveView {
    NSLog(@"%s",__func__);
}

/**
 *  导航界面显示模式改变后的回调函数
 *
 *  @param showMode 显示模式
 */
- (void)driveView:(AMapNaviDriveView *)driveView didChangeShowMode:(AMapNaviDriveViewShowMode)showMode{
    NSLog(@"%s",__func__);
}

/**
 *  获取导航界面上路线显示样式的回调函数
 *
 *  @param naviRoute 当前界面的路线信息
 *  @return AMapNaviRoutePolylineOption 路线显示样式
 */
- (AMapNaviRoutePolylineOption *)driveView:(AMapNaviDriveView *)driveView needUpdatePolylineOptionForRoute:(AMapNaviRoute *)naviRoute{
    return nil;
}

#pragma mark - AMapNaviDriveManagerDelegate
//驾车路径规划成功后的回调函数
- (void)driveManagerOnCalculateRouteSuccess:(AMapNaviDriveManager *)driveManager {
    NSLog(@"onCalculateRouteSuccess");
    
    //算路成功后开始GPS导航
    [self.self.naviDriveManager startGPSNavi];
    
    //算路成功后进行模拟导航
//    [self.naviDriveManager startEmulatorNavi];
    [self.naviDriveManager setEmulatorNaviSpeed:80];
}

@end
