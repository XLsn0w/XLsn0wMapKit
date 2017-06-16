//
//  ViewController.m
//  naviDemo
//
//  Created by 赵鹏 on 16/6/25.
//  Copyright © 2016年 zhaopeng. All rights reserved.
//

#import "ViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "NaviViewController.h"
#import "CustomNaviViewController.h"

#define APIKey @"df091ab08b4cededa8b26aa7d2839241"
@interface ViewController ()<MAMapViewDelegate,AMapSearchDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property (weak, nonatomic ) IBOutlet UILabel        *currentCity;

@property (weak, nonatomic ) IBOutlet UILabel        *myLocation;

@property (weak, nonatomic ) IBOutlet UITextField    *startLocation;

@property (weak, nonatomic ) IBOutlet UITextField    *endLocation;

@property (nonatomic,strong) NSMutableArray *startDataArray;
@property (nonatomic,strong) NSMutableArray *endDataArray;

@property(nonatomic,strong) NSString *search_tag;
@property(nonatomic,strong) NSString *search_tag2;

@property (nonatomic,assign) BOOL isOrigin;

@end

@implementation ViewController{
    
    MAMapView       * _mapView;//地图对象
    AMapSearchAPI   *_search;//搜索对象
    CLLocation      *_presentLocation;//当前坐标
    
    UITableView     * _startTableView;//开始位置下拉提示条
    UITableView     * _endTableView;//结束位置下拉提示条
   
    CLLocationCoordinate2D startPoint;
    CLLocationCoordinate2D endPoint;
}
#pragma mark -懒加载
-(NSMutableArray *)startDataArray
{
    if (_startDataArray==nil) {
        
        _startDataArray = @[].mutableCopy;
    }
    return _startDataArray;
}
-(NSMutableArray *)endDataArray
{
    if (_endDataArray==nil) {
        _endDataArray = @[].mutableCopy;
    }
    return _endDataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
     [AMapServices sharedServices].apiKey = APIKey;
    self.isOrigin = YES;
    [self initMapView];
    [self initSearch];
    [self creatUI];
    
}
-(void)creatUI
{
    
    _startTableView             = [[UITableView alloc] initWithFrame:CGRectMake(self.startLocation.frame.origin.x, self.startLocation.frame.origin.y+self.startLocation.frame.size.height, self.startLocation.frame.size.width, 200) style:UITableViewStylePlain];
    _startTableView.tag         = 101;
    _startTableView.dataSource  = self;
    _startTableView.delegate    = self;
    _startTableView.rowHeight   = 30 ;
    _startTableView.alpha       = 0;
    [self.view addSubview:_startTableView];
    self.startLocation.delegate = self;
    self.startLocation.tag      = 111;

    _endTableView               = [[UITableView alloc] initWithFrame:CGRectMake(self.endLocation.frame.origin.x, self.endLocation.frame.origin.y+self.endLocation.frame.size.height, self.endLocation.frame.size.width, 200) style:UITableViewStylePlain];
    _endTableView.tag           = 102;
    _endTableView.dataSource    = self;
    _endTableView.delegate      = self;
    _startTableView.rowHeight   = 30;
    _endTableView.alpha         = 0;
    [self.view addSubview:_endTableView];
    self.endLocation.delegate   = self;
    self.endLocation.tag        = 112;
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField.tag == 111) {
        [self.startDataArray removeAllObjects];
        self.search_tag       = @"1";
        [self lenoveSearch:self.startLocation.text];
        _startTableView.alpha = 1;

        dispatch_async(dispatch_get_main_queue(), ^{

            [_startTableView reloadData];
        });
    }else if (textField.tag == 112){
        [self.endDataArray removeAllObjects];
        self.search_tag       = @"2";
        [self lenoveSearch:self.endLocation.text];
        _endTableView.alpha   = 1;
    }

    return YES;
}

#pragma mark 地图显示和定位
-(void)initMapView{
    
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,self.view.frame.size.height/2.0f)];
    _mapView.delegate = self;
    
    _mapView.showsUserLocation = YES;    //YES 为打开定位，NO为关闭定位
    [_mapView setUserTrackingMode: MAUserTrackingModeFollow animated:YES];
    
}
#pragma mark serach初始化
-(void)initSearch{
    
    [AMapServices sharedServices].apiKey=APIKey;
    
    _search =[[AMapSearchAPI alloc] init];
    _search.delegate=self;
}
#pragma mark 定位更新回调
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //取出当前位置的坐标
        //        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    }
    _presentLocation = [userLocation.location copy];
    [self reGeoCoding];
    
    _mapView.showsUserLocation = NO;    //YES 为打开定位，NO为关闭定位
}
#pragma mark 逆地理编码
-(void)reGeoCoding{
    
    if (_presentLocation) {
        
        AMapReGeocodeSearchRequest *request =[[AMapReGeocodeSearchRequest alloc] init];
        
        request.location =[AMapGeoPoint locationWithLatitude:_presentLocation.coordinate.latitude longitude:_presentLocation.coordinate.longitude];
        
        [_search AMapReGoecodeSearch:request];
    }
    
}
#pragma mark 搜索请求发起后的回调
/**失败回调*/
-(void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error{
    
    NSLog(@"request: %@------error:  %@",request,error);
}
/**成功回调*/
-(void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response{
    
    //我们把编码后的地理位置，显示到 标签上
    self.currentCity.text = response.regeocode.addressComponent.city;
    if (self.currentCity.text.length == 0) {
        
        self.currentCity.text = response.regeocode.addressComponent.province;
        
    }
    
    self.myLocation.text =[NSString stringWithFormat:@"%@",response.regeocode.formattedAddress];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.startLocation resignFirstResponder];
    [self.endLocation resignFirstResponder];
    
    _startTableView.alpha = 0;
    _endTableView.alpha = 0;
}
#pragma mark 处理输入联想
-(void)lenoveSearch:(NSString *)keywords{
    //构造AMapInputTipsSearchRequest对象，设置请求参数
    AMapInputTipsSearchRequest *tipsRequest = [[AMapInputTipsSearchRequest alloc] init];
    //    tipsRequest.keywords = self.proprietorName.text;
    tipsRequest.keywords = keywords;
    tipsRequest.city = self.currentCity.text;
    
    //发起输入提示搜索
    [_search AMapInputTipsSearch: tipsRequest];
    
}

//实现输入提示的回调函数
-(void)onInputTipsSearchDone:(AMapInputTipsSearchRequest*)request response:(AMapInputTipsSearchResponse *)response
{
    if(response.tips.count == 0)
    {
        return;
    }
    
    //通过AMapInputTipsSearchResponse对象处理搜索结果
    
    for (AMapTip *p in response.tips) {
        if ([self.search_tag isEqualToString:@"1"]) {
            [self.startDataArray addObject:p.name];
        
            dispatch_async(dispatch_get_main_queue(), ^{
            
                [_startTableView reloadData];
            });
        }else if ([self.search_tag isEqualToString:@"2"]){
            [self.endDataArray addObject:p.name];
        
            dispatch_async(dispatch_get_main_queue(), ^{
            
            [_endTableView reloadData];
            });
        }
 
    }
   
}
#pragma mark -正向地理编码
-(void)GeoCoding1{
    self.search_tag2 = @"3";
    if (self.endLocation.text) {
            /**构建正向搜索对象*/
            AMapGeocodeSearchRequest *request =[[AMapGeocodeSearchRequest alloc] init];
            
            request.address = self.endLocation.text;//设置正向编码地址
            request.city    = self.currentCity.text;//设置当前搜索城市
            [_search AMapGeocodeSearch:request];
    }else{
            return;
    }
}
-(void)GeoCoding{
        /**构建正向搜索对象*/
        AMapGeocodeSearchRequest *request =[[AMapGeocodeSearchRequest alloc] init];
                self.search_tag2 = @"1";
        request.address = self.startLocation.text;//设置正向编码地址
        request.city    = self.currentCity.text;//设置当前搜索城市

        [_search AMapGeocodeSearch:request];
        
}
//搜索成功回调
- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response{
    if (response.count == 0) {
        return;
    }
    if ([self.search_tag2 isEqualToString:@"1"]) {
        AMapGeocode *p       = (AMapGeocode *)response.geocodes[0];

        startPoint.latitude  = p.location.latitude;
        startPoint.longitude = p.location.longitude;
        /**构建正向搜索对象*/
        AMapGeocodeSearchRequest *request2 =[[AMapGeocodeSearchRequest alloc] init];
        request2.address = self.endLocation.text;//设置正向编码地址
        request2.city    = self.currentCity.text;//设置当前搜索城市
        self.search_tag2 = @"2";
        [_search AMapGeocodeSearch:request2];

        NSLog(@"start %f ---%f",startPoint.latitude,startPoint.longitude);
    }else if([self.search_tag2 isEqualToString:@"2"]){
        AMapGeocode *p       = (AMapGeocode *)response.geocodes[0];
        endPoint.latitude    = p.location.latitude;
        endPoint.longitude   = p.location.longitude;
        NSLog(@"end %f ---%f",endPoint.latitude,endPoint.longitude);

    }else if([self.search_tag2 isEqualToString:@"3"]){
        AMapGeocode *p       = (AMapGeocode *)response.geocodes[0];
        endPoint.latitude    = p.location.latitude;
        endPoint.longitude   = p.location.longitude;

    }
}

- (IBAction)lockAction:(UIButton *)sender {
    if (self.startLocation.text.length>0 && self.endLocation.text.length>0){
        [self GeoCoding];
    }else if(self.startLocation.text.length==0 && self.endLocation.text.length>0){
        [self GeoCoding1];
    }
    
}

/**刷新位置信息*/
- (IBAction)refreshAction:(UIButton *)sender {
    _mapView.showsUserLocation = YES;    //YES 为打开定位，NO为关闭定位
    [self initSearch];

}
- (IBAction)fromCurentLocationToEndLocation:(UIButton *)sender {
    
    
    CustomNaviViewController *naviVC =[[CustomNaviViewController alloc] init];
    
    naviVC.startPoint =  [AMapNaviPoint locationWithLatitude:_presentLocation.coordinate.latitude longitude:_presentLocation.coordinate.longitude];
    naviVC.endPoint   = [AMapNaviPoint locationWithLatitude:endPoint.latitude longitude:endPoint.longitude];
    [self presentViewController:naviVC animated:YES completion:nil];
    
}
- (IBAction)fromStartLocationToEndLocation:(UIButton *)sender {
    CustomNaviViewController *naviVC =[[CustomNaviViewController alloc] init];
    
    naviVC.startPoint =  [AMapNaviPoint locationWithLatitude:startPoint.latitude longitude:startPoint.longitude];
    NSLog(@"startPoint %f ---%f",startPoint.latitude,startPoint.longitude);
    naviVC.endPoint   = [AMapNaviPoint locationWithLatitude:endPoint.latitude longitude:endPoint.longitude];
    NSLog(@"endPoint %f ---%f",endPoint.latitude,endPoint.longitude);

    [self presentViewController:naviVC animated:YES completion:nil];
    
}
#pragma mark UITableViewDelegate &&UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView.tag == 101) {
        NSLog(@"dataArray.count = %ld",self.startDataArray.count);
        return self.startDataArray.count;
    }else if (tableView.tag == 102){
        return self.endDataArray.count;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 101) {
        static NSString *cellID = @"cellID";
        
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (cell==nil) {
            
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        
        cell.textLabel.text = self.startDataArray[indexPath.row];
        
        
        return cell;

    }
    if (tableView.tag == 102) {
        static NSString *cellID = @"cellID";
        
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (cell==nil) {
            
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        
        cell.textLabel.text = self.endDataArray[indexPath.row];
        
        
        return cell;

    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 101) {
        self.startLocation.text = self.startDataArray[indexPath.row];
        
        [self.startLocation resignFirstResponder];
        _startTableView.alpha=0;
    }else if (tableView.tag == 102){
        self.endLocation.text = self.endDataArray[indexPath.row];
        
        [self.endLocation resignFirstResponder];
        _endTableView.alpha=0;
    }
    
}



@end
