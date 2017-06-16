//
//  ScanTabbarView.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/18.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "ScanTabbarView.h"
#import "WeChatButton.h"

@interface ScanTabbarView ()
@property (nonatomic,strong)WeChatButton *selectedButton;
@property (nonatomic,strong)UIImageView *backImageView;
@end

#define TabbarDefalutItemsNum    1
#define ScanTabbarCustormItemNum     (self.subviews.count - TabbarDefalutItemsNum)
@implementation ScanTabbarView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setBackgroundColor:[UIColor clearColor]];
        [self addScanTabbarBackGroud];
    }
    return self;
}

- (void)addScanTabbarBackGroud{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage resizedImageWithName:@"ScanBtombarBG"]];
    [self addSubview:imageView];
    self.backImageView = imageView;
}




- (void)addScanBarButtonItemsWithImageName:(NSString *)imageName selcetedImageName:(NSString *) selectedImageName titleText:(NSString *) titleText{
    
    
    WeChatButton *button = [WeChatButton buttonWithType:UIButtonTypeCustom];
    
    
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setTitle:titleText forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:31/255.0 green:185/255.0 blue:34/255.0 alpha:1.0] forState:UIControlStateSelected];
    [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [button.titleLabel setFont:[UIFont systemFontOfSize:10.0]];
    
    
    [button setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    
    [button addTarget:self action:@selector(ScanBarbuttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:button];
    
}

- (void)changeButtonItemState:(WeChatButton *)button{
    [self.selectedButton setSelected:NO];
    [button setSelected:YES];
    self.selectedButton = button;
}

- (void)ScanBarbuttonClick:(WeChatButton *)button{
    
    [self changeButtonItemState:button];
    
    //采用block方法
    if(self.block){
        self.block(button.tag);
    }
    //代理方法
    if([self.delegate respondsToSelector:@selector(scanTabbarView:didSelectedScanBarButtonItemAtIndex:)]){
        [self.delegate scanTabbarView:self didSelectedScanBarButtonItemAtIndex:button.tag];
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];

    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        CGFloat buttonWidth = self.width/(ScanTabbarCustormItemNum*2);
        CGFloat buttonHeight = self.height;
        
        
        for(NSInteger index = 0; index < self.subviews.count;index ++){
            if([self.subviews[index] isKindOfClass:[WeChatButton class]]){
                WeChatButton *button = self.subviews[index];
                [button setTag:index - TabbarDefalutItemsNum];
                if(index == TabbarDefalutItemsNum){
                    [self changeButtonItemState:button];
                }
                
                [button setFrame:CGRectMake((index - TabbarDefalutItemsNum) * (self.width/ScanTabbarCustormItemNum) + buttonWidth * 0.25, 0, buttonWidth, buttonHeight)];
                
                CGFloat scaleHeight = 0.5;
                CGPoint pos = CGPointMake(buttonWidth * 0.25,buttonHeight*0.10);
                //设置图片大小
                [button setImageViewsWithScaleWidth:1 andScaleHeight:scaleHeight newPostion:pos withBackGroudColor:[UIColor clearColor]];
                
                //设置标题
                [button setTitleViewRect:CGRectMake(0.25 * buttonWidth, scaleHeight*buttonHeight*(1 + 0.15), buttonWidth, (1- scaleHeight)*buttonHeight*(1 - 0.3))];
            }else{
                [self.backImageView setSize:self.size];
            }
        }
    }
}

@end
