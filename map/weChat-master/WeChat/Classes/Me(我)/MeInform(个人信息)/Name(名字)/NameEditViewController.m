//
//  NameEditViewController.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/9.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "NameEditViewController.h"
#import "NameFieldView.h"
#import "Constant.h"

@interface NameEditViewController ()<UITextFieldDelegate>

@property (nonatomic,strong)NameFieldView *nameField;

@end

#define NAVIGATION_AND_TABBAR_HEIGH    32

@implementation NameEditViewController

- (NameFieldView *)nameField{
    if(!_nameField){
        _nameField = [[NameFieldView alloc] initWithFrame:self.view.frame];
        
        [_nameField.name setDelegate:self];
        [_nameField.name setTintColor:SystemTintColor];
        [_nameField.name setText:[PersionModel sharedPersionModel].name];
        
        CGSize scrollSize = CGSizeMake(0, self.view.bounds.size.height + NAVIGATION_AND_TABBAR_HEIGH);
        [_nameField setContentSize: scrollSize];
        [_nameField setBackgroundColor:[UIColor lightGrayColor]];
        
        [self setView:_nameField];
    }
    return _nameField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNameEditView];
    
    [self.nameField.name becomeFirstResponder];
    [self.navigationItem setTitle:@"名字"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(clickSaveEdit)];
    
}

- (void)clickSaveEdit{
    PersionModel *data = [PersionModel sharedPersionModel];
    
    data.name = self.nameField.name.text;
    
    DebugLog(@"名字：%@",self.nameField.name.text);
    //更新服务器数据
    [data updateLocalDataToServers];
    
    //返回刷新 跟新数据源
    NSNotification *notice = [NSNotification notificationWithName:@"reflushWechatName" object:data.name];
    [[NSNotificationCenter defaultCenter] postNotification:notice];
  
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setNameEditView{
    [self.navigationItem setTitle:@"个人信息"];
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
