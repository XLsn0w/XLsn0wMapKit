//
//  ScanViewController.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/18.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "ScanViewController.h"
#import "CameraSwitchButton.h"
#import <AVFoundation/AVFoundation.h>
#import "ScanTabbarView.h"
#import "ScanView.h"


#define CornerFoucesWidth   16
#define ScanTabbarHeight    80

@interface ScanViewController ()<ScanTabbarViewDelegate,ScanViewDelegate,AVCaptureMetadataOutputObjectsDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIViewControllerDelegate>

// 切换摄像头按钮
@property (nonatomic, strong) CameraSwitchButton   *switchCameraButton;
// 扫描完成声音
@property (nonatomic, strong) AVAudioPlayer        *beepPlayer;
// 扫描Tab栏
@property (nonatomic, strong) ScanTabbarView       *scanTabbar;
// 扫描视图
@property (nonatomic, strong) ScanView             *cameraView;
// 扫描条
@property (nonatomic, strong) UIImageView          *scanLine;
// 扫描提示标题
@property (nonatomic, strong) UILabel              *tipText;
// 扫描提示文字
@property (nonatomic, strong) UILabel              *popText;
// 扫描定时器
@property (nonatomic, strong) NSTimer              *timerScan;
// 取消按钮
@property (strong, nonatomic) UIButton             *cancelButton;
// 闪光灯按钮
@property (strong, nonatomic) UIButton             *lightButton;
// 闪光灯状态
@property (nonatomic,assign) BOOL                   isOn;
// 闪光灯提示
@property (nonatomic, strong) UILabel              *lightPopText;

// 视频预览
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
// 摄像头输出
@property (nonatomic, strong) AVCaptureMetadataOutput    *metadataOutput;
// 前置摄像头输入
@property (nonatomic, strong) AVCaptureDeviceInput       *frontDeviceInput;
// 前置摄像头
@property (nonatomic, strong) AVCaptureDevice            *frontDevice;
// 摄像头设备输入
@property (nonatomic, strong) AVCaptureDeviceInput       *defaultDeviceInput;
// 摄像头设备
@property (nonatomic, strong) AVCaptureDevice            *defaultDevice;
// 摄像头会话
@property (nonatomic, strong) AVCaptureSession           *session;

// 闪光灯
@property (nonatomic, strong) AVCaptureDevice            *lightDevice;

// 完成块操作
@property (nonatomic, copy) void (^completionBlock) (NSString * resultAsString);

@end

@implementation ScanViewController

#pragma mark - 懒加载 -------------------------------------------------------
- (ScanTabbarView *)scanTabbar{
    if(!_scanTabbar){
        _scanTabbar = [[ScanTabbarView alloc] initWithFrame:CGRectMake(0, self.view.height - ScanTabbarHeight, self.view.width, ScanTabbarHeight)];
        [self.view addSubview:_scanTabbar];
    }
    return _scanTabbar;
}

- (ScanView *)cameraView{
    if(!_cameraView){
        _cameraView = [[ScanView alloc] init];
#warning mark - 添加到取景器中的view，一定要取消自动布局 --------------------------
        _cameraView.translatesAutoresizingMaskIntoConstraints = NO;
        _cameraView.clipsToBounds                             = YES;
        [self.view addSubview:_cameraView];
    }
    return _cameraView;
}

- (AVAudioPlayer *)beepPlayer{
    if(!_beepPlayer){
        NSString * wavPath = [[NSBundle mainBundle] pathForResource:@"beep" ofType:@"wav"];
        NSData* data = [[NSData alloc] initWithContentsOfFile:wavPath];
        _beepPlayer = [[AVAudioPlayer alloc] initWithData:data error:nil];
    }
    return _beepPlayer;
}

- (UIButton *)cancelButton{
    if(!_cancelButton){
        _cancelButton = [[UIButton alloc] init];
        [_cancelButton setHidden: YES];
#warning mark - 添加到取景器中的view，一定要取消自动布局 --------------------------
        [_cancelButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [self.view addSubview:_cancelButton];
    }
    return _cancelButton;
}

- (CameraSwitchButton *)switchCameraButton{
    if(!_switchCameraButton){
        _switchCameraButton = [[CameraSwitchButton alloc] init];
        [_switchCameraButton setTranslatesAutoresizingMaskIntoConstraints:false];
        [_switchCameraButton addTarget:self action:@selector(switchCameraAction:) forControlEvents:UIControlEventTouchUpInside];
      
    }
    
    return _switchCameraButton;
}

- (AVCaptureDevice *)lightDevice{
    if(!_lightDevice){
        _lightDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    
    return _lightDevice;
}
#pragma mark -- 控制器方法 ---------------------------------------------------------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor blackColor]];
    [self.navigationItem setTitle:@"二维码/条码"];
    [self createQrCodeReader];
    
}

// 创建一个二维码扫描者
- (void)createQrCodeReader{
    
    // 1.初始化摄像头模组
    [self setupAVComponents];
    // 2.配置摄像头模组
    [self configureDefaultComponents];
    // 3.配置扫描视图界面
    [self setupScanView];
    // 4.配置相关画面参数
    [self setupAutoLayoutConstraints];
    
    [_cameraView.layer insertSublayer:self.previewLayer atIndex:0];
    
   //4. 配置输出结果的执行方法,如果没有配置采用默认方法
    if(!self.modalPresentationStyle){
        self.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    
    if(!self.completionBlock){
        
        weak_self weakSelf = self;
        [self setCompletionBlock:^(NSString * resultAsString) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:resultAsString preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
                 [weakSelf startScanning];
            }]];
            
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }];
    }
    
}

#pragma mark -- 界面设置相关 --------------------------------------------------------------------
- (void)setupScanView{
    
    [self.cameraView setDelegate:self];
    
    [self addScanTabbar];
    [self addScanFouces];
    
    if(_frontDevice){
        [self.view addSubview:self.switchCameraButton];
    }
    
    [self.cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(clickEnterPhotoLibrary)];
}

#pragma mark - 扫描区基准边框与文字 -----------------------------------------------------------------

- (void)addScanFouces{
    CGFloat s_height = self.view.height - 40;
    CGFloat y = (s_height - CameraScanAreaWidth) / 2 - s_height / 6;
    
    UIImageView* image1 = [[UIImageView alloc] initWithFrame:CGRectMake(49, y + 76, CornerFoucesWidth, CornerFoucesWidth)];
    image1.image = [UIImage imageNamed:@"ScanQR1"];
    [self.view addSubview:image1];
    
    UIImageView* image2 = [[UIImageView alloc] initWithFrame:CGRectMake(35 + CameraScanAreaWidth, y + 76, CornerFoucesWidth, CornerFoucesWidth)];
    image2.image = [UIImage imageNamed:@"ScanQR2"];
    [self.view addSubview:image2];
    
    UIImageView* image3 = [[UIImageView alloc] initWithFrame:CGRectMake(49, y + CameraScanAreaWidth + 64, CornerFoucesWidth, CornerFoucesWidth)];
    image3.image = [UIImage imageNamed:@"ScanQR3"];
    [self.view addSubview:image3];
    
    UIImageView* image4 = [[UIImageView alloc] initWithFrame:CGRectMake(35 + CameraScanAreaWidth, y + CameraScanAreaWidth + 64, CornerFoucesWidth, CornerFoucesWidth)];
    image4.image = [UIImage imageNamed:@"ScanQR4"];
    [self.view addSubview:image4];
    
    
    UIImageView *scanLine = [[UIImageView alloc] init];
    scanLine.image = [UIImage imageNamed:@"ff_QRCodeScanLine"];
    [self.view addSubview:scanLine];
    self.scanLine = scanLine;
    
    
    UILabel *popText = [[UILabel alloc] initWithFrame:CGRectMake(0,y + 90 + CameraScanAreaWidth, self.view.width, 15)];
    popText.text = @"将二维码/条码放入框内 即可自动扫描";
    popText.textColor = [UIColor whiteColor];
    popText.font = [UIFont systemFontOfSize:12];
    popText.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:popText];
    self.popText = popText;
    
    UILabel *tipText = [[UILabel alloc] initWithFrame:CGRectMake(0,y + 150 + CameraScanAreaWidth, self.view.width, 15)];
    tipText.text = @"我的二维码";
    tipText.textColor = [UIColor greenColor];
    tipText.font = [UIFont systemFontOfSize:14];
    tipText.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tipText];
    self.tipText = tipText;
    
    UIButton *lightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [lightButton setFrame:CGRectMake((self.view.width - 14)*0.5, y + 20 + CameraScanAreaWidth, 14, 25)];
    [lightButton setImage:[UIImage imageNamed:@"ScanLowLight"] forState:UIControlStateNormal];
    [lightButton setImage:[UIImage imageNamed:@"ScanLowLight_HL"] forState:UIControlStateSelected];
    [lightButton addTarget:self action:@selector(lightTorchSwitch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:lightButton];
    self.lightButton = lightButton;
    
    UILabel *lightPopText = [[UILabel alloc] initWithFrame:CGRectMake(0,y + 45 + CameraScanAreaWidth, self.view.width, 20)];
    lightPopText.text = @"轻触照亮";
    lightPopText.textColor = [UIColor whiteColor];
    lightPopText.font = [UIFont systemFontOfSize:12];
    lightPopText.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lightPopText];
    self.popText = lightPopText;
    
}

#pragma mark - 扫描栏 -------------------------------------------------------------------
- (void)addScanTabbar{
    NSArray *ScanTabbarImageNames = @[@"ScanQRCode",@"ScanBook",@"ScanStreet",@"ScanWord"];
    NSArray *ScanTabBarItemNames = @[@"扫码",@"封面",@"街景",@"翻译"];
    
    [self.scanTabbar setDelegate:self];
    
    [self addScanTabBarItemWithItemNum:ScanTabBarItemNames.count andNameArray:ScanTabBarItemNames andImageNameArray:ScanTabbarImageNames];
}



- (void)addScanTabBarItemWithItemNum:(NSInteger) buttonItemNumber andNameArray:(NSArray *) nameArray andImageNameArray:(NSArray *) imageNameArray{
    
    for(NSInteger i = 0;i < buttonItemNumber;i++){
        [self.scanTabbar addScanBarButtonItemsWithImageName:[NSString stringWithFormat:@"%@",imageNameArray[i]] selcetedImageName:[NSString stringWithFormat:@"%@_HL",imageNameArray[i]] titleText:[nameArray objectAtIndex:i]];
    }
}
#pragma mark - 视图加载与退出 -------------------------------------------
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self startScanning];
}

- (void)viewDidDisappear:(BOOL)animated{
    [self stopScanning];
    
    [super viewWillDisappear:animated];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    _previewLayer.frame = self.view.bounds;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

// 取消按钮
- (void)cancelAction:(UIButton *)button
{
    [self stopScanning];
    
    if (self.completionBlock) {
        self.completionBlock(nil);
    }
}

// 切换摄像头
- (void)switchCameraAction:(UIButton *)button
{
    [self switchDeviceInput];
}

// 开闪光灯
- (void)lightTorchSwitch:(UIButton *)button{
    NSError *error;
    
    if(self.lightDevice.hasTorch){
         _isOn = !_isOn;
        [button setSelected:_isOn];
        
        if(_isOn){
            self.lightPopText.text = @"轻触关闭";
        }else{
            self.lightPopText.text = @"轻触照亮";
        }
        
        if(![self.lightDevice lockForConfiguration:&error]){
            if(error){
                DebugLog(@"闪光灯故障！");
            }
            
            return;
        }
        
        self.lightDevice.torchMode = (self.lightDevice.torchMode == AVCaptureTorchModeOff ? AVCaptureTorchModeOn : AVCaptureTorchModeOff);
        
        [self.lightDevice unlockForConfiguration];
    }
}
#pragma mark - 扫码方法 -------------------------------------------------
- (void)startScanning{
    // 1.启动摄像头会话
    if (![self.session isRunning]) {
        [self.session startRunning];
    }
    
    // 2.重置定时器
    if(_timerScan)
    {
        [_timerScan invalidate];
        _timerScan = nil;
    }
    
    // 3.定时器Target
    _timerScan = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(scanAnimate) userInfo:nil repeats:YES];
}

- (void)stopScanning{
    
    DebugLog(@"停止扫描啦 ----%s",__func__);
    // 1.停止摄像头会话
    if ([self.session isRunning]) {
        [self.session stopRunning];
    }
    
    // 2.关闭定时器
    if(_timerScan)
    {
        [_timerScan invalidate];
        _timerScan = nil;
    }
}

// 移动扫描条动画
- (void)scanAnimate
{
//       DebugLog(@"开始扫描，扫描动画 ----%s",__func__);
    self.scanLine.frame = CGRectMake(0, self.cameraView.innerViewRect.origin.y, self.view.width, 12);
    
    [UIView animateWithDuration:2 animations:^{
        self.scanLine.frame = CGRectMake(self.scanLine.x, self.scanLine.y + self.cameraView.innerViewRect.size.height - 6, self.scanLine.width,self.scanLine.height);
    }];
}
#pragma mark - 摄像头视频采集相关 -----------------------------------------------------
+ (AVCaptureVideoOrientation)videoOrientationFromInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    switch (interfaceOrientation) {
        case UIInterfaceOrientationLandscapeLeft:
            return AVCaptureVideoOrientationLandscapeLeft;
        case UIInterfaceOrientationLandscapeRight:
            return AVCaptureVideoOrientationLandscapeRight;
        case UIInterfaceOrientationPortrait:
            return AVCaptureVideoOrientationPortrait;
        default:
            return AVCaptureVideoOrientationPortraitUpsideDown;
    }
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    [self.cameraView setNeedsDisplay];
    
    if (self.previewLayer.connection.isVideoOrientationSupported) {
        self.previewLayer.connection.videoOrientation = [[self class] videoOrientationFromInterfaceOrientation:toInterfaceOrientation];
    }
}

#pragma mark - 摄像头设备配置相关 ------------------------------------------------------
- (void)setupAutoLayoutConstraints
{
    NSDictionary *views = NSDictionaryOfVariableBindings(_cameraView, _cancelButton);
    
    [self.view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_cameraView][_cancelButton(0)]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_cameraView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_cancelButton]-|" options:0 metrics:nil views:views]];
    
    if (_switchCameraButton) {
        NSDictionary *switchViews = NSDictionaryOfVariableBindings(_switchCameraButton);
        
        [self.view addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_switchCameraButton(50)]" options:0 metrics:nil views:switchViews]];
        [self.view addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_switchCameraButton(70)]|" options:0 metrics:nil views:switchViews]];
    }
}

- (void)setupAVComponents
{
    self.defaultDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    if (_defaultDevice) {
        self.defaultDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:_defaultDevice error:nil];
        self.metadataOutput     = [[AVCaptureMetadataOutput alloc] init];
        self.session            = [[AVCaptureSession alloc] init];
        self.previewLayer       = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
        
        for (AVCaptureDevice *device in [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo]) {
            if (device.position == AVCaptureDevicePositionFront) {
                self.frontDevice = device;
            }
        }
        
        if (_frontDevice) {
            self.frontDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:_frontDevice error:nil];
        }
    }
}

- (void)configureDefaultComponents
{
    [_session addOutput:_metadataOutput];
    
    if (_defaultDeviceInput) {
        [_session addInput:_defaultDeviceInput];
    }
    
    [_metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    if ([[_metadataOutput availableMetadataObjectTypes] containsObject:AVMetadataObjectTypeQRCode]) {
        [_metadataOutput setMetadataObjectTypes:@[ AVMetadataObjectTypeQRCode ]];
    }
    [_previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_previewLayer setFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    
    if ([_previewLayer.connection isVideoOrientationSupported]) {
        
        _previewLayer.connection.videoOrientation = [[self class] videoOrientationFromInterfaceOrientation:self.interfaceOrientation];
        
    }
}

- (void)switchDeviceInput
{
    if (_frontDeviceInput) {
        [_session beginConfiguration];
        
        AVCaptureDeviceInput *currentInput = [_session.inputs firstObject];
        [_session removeInput:currentInput];
        
        AVCaptureDeviceInput *newDeviceInput = (currentInput.device.position == AVCaptureDevicePositionFront) ? _defaultDeviceInput : _frontDeviceInput;
        [_session addInput:newDeviceInput];
        
        [_session commitConfiguration];
    }
}

#pragma mark - 摄像头视频输出代理方法 ---------------------------------------------------
// 扫描结果输出方法
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    for(AVMetadataObject *current in metadataObjects) {
        if ([current isKindOfClass:[AVMetadataMachineReadableCodeObject class]]
            && [current.type isEqualToString:AVMetadataObjectTypeQRCode])
        {
            NSString *scannedResult = [(AVMetadataMachineReadableCodeObject *) current stringValue];
            
            // 停止扫描
            [self stopScanning];
            
            // 执行用户block
            if (self.completionBlock) {
                [self.beepPlayer play];
                self.completionBlock(scannedResult);
            }
            
            // 执行代理方法
            if ([self.delegate respondsToSelector:@selector(reader:didScanResult:)]) {
                [self.delegate reader:self didScanResult:scannedResult];
            }
            
            break;
        }
    }
}

// 检查设备是否就绪
+ (BOOL)isAvailable
{
    @autoreleasepool {
        AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        if (!captureDevice) {
            return NO;
             DebugLog(@"No captureDevice");
        }
        
        NSError *error;
        AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
        
        if (!deviceInput || error) {
             DebugLog(@"No DeviceInput or error");
            return NO;
        }
        
        AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
        
        if (![output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeQRCode]) {
             DebugLog(@"No containObject!");
            return NO;
        }
        
        return YES;
    }
}


#pragma mark - 扫描视图的代理方法 ------------------------------------------------------

- (void)scanViewLoadView:(CGRect)rect{
    self.scanLine.frame = CGRectMake(0, self.cameraView.innerViewRect.origin.y, self.view.width, 12);
    [self scanAnimate];
}

#pragma mark - 相册访问 --------------------------------------------------------------
- (void)clickEnterPhotoLibrary{
    UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
    photoPicker.delegate = self;
    photoPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    photoPicker.view.backgroundColor = [UIColor whiteColor];
    [self presentViewController:photoPicker animated:YES completion:NULL];
}


#pragma mark - ScanTabbar 代理方法 ----------------------------------------------------

- (void)scanTabbarView:(ScanTabbarView *)tabBarView didSelectedScanBarButtonItemAtIndex:(NSInteger)index{
    switch (index) {
        case 0:{
            [self.navigationItem setTitle:@"二维码/条码"];
        }break;
        case 1:{
            [self.navigationItem setTitle:@"封面/电影海报"];
        }break;
        case 2:{
            [self.navigationItem setTitle:@"街景"];
        }break;
        case 3:{
            [self.navigationItem setTitle:@"翻译"];
        }break;
        default:
            break;
    }
}

#pragma mark - 图片识别二维码 ------------------------------------------------------------------
- (NSString *)ScanQRReaderForImage:(UIImage *)QRImage{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:context options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];

    
    CIImage *image = [CIImage imageWithCGImage:QRImage.CGImage];
    NSArray *features = [detector featuresInImage:image];
    CIQRCodeFeature *feature = [features firstObject];
    NSString *result = feature.messageString;
    
    return result;
}

#pragma mark - image picker 的代理方法
- ( void )imagePickerController:( UIImagePickerController *)picker didFinishPickingMediaWithInfo:( NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
   
    UIImage *srcImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSString *result = [self ScanQRReaderForImage:srcImage];
    
    if (self.completionBlock) {
        self.completionBlock(result);
    }
    else{
        DebugLog(@"没有收到扫描结果，看看是不是没有实现协议！");
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 导航栏返回按钮返回代理方法 ----------------------------------------------------------

- (void)baseUIViewDidListenNavigationShouldPopOnByBackButton{
    [self stopScanning];
    DebugLog(@"扫描退出啦----%s",__func__);
}

@end
