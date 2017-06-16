//
//  BottleViewController.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/9.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "BottleViewController.h"
#import "WeChatNavigationController.h"

#define BottleBoardItemsOffset    23
#define BottleItemsWidth    76
#define BottleItemsHeight   86
#define BottleLableHeight   14

typedef enum{
    BottleItemsThrow,
    BottleItemsPick,
    BottleItemsMine,
}BottleItemsType;

@interface BottleViewController ()

@property (nonatomic,strong)UIImageView *backGroudImageView;
@property (nonatomic,strong)UIImageView *pickSpolNight;
@property (nonatomic,strong)UIImageView *bottleBoard;
@property (nonatomic,copy)NSString *navigationState;
@end

@implementation BottleViewController

- (UIImageView *)pickSpolNight{
    if(!_pickSpolNight){
        _pickSpolNight = [[UIImageView alloc] initWithFrame:self.view.frame];
        [_pickSpolNight setImage:[UIImage imageNamed:@"bottleBkgSpotLight"]];
    }
    return _pickSpolNight;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setBottleView];
}

- (void)setBottleView{
    UIImageView * backGroudImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bottleNightBkg"]];
    [backGroudImageView setFrame:self.view.frame];
    [self.view addSubview:backGroudImageView];
    self.backGroudImageView = backGroudImageView;
    

  
    UIImageView *bottleBoard = [[UIImageView alloc] init];
    UIImage *image = [UIImage imageNamed:@"bottleBoard"];
    [bottleBoard setImage:image];
    [bottleBoard setSize:CGSizeMake(self.view.width,image.size.height)];
    [bottleBoard bottomOffSetFrom:self.view withOffset:0];
    [self.view addSubview:bottleBoard];
    self.bottleBoard = bottleBoard;
    
    NSArray *imagesName = @[@"bottleButtonThrow",@"bottleButtonFish",@"bottleButtonMine"];
    NSArray *labelName = @[@"扔一个",@"捡一个",@"我的瓶子"];
    for(NSInteger index = 0; index < imagesName.count;index++){
        UIButton * bottleItems = [UIButton buttonWithType:UIButtonTypeCustom];
        [bottleItems setImage:[UIImage imageNamed:imagesName[index]] forState:UIControlStateNormal];
        [bottleItems setSize:CGSizeMake(BottleItemsWidth, BottleItemsHeight)];
        [bottleItems leftOffSetFrom:self.view withOffset:(BottleBoardItemsOffset + BottleItemsWidth)*index + BottleBoardItemsOffset];
        [bottleItems bottomOffSetFrom:self.view withOffset:BottleLableHeight];
        [bottleItems setTag:index];
        [bottleItems addTarget:self action:@selector(bottleItemsClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:bottleItems];
        
        UILabel *bottleLabel = [[UILabel alloc] init];
        [bottleLabel setTextColor:[UIColor whiteColor]];
        [bottleLabel setText:labelName[index]];
        [bottleLabel setFont:[UIFont boldSystemFontOfSize:14]];
        [bottleLabel setTextAlignment:NSTextAlignmentCenter];
        
        [bottleLabel setSize:CGSizeMake(BottleItemsWidth, BottleLableHeight)];
        [bottleLabel leftOffSetFrom:self.view withOffset:(BottleBoardItemsOffset + BottleItemsWidth)*index + BottleBoardItemsOffset];
        [bottleLabel bottomOffSetFrom:self.view withOffset:6];
        
        [self.view addSubview:bottleLabel];
    }

   
    
    
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_set"] style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClick)];
    self.navigationItem.rightBarButtonItem = right;
   
}

- (void)rightButtonClick{
    
}

- (void)bottleItemsClick:(UIButton *) button{
    switch (button.tag) {
        case BottleItemsThrow:{
            
        }
            break;
        case BottleItemsPick:{
            self.navigationState = @"Off";
            [self bottlePickAction];
        }
            break;
        case BottleItemsMine:{
            
        }
            break;
        default:
            break;
    }
}

- (void)bottlePickAction{

    [self.bottleBoard setHidden:YES];
    
    for(UIView *view in self.view.subviews){
        if([view isKindOfClass:[UIButton class]]
           ||[view isKindOfClass:[UILabel class]]){
            [view setHidden:YES];
        }
    }
    
    [self.view addSubview:self.pickSpolNight];
    
    NSArray *waterName = @[@"fishwater",@"fishwater2",@"fishwater3"];
    UIImageView *fishWater = [[UIImageView alloc] init];
    [fishWater setSize:CGSizeMake(68, 48)];
    [fishWater leftOffSetFrom:self.view withOffset:100];
    [fishWater bottomOffSetFrom:self.view withOffset:230];
   
    
    
      [self.view addSubview:fishWater];
        DebugLog(@"0,,,,,,%@", [UIView areAnimationsEnabled] ? @"yes":@"no");
    
      [fishWater setImage:[UIImage imageNamed:waterName[0]]];
       [UIView animateWithDuration:0.5 animations:^{
           [fishWater setImage:[UIImage imageNamed:waterName[1]]];
       }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"你点击我了");
    if(![self.navigationState isEqualToString:@"Off"]){
       
        BOOL hidden = [(WeChatNavigationController *)self.navigationController NavigationBarHider];
        [(WeChatNavigationController *)self.navigationController setHidesNavigationBar:!hidden withAnimationStyle:WeChatNavigationbarHiderOptionStyleFlipUpBubble];
    }else{
        if([self.navigationState isEqualToString:@"Off"]){

            [self.pickSpolNight removeFromSuperview];
            [self.bottleBoard setHidden:NO];
            
            for(UIView *view in self.view.subviews){
                if([view isKindOfClass:[UIButton class]]
                   ||[view isKindOfClass:[UILabel class]]){
                    [view setHidden:NO];
                }
            }
        
        }
    }
  
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
