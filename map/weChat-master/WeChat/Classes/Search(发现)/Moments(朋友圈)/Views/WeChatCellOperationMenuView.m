//
//  WeChatCellOperationMenuView.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/15.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "WeChatCellOperationMenuView.h"
//#import "UIView+AutoLayout.h"

#define bPadding 3
#define bMargin  10
#define ButtonFontSize   [UIFont systemFontOfSize:14]
#define RGBColor(r, g, b, a) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a]

@interface WeChatCellOperationMenuView ()
@property (nonatomic,strong) UIButton *likeButton;
@property (nonatomic,strong) UIButton *commentButton;
@property (nonatomic,strong) UIView *centerLine;
@end

@implementation WeChatCellOperationMenuView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupOperationMenuView];
    }
    return self;
}

- (void)setupOperationMenuView{
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 5;
    self.backgroundColor = RGBColor(69, 74, 76, 1);
    
    UIButton *likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [likeButton setContentMode:UIViewContentModeRight];
    [likeButton setTitle:@"赞" forState:UIControlStateNormal];
    [likeButton.titleLabel setFont:ButtonFontSize];
    likeButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [likeButton setImage:[UIImage imageNamed:@"AlbumLike"] forState:UIControlStateNormal];
    [likeButton setImage:[UIImage imageNamed:@"AlbumLikeHL"] forState:UIControlStateHighlighted];
    [likeButton addTarget:self action:@selector(likeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:likeButton];
    self.likeButton = likeButton;
    
    
    UIButton *commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [commentButton setContentMode:UIViewContentModeLeft];
    [commentButton setTitle:@"评论" forState:UIControlStateNormal];
    [commentButton.titleLabel setFont:ButtonFontSize];
    commentButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [commentButton setImage:[UIImage imageNamed:@"AlbumComment"] forState:UIControlStateNormal];
    [commentButton setImage:[UIImage imageNamed:@"AlbumCommentHL"] forState:UIControlStateHighlighted];
    [commentButton addTarget:self action:@selector(commentButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:commentButton];
    self.commentButton = commentButton;
    
    UIView *centerLine = [[UIView alloc] init];
    centerLine.backgroundColor = [UIColor grayColor];
    [self addSubview:centerLine];
    self.centerLine = centerLine;
    
}

- (void)layoutOperationView{
    
    CGFloat width = 0;
    CGFloat width1 = 0;
    CGSize  size = CGSizeZero;
    
    
    [self.commentButton.titleLabel sizeLevelHeight:36];
    width = self.commentButton.imageView.image.size.width + self.commentButton.titleLabel.size.width ;
    
    [self.likeButton.titleLabel sizeLevelHeight:36];
    width1 = self.likeButton.imageView.image.size.width
    + self.likeButton.titleLabel.size.width;
  
    
    if(width1 > width){
        width = width1 + bMargin;
    }else{
        width += bMargin;
    }
    
    [self.likeButton setSize:CGSizeMake(width, 36)];
    [self.likeButton leftOffSetTo:self withOffset:bMargin];
    [self.likeButton topEqualTo:self];
 
    [self.centerLine setSize:CGSizeMake(1, 36)];
    [self.centerLine leftOffSetTo:self.likeButton withOffset:bMargin];
    [self.centerLine topEqualTo:self];
    
    
    [self.commentButton setSize:CGSizeMake(width, 36)];
    [self.commentButton leftOffSetTo:self.centerLine withOffset:bMargin];
    [self.commentButton topEqualTo:self];
    
    
    size.width = self.commentButton.size.width + self.commentButton.origin.x + bMargin;
    
    self.size = size;
}

- (void)likeButtonClicked
{
    if (self.likeButtonClickedOperation) {
        self.likeButtonClickedOperation();
    }
    self.show = NO;
}

- (void)commentButtonClicked
{
    if (self.commentButtonClickedOperation) {
        self.commentButtonClickedOperation();
    }
    self.show = NO;
}

- (void)setShow:(BOOL)show
{
    _show = show;
    
    [UIView animateWithDuration:0.2 animations:^{
        if (!show) {
            [self setHidden:YES];

        } else {
            [self resetLayout];
            [self layoutOperationView];
            if(self.layoutOperationMenuViewBlock){
                self.layoutOperationMenuViewBlock();
            }
            
            [self setHidden:NO];
            [self.superview bringSubviewToFront:self];
            
            DebugLog(@"显示...........OperationView");
        }
    }];
}
@end
