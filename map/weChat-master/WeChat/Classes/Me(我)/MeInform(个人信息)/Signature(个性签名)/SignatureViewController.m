//
//  SignatureViewController.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/23.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "SignatureViewController.h"
#import "SignatureView.h"
#import "Constant.h"

#define NAVIGATION_AND_TABBAR_HEIGH    32

@interface SignatureViewController ()<UITextFieldDelegate>
@property (nonatomic,strong)SignatureView *signatureField;
@end

@implementation SignatureViewController

- (SignatureView *)signatureField{
    if(!_signatureField){
        _signatureField = [[SignatureView alloc] initWithFrame:self.view.frame];
        
//        [_signatureField.signature setDelegate:self];
        [_signatureField.signature setTintColor:SystemTintColor];
        [_signatureField.signature setText:[PersionModel sharedPersionModel].signature];
        
        CGSize scrollSize = CGSizeMake(0, self.view.height + NAVIGATION_AND_TABBAR_HEIGH);
        [_signatureField setContentSize: scrollSize];
        [_signatureField setBackgroundColor:[UIColor lightGrayColor]];
        
        [self setView:_signatureField];
    }
    return _signatureField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    [self.signatureField.signature becomeFirstResponder];
    [self.navigationItem setTitle:@"个性签名"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(clickSaveEdit)];
}

- (void)clickSaveEdit{
    PersionModel *data = [PersionModel sharedPersionModel];
    
    data.signature = self.signatureField.signature.text;
    
    [data updateLocalDataToServers];
    
    //返回刷新 跟新数据源
    NSNotification *notice = [NSNotification notificationWithName:@"reflushWechatSignature" object:data.signature];
    [[NSNotificationCenter defaultCenter] postNotification:notice];
    
    [self.navigationController popViewControllerAnimated:YES];
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
