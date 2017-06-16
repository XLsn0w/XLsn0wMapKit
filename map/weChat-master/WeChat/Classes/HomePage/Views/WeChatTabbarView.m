//
//  WeChatTabbarView.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/6.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "WeChatTabbarView.h"
#import "WeChatButton.h"
#import "SplitLineView.h"

@interface WeChatTabbarView ()
@property (nonatomic,strong)WeChatButton *selectedButton;
@property (nonatomic,strong)SplitLineView *splitLine;
@property (nonatomic,strong)UIImageView *backImageView;
@end

#define TabbarDefalutItemsNum    2
#define WeChatTabbarCustormItemNum     (self.subviews.count - TabbarDefalutItemsNum)
@implementation WeChatTabbarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setBackgroundColor:[UIColor clearColor]];
        [self addTabbarViewBackGroudImage];
        [self addTabbarViewSpliteLine];
    }
    
    return self;
}

- (void)addTabbarViewBackGroudImage{
    UIImageView *backGroudImage = [[UIImageView alloc] initWithImage:[UIImage resizeWithImageName:@"tabbarBkg"]];
    [self addSubview:backGroudImage];
    self.backImageView = backGroudImage;
}

- (void)addTabbarViewSpliteLine{
    SplitLineView *splitLine = [[SplitLineView alloc] init];
    [self.splitLine setSplitLineColor:[UIColor colorWithRed:227/255.0 green:227/255.0 blue:231/255.0 alpha:1.0]];
     [self addSubview:splitLine];
    self.splitLine = splitLine;
}





- (void)addBarButtonItemsWithImageName:(NSString *)imageName selcetedImageName:(NSString *) selectedImageName titleText:(NSString *) titleText{
    
    
    WeChatButton *button = [WeChatButton buttonWithType:UIButtonTypeCustom];

    
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setTitle:titleText forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:31/255.0 green:185/255.0 blue:34/255.0 alpha:1.0] forState:UIControlStateSelected];
    [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [button.titleLabel setFont:[UIFont systemFontOfSize:9.0]];
    
 
    
    [button setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:button];
   
}

- (void)changeButtonItemState:(WeChatButton *)button{
    [self.selectedButton setSelected:NO];
    [button setSelected:YES];
    self.selectedButton = button;
}

- (void)buttonClick:(WeChatButton *)button{
    
    [self changeButtonItemState:button];
    
    //采用block方法
    if(self.block){
        self.block(button.tag);
    }
    //代理方法
    if([self.delegate respondsToSelector:@selector(WeChatTabbarView:didSelectedBarButtonItemAtIndex:)]){
        [self.delegate WeChatTabbarView:self didSelectedBarButtonItemAtIndex:button.tag];
    }
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        CGFloat buttonWidth = self.bounds.size.height;
        CGFloat buttonHeight = buttonWidth;
        
        
        for(NSInteger index = 0; index < self.subviews.count;index ++){
            if([self.subviews[index] isKindOfClass:[WeChatButton class]]){
                WeChatButton *button = self.subviews[index];
                [button setTag:index - TabbarDefalutItemsNum];
                if(index == TabbarDefalutItemsNum){
                    [self changeButtonItemState:button];
                }
                
                [button setFrame:CGRectMake((index - TabbarDefalutItemsNum) * (self.bounds.size.width/WeChatTabbarCustormItemNum) + buttonWidth * 0.25, 0, buttonWidth, buttonHeight)];
                
                CGFloat scale = 0.5;
                CGPoint pos = CGPointMake((1 - scale)*buttonWidth - buttonWidth * 0.25, (1 - scale)*buttonHeight*0.3);
                //设置图片大小
                [button setImageViewscaleSize:scale newPostion:pos withBackGroudColor:[UIColor clearColor]];
            
                //设置标题
                [button setTitleViewRect:CGRectMake((1 - scale)*buttonWidth*0.5 - buttonWidth * 0.25, scale*buttonHeight*(1 + 0.3), buttonWidth, (1- scale)*buttonHeight*(1 - 0.3))];
            }else if([self.subviews[index] isKindOfClass:[SplitLineView class]]){
                [self.splitLine setSplitLineWidth:self.width];
                [self.splitLine setSplitLineHeight:1];
            }else{
                [self.backImageView setSize:self.size];
            }
        }
    }
}
@end
