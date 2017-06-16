//
//  HeadPictureViewController.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/9.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "HeadPictureViewController.h"
#import "ActionSheet.h"

@interface HeadPictureViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,ActionSheetDelegate>
@property (nonatomic,strong)UIImageView *headImage;

@end

@implementation HeadPictureViewController

- (UIImageView *)headImage{
    if(!_headImage){
        _headImage = [[UIImageView alloc] init];
        [_headImage setFrame:CGRectMake(0, 0, self.view.width, self.view.width)];
        [_headImage setCenter:self.view.center];
        [self.view addSubview:_headImage];
    }
    return _headImage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setHeadPictureView];
}

- (void)setHeadPictureView{
    [self.view setBackgroundColor:[UIColor blackColor]];
    PersionModel *data = [PersionModel sharedPersionModel];
    
    [self.headImage setImage:data.headIcon];
    
     [self.navigationItem setTitle:@"个人头像"];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_more"] style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClick)];
    self.navigationItem.rightBarButtonItem = right;
    
    [self.headImage setUserInteractionEnabled:YES];
    
}

- (void)rightButtonClick{
    ActionSheet *actionSheet = [[ActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", @"保存图片", nil];
    
    [actionSheet show];
    
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    
//    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//#if TARGET_IPHONE_SIMULATOR
//        
//#elif TARGET_OS_IPHONE
//        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//        picker.allowsEditing = YES;
//
//        picker.delegate = self;
//        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//        [self presentViewController:picker animated:YES completion:nil];
//#endif
//    }]];
//    
//    [alert addAction:[UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        // 采用系统默认的图片浏览器
//        UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
//        photoPicker.delegate = self;
//        photoPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        photoPicker.view.backgroundColor = [UIColor whiteColor];
//        [self presentViewController:photoPicker animated:YES completion:NULL];
//    }]];
//    
//    [alert addAction:[UIAlertAction actionWithTitle:@"保存图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//        [self.navigationController popViewControllerAnimated:YES];
//    }]];
//    
//    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        
//    }]];
//    
//    [self presentViewController:alert animated:YES completion:nil];
}

// 代理方法
- (void)actionSheet:(ActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(!buttonIndex){
#if TARGET_IPHONE_SIMULATOR

#elif TARGET_OS_IPHONE
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.allowsEditing = YES;

        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
#endif
    }else if(buttonIndex == 1){
        // 采用系统默认的图片浏览器
        UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
        photoPicker.delegate = self;
        photoPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        photoPicker.view.backgroundColor = [UIColor whiteColor];
        [self presentViewController:photoPicker animated:YES completion:NULL];
    }
}

#pragma mark - 选中图片后退出
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        self.headImage.image = image;
    
    PersionModel *data = [PersionModel sharedPersionModel];
    
    data.headIcon = image;
    
    //更新服务器数据
    [data updateLocalDataToServers];
    
    //返回刷新 跟新数据源
    NSNotification *notice = [NSNotification notificationWithName:@"reflushWechatHeadIcon" object:image];
    [[NSNotificationCenter defaultCenter] postNotification:notice];
        
    [self dismissViewControllerAnimated:YES completion:nil];
}


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
