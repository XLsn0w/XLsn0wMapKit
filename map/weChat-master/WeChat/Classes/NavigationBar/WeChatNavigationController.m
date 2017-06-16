//
//  WeChatNavigationController.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/2.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "WeChatNavigationController.h"
#import "WeChatTabbarController.h"
#import "BaseGroupTableViewController.h"
#import "UIImage+ColorImage.h"
#import "UIImage+ResizeImage.h"
#import <objc/runtime.h>

@interface WeChatNavigationController ()<UIGestureRecognizerDelegate,BaseGroupTableViewControllerDelegate,UINavigationControllerDelegate>

@end

@implementation WeChatNavigationController


- (void)viewDidLoad {
    [super viewDidLoad];
#warning mark - 在导航栏控制器中添加手势会导致子控制器table view 手势冲突 ，最终导致push动画卡顿，push界面跳转不过去
    // 获取系统自带滑动手势的target对象
//    id target = self.interactivePopGestureRecognizer.delegate;


//    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
//    
//    // 设置手势代理，拦截手势触发
//    pan.delegate = self;
//    
//    // 给导航控制器的view添加全屏滑动手势
//    [self.view addGestureRecognizer:pan];
//    
//    // 禁止使用系统自带的滑动手势
//    self.interactivePopGestureRecognizer.enabled = NO;
    
//    [(BaseGroupTableViewController *)self.topViewController setDelegate:self];
    
#pragma mark - 创建交互手势
    //获取系统自带Pop滑动手势
    UIGestureRecognizer *gesture = self.interactivePopGestureRecognizer;
    //添加监听监听方法
    [gesture addTarget:self action:@selector(handleNavigationControllerTransition:)];
    
    
}


- (void)handleNavigationControllerTransition:(UIGestureRecognizer *)gesture{
    
    if([gesture isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]){
        DebugLog(@"导航栏控制器边框移动");
        
        switch (gesture.state) {
            case UIGestureRecognizerStateBegan:{
                // 开始拖拽阶段
                DebugLog(@"开始拖拽");
            }
                break;
                
            case UIGestureRecognizerStateEnded:{
                // 结束拖拽阶段
                DebugLog(@"结束拖拽");
            }
                break;
                
            default:{
                CGPoint translation = [(UIPanGestureRecognizer *)gesture translationInView:gesture.view];
                DebugLog(@"导航栏 移动了,x = %0.0f,y = %0.0f",translation.x,translation.y);
                DebugLog(@"navigation controller num is %lu",self.viewControllers.count);
                if(self.viewControllers.count){
                    
                }
            }
                break;
        }
    }
}



- (void)viewDidAppear:(BOOL)animated{
   [super viewDidAppear:animated];
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        [self setNavigationBarSize:84];
    }
}

- (void)setNavigationBarSize:(CGFloat) height{
    CGRect frame = self.navigationBar.frame;
    frame.size.height = height;
    self.navigationBar.frame = frame;
}

- (void)setWeChatNavigationDefaultStyle{
//         [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"topbarbg_ios7"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setBackgroundImage:[UIImage resizeWithImageName:@"topbarbg_ios7"] forBarMetrics:UIBarMetricsDefault];
    
        //设置主题颜色
        [self.navigationBar setTintColor:[UIColor whiteColor]];
    
        //设置统一的文字属性
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:30.0]}];
    }else{
        [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20.0]}];
    }
}

- (void)setWeChatNavigationHideStyle{
    //设置导航栏透明
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage new]];
}

- (void)setWeChatNavigationBackgroudColor:(UIColor *)color{
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:color] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor clearColor]]];
    
    [self.navigationBar setTranslucent:YES];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}


- (void)setHidesNavigationBar:(BOOL)hides withAnimationStyle:(WeChatNavigationbarHiderOptionStyle) style{
    
    self.NavigationBarHider = hides;
    if(style == WeChatNavigationbarHiderOptionStyleDefault){
        [UIView animateWithDuration:0.2 animations:^{
              [self.navigationBar setHidden:hides];
        }];
    }else{
        CGRect frame = self.navigationBar.frame;
        if(hides){
            if(style == WeChatNavigationbarHiderOptionStyleFlipLeft){
                if(frame.origin.x >= 0){
                    frame = CGRectMake(frame.origin.x - frame.size.width, frame.origin.y, frame.size.width, frame.size.height);
                }
            }else if(style == WeChatNavigationbarHiderOptionStyleFlipRight){
                if(frame.origin.x <= 0){
                   frame = CGRectMake(frame.origin.x + frame.size.width, frame.origin.y, frame.size.width, frame.size.height);
                }
            }else {
                if(frame.origin.y >= 0){
                    frame = CGRectMake(frame.origin.x , frame.origin.y - (frame.size.height + NavigationBarDefaultOffsetY), frame.size.width, frame.size.height);
                }
            }
        }else{
            if(style == WeChatNavigationbarHiderOptionStyleFlipLeft){
                if(frame.origin.x < 0){
                    frame = CGRectMake(frame.origin.x + frame.size.width, frame.origin.y, frame.size.width, frame.size.height);
                }
            }else if(style == WeChatNavigationbarHiderOptionStyleFlipRight){
                if(frame.origin.x > 0){
                    frame = CGRectMake(frame.origin.x - frame.size.width, frame.origin.y, frame.size.width, frame.size.height);
                }
            }else if(style == WeChatNavigationbarHiderOptionStyleFlipUpBubble){
                 if(frame.origin.y < 0){
                     frame = CGRectMake(frame.origin.x , frame.origin.y + (frame.size.height + NavigationBarDefaultOffsetY)  + AppearFlipBubbleOffset, frame.size.width, frame.size.height);
                 }
            }else{
                if(frame.origin.y < 0){
                    
                    frame = CGRectMake(frame.origin.x , frame.origin.y + (frame.size.height + NavigationBarDefaultOffsetY), frame.size.width, frame.size.height);
                }

            }
        }

        
        [UIView animateWithDuration:0.3 animations:^{
            [self.navigationBar setFrame:frame];
        } completion:^(BOOL finished) {
            
            if(style == WeChatNavigationbarHiderOptionStyleFlipUpBubble){
                CGRect eframe = self.navigationBar.frame;
                if(!hides ){

                   eframe = CGRectMake(eframe.origin.x , eframe.origin.y - AppearFlipBubbleOffset, eframe.size.width, eframe.size.height);
                    [UIView animateWithDuration:0.2 animations:^{
                        [self.navigationBar setFrame:eframe];
        
                    }];
                }else{
                    
                }
            }
        }];
    }
}

#pragma mark - 重写导航栏控制器的push方法,拦截push动作,发现该方法有问题
#warning 该方法在某些情况下存在明显的push后控制器视图不切换的bug,如tableview 左右滑动后在点cell切换就有这个现象了,具体不明问题原因（该bug已经解决，是因为在导航控制器中加了滑动手势导致的）

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
      if (self.childViewControllers.count > 0) {
     [(WeChatTabbarController *)self.tabBarController setHidesBottomTabBarWhenPushed:YES withViewController: viewController];
      }
    [super pushViewController:viewController animated:animated];
    
    if (self.childViewControllers.count > 0) {
        [(WeChatTabbarController *)self.tabBarController setHidesBottomTabBarWhenPushed:NO withViewController: viewController];
    }
}

#pragma mark - 执行basegrouptableview的代理方法
- (void)baseGroupTableviewWillAppear:(BaseGroupTableViewController *)controller{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIViewController *nowVC = [[(UINavigationController *)delegate.window.rootViewController viewControllers]firstObject];
   
}

- (void)baseGroupTableviewDidAppear:(BaseGroupTableViewController *)controller{
#pragma mark -  设置完Hides为YES后必须设置NO 否则Tabbar Pop后不正常
    
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
