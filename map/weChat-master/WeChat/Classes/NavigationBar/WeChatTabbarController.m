//
//  WeChatTabbarController.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/3.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "WeChatTabbarController.h"
#import "WeChatNavigationController.h"
#import "WeChatTabbarView.h"
#import "UIImage+ColorImage.h"
#import "UIViewController+PushPopBackButton.h"
#import "AppDelegate.h"



@interface WeChatTabbarController () <UIViewControllerDelegate>
@end

@implementation WeChatTabbarController


- (WeChatTabbarView *)tabBarView{
    if(!_tabBarView){
        _tabBarView = [[WeChatTabbarView alloc] initWithFrame:self.tabBar.frame];
#ifdef USE_DEFAULT_NAVIGATION
        [self.tabBar setBackgroundColor:[UIColor colorWithRed:239.0/255.0f green:239.0/255.0f blue:244.0/255.0f alpha:1.0]];
        [self.tabBar setTintColor:[UIColor colorWithRed:2.0/255.0f green:187.0/255.0f blue:0.0/255.0f alpha:1.0]];
#else
        [self.tabBar setHidden:YES];
        [self.view addSubview:_tabBarView];
#endif
    }
    return _tabBarView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        [self setTabBarSize:80];
    }
    
}

- (void)addTabBarItemWithItemNum:(NSInteger) buttonItemNumber andNameArray:(NSArray *) nameArray andImageNameArray:(NSArray *) imageNameArray{
    
   
#ifndef USE_DEFAULT_NAVIGATION
      for(NSInteger i = 0;i < buttonItemNumber;i++){
        [self.tabBarView addBarButtonItemsWithImageName:[NSString stringWithFormat:@"%@",imageNameArray[i]] selcetedImageName:[NSString stringWithFormat:@"%@HL",imageNameArray[i]] titleText:[nameArray objectAtIndex:i]];
      }
#endif

}

- (void)setWeChatTabBarBackgroudColor:(UIColor *)color{
    [self.tabBar setBackgroundImage:[UIImage imageWithColor:color]];
    [self.tabBar setShadowImage:[UIImage imageWithColor:[UIColor clearColor]]];
    
    [self.tabBar setTranslucent:YES];
}

- (void)setTabBarSize:(CGFloat) height{
    CGRect frame = self.tabBar.frame;
    
    frame.size.height = height;
    
    frame.origin.y = self.view.frame.size.height - frame.size.height;
    
    self.tabBar.frame = frame;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
#ifndef USE_DEFAULT_NAVIGATION
    //重绘的时候保证自定义Tabbar 总是在上面
    [self.view bringSubviewToFront:self.tabBarView];
#endif
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 隐藏与显示Tabbar
- (void)setHidesBottomTabBarWhenPushed:(BOOL)hides withAnimationStyle:(WeChatTabbarHiderOptionStyle) style{
    
    if(style == WeChatTabbarHiderOptionStyleDefault){
        [UIView animateWithDuration:0.2 animations:^{
            [self.tabBar setHidden:hides];
            [self.tabBarView setHidden:hides];
    
        }];
  
    }else{
        
        CGRect frame = self.tabBar.frame;
        NSLog(@"hides:%@ frame:%@",hides ? @"YES":@"NO" ,NSStringFromCGRect(frame));
        
        if(hides){
            if(style == WeChatTabbarHiderOptionStyleFlipLeft){
                if(frame.origin.x >= 0){
                    frame = CGRectMake(frame.origin.x - frame.size.width, frame.origin.y, frame.size.width, frame.size.height);
                }
            }else if(style == WeChatTabbarHiderOptionStyleFlipRight){
                if(frame.origin.x <= 0){
                    frame = CGRectMake(frame.origin.x + frame.size.width, frame.origin.y, frame.size.width, frame.size.height);
                }
            }else{
                if(frame.origin.y + frame.size.height <= [UIScreen mainScreen].bounds.size.height){
                    frame = CGRectMake(frame.origin.x, frame.origin.y + frame.size.height, frame.size.width, frame.size.height);
                }
            }
            
        }else{
            
            if(style == WeChatTabbarHiderOptionStyleFlipLeft){
                if(frame.origin.x < 0){
                    frame = CGRectMake(frame.origin.x + frame.size.width, frame.origin.y, frame.size.width, frame.size.height);
                }
            }else if(style == WeChatTabbarHiderOptionStyleFlipRight){
                if(frame.origin.x > 0){
                    frame = CGRectMake(frame.origin.x - frame.size.width, frame.origin.y, frame.size.width, frame.size.height);
                }
            }else{
                if(frame.origin.y + frame.size.height > [UIScreen mainScreen].bounds.size.height){
                    frame = CGRectMake(frame.origin.x, frame.origin.y - frame.size.height, frame.size.width, frame.size.height);
                }
            }
        }
         NSLog(@"hides:%@ frame:%@",hides ? @"YES":@"NO" ,NSStringFromCGRect(frame));
        [UIView animateWithDuration:0.2 animations:^{
            [self.tabBar setFrame:frame];
            [self.tabBarView setFrame:frame];
        }];

    }
}

#pragma mark - UITableViewcontroller 的代理方法,该方法用于拦截导航栏上返回按钮的执行
- (void)baseUIViewDidListenNavigationShouldPopOnByBackButton{
    
#pragma mark - 在倒数第二个控制器时候,切换出Tabbar
    
    WeChatNavigationController *controller = (WeChatNavigationController *)self.childViewControllers[self.selectedIndex];
    
    
    if([controller.viewControllers count] == SecondViewControllerIndexNumber){
        [self setHidesBottomTabBarWhenPushed:NO withAnimationStyle:WeChatTabbarHiderOptionStyleFlipLeft];
    }
    
    NSLog(@"UIViewController 的代理方法，啦啦！");
}

#pragma mark - 该方法用于隐藏底部自定义的状态栏
- (void)setHidesBottomTabBarWhenPushed:(BOOL)hides withViewController:(UIViewController *) controller{
    
    WeChatNavigationController *navigation = (WeChatNavigationController *)self.childViewControllers[self.selectedIndex];
    
    if([navigation.viewControllers count] == FristViewControllerIndexNumber){
        [controller setHidesBottomBarWhenPushed:hides];
    }
    
#ifndef USE_DEFAULT_NAVIGATION
    if(hides)
    {
        [self setHidesBottomTabBarWhenPushed:hides withAnimationStyle:WeChatTabbarHiderOptionStyleFlipLeft];
    }
#endif
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
