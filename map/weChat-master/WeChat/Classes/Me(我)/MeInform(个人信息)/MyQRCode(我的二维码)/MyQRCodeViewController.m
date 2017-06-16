//
//  MyQRCodeViewController.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/19.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "MyQRCodeViewController.h"
#import "PopupController.h"
#import "UIImage+QRCode.h"


@interface MyQRCodeViewController ()<PopupControllerDelegate>
@property (nonatomic,strong) PopupController *popUpController;
@end

@implementation MyQRCodeViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self showPopupWithStyle:PopupStyleCentered];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_more"] style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClick)];
    self.navigationItem.rightBarButtonItem = right;
}

- (void)showPopupWithStyle:(PopupStyle)popupStyle {
    
    NSMutableParagraphStyle *paragraphStyle = NSMutableParagraphStyle.new;
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    PersionModel *data = [PersionModel sharedPersionModel];
    UIImage *icon = [[UIImage alloc] init];
    if(icon){
        icon = data.headIcon;
    }else{
        icon = [UIImage imageNamed:@"DefaultProfileHead"];
    }
   
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:data.name attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:18], NSParagraphStyleAttributeName : paragraphStyle}];
    NSAttributedString *lineOne = [[NSAttributedString alloc] initWithString:@"广东 广州" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12], NSParagraphStyleAttributeName : paragraphStyle}];
    NSAttributedString *lineTwo = [[NSAttributedString alloc] initWithString:@"扫一扫上面的二维码图案，加我微信" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12], NSForegroundColorAttributeName : [UIColor colorWithRed:0.46 green:0.8 blue:1.0 alpha:1.0], NSParagraphStyleAttributeName : paragraphStyle}];
    
   
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 240, 70)];
    customView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *headIconView = [[UIImageView alloc] initWithImage:icon];
    [headIconView setSize:CGSizeMake(70, 70)];
    [customView addSubview:headIconView];
    

    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.numberOfLines = 0;
    nameLabel.attributedText = title;
    
    [nameLabel setSize:CGSizeMake(0, 30)];
    [nameLabel sizeLevelHeight:30];
    [nameLabel leftOffSetTo:headIconView withOffset:10];
    [nameLabel topOffSetFrom:customView withOffset:10];
    
    [customView addSubview:nameLabel];
    
    NSString *gender = nil;
    if([data.gender isEqualToString:@"男"]){
        gender = @"Contact_Male";
    }else{
        gender = @"Contact_Female";
    }
    
    UIImageView *genderIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:gender]];
    [genderIconView setSize:CGSizeMake(18, 18)];
    [genderIconView leftOffSetTo:nameLabel withOffset:0];
    [genderIconView equalCenterYTo:nameLabel];
    
    [customView addSubview:genderIconView];
    
    
    UILabel *addressLabel = [[UILabel alloc] init];
    addressLabel.numberOfLines = 0;
    addressLabel.attributedText = lineOne;
    
    [addressLabel setSize:CGSizeMake(80, 20)];
    [addressLabel sizeLevelHeight:20];
    [addressLabel leftEqualTo:nameLabel];
    [addressLabel topOffSetTo:nameLabel withOffset:14];
    
    [customView addSubview:addressLabel];
    
    UIView *QRCodeImageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 240, 240)];
    QRCodeImageView.backgroundColor = [UIColor whiteColor];
    
   
    
    UIImage * image = [UIImage imageOfQRFromURL: [NSString stringWithFormat:@"https://weixin.qq.com/r/%@",data.wechatID] codeSize: 1000 red: 0 green: 0 blue: 0 insertImage: icon roundRadius: 15.0f];
    CGSize size = image.size;  
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:  ((CGRect){(CGPointZero), (size)})];
    imageView.size = CGSizeMake(210, 210);
    imageView.center = QRCodeImageView.center;
    imageView.image = image;
    [QRCodeImageView addSubview: imageView];
    
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 240, 20)];
    bottomView.backgroundColor = [UIColor whiteColor];
    UILabel *noticeLabel = [[UILabel alloc] init];
    noticeLabel.numberOfLines = 0;
    noticeLabel.attributedText = lineTwo;
    
    [noticeLabel setSize:CGSizeMake(220, 20)];
    [noticeLabel sizeLevelHeight:20];
    [noticeLabel leftOffSetFrom:bottomView withOffset:20];
    [noticeLabel topOffSetFrom:bottomView withOffset:0];
    [bottomView addSubview:noticeLabel];
    
   
    self.popUpController = [[PopupController alloc] initWithContents:@[customView,QRCodeImageView,bottomView] andFrameRect:self.view.frame andPopupMode:PopupModeWithNavigationbar andSupperKeyboard:NO andGesture:NO ];
    
    //不支持背景触板手势
    [self.popUpController setIsOpenGesture:NO];
    //支持导航栏风格
    [self.popUpController setMode:PopupModeWithNavigationbar];
    //不支持界面键盘输入
    [self.popUpController setIsSupperKeyboard:NO];
    //默认主题
//    self.popUpController.theme = [PopupTheme defaultTheme];
    
    self.popUpController.theme = [PopupTheme custormTheme];
    self.popUpController.theme.popupStyle = popupStyle;
    self.popUpController.delegate = self;
    
    [self.popUpController presentPopupControllerInNavigationController:self Animated:YES];
}


- (void)rightButtonClick{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"换个样式" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"保存图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"扫描二维码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}



@end
