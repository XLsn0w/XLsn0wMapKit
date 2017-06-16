//
//  WeChatMomentsCell.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/15.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "WeChatMomentsCell.h"
#import "WeChatCellPhotoView.h"
#import "WeChatCellCommentView.h"
#import "WeChatCellOperationMenuView.h"
#import "WeChatMomentsCellModel.h"
//#import "UIView+AutoLayout.h"


#define bMargin    10
#define bPaddig    15
#define TimeLableFontSize [UIFont systemFontOfSize:11]
#define LabelFontSize   [UIFont systemFontOfSize:13]
#define NameFontSize    [UIFont systemFontOfSize:15]
#define ButtonFontSize  [UIFont systemFontOfSize:14]

#define NameColor       [UIColor colorWithRed:(54/255.0) green:(71/255.0) blue:(121/255.0) alpha:0.9]

#define ButtonHighlightedColor [UIColor colorWithRed:92/255.0 green:140/255.0 blue:193/255.0 alpha:1.0]

CGFloat maxContentLabelHeight = 0; // 根据具体font而定

@interface WeChatMomentsCell ()
@property(nonatomic,strong) UIImageView *iconView;
@property(nonatomic,strong) UILabel *nameLable;
@property(nonatomic,strong) UILabel *contentLabel;
@property(nonatomic,strong) WeChatCellPhotoView *pictureView;
@property(nonatomic,strong) UILabel *timeLabel;
@property(nonatomic,strong) UIButton *moreButton;
@property(nonatomic,strong) UIButton *operationButton;
@property(nonatomic,strong) WeChatCellCommentView *commentView;
@property(nonatomic,strong) WeChatCellOperationMenuView *operationView;
@end

@implementation WeChatMomentsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self setupMomentCellView];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)setupMomentCellView{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveOperationButtonClickedNotification:) name:@"OperationButtonClicked" object:nil];
    
    //朋友圈朋友头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    self.iconView = iconView;
    
    //朋友圈朋友名字
    UILabel *nameLable = [[UILabel alloc] init];
    [nameLable setFont:NameFontSize];
    [nameLable setTextColor:NameColor];
    [self addSubview:nameLable];
    self.nameLable = nameLable;
    
    UILabel *contentLabel = [[UILabel alloc] init];
    [contentLabel setFont:ContentFontSize];
    [contentLabel setNumberOfLines:0];
    [self addSubview:contentLabel];
    self.contentLabel = contentLabel;
    if(!maxContentLabelHeight){
        maxContentLabelHeight = self.contentLabel.font.lineHeight * 3;
    }
    
    //全文提示按钮
    UIButton *moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreButton setTitle:@"全文" forState:UIControlStateNormal];
    [moreButton setTitleColor:ButtonHighlightedColor forState:UIControlStateNormal];
    [moreButton addTarget:self action:@selector(moreButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [moreButton.titleLabel setFont:ButtonFontSize];
    [self addSubview:moreButton];
    self.moreButton = moreButton;
    
    //点赞或者评论按钮
    UIButton *operationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [operationButton setImage:[UIImage imageNamed:@"AlbumOperateMore"] forState:UIControlStateNormal];
    [operationButton setImage:[UIImage imageNamed:@"AlbumOperateMoreHL"] forState:UIControlStateHighlighted];
    [operationButton addTarget:self action:@selector(operationButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:operationButton];
    self.operationButton = operationButton;
    
    //配图
    WeChatCellPhotoView *pictureView = [[WeChatCellPhotoView alloc] init];
    [self addSubview:pictureView];
    self.pictureView = pictureView;
    
    //微信发送时间
    UILabel *timeLabel = [[UILabel alloc] init];
    [timeLabel setFont:TimeLableFontSize];
    [self addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    //点赞评论操作
    WeChatCellOperationMenuView *operationView = [[WeChatCellOperationMenuView alloc] init];
    [self addSubview:operationView];
    weak_self weakSelf = self;
    //点赞
    [operationView setLikeButtonClickedOperation:^{
        if([weakSelf.delegate respondsToSelector:@selector(didClickLikeButtonInCell:)]){
            [weakSelf.delegate didClickLikeButtonInCell:weakSelf];
        }
    }];
    //评论
    [operationView setCommentButtonClickedOperation:^{
        if([weakSelf.delegate respondsToSelector:@selector(didClickcCommentButtonInCell:)]){
            [weakSelf.delegate didClickcCommentButtonInCell:weakSelf];
        }
    }];
    self.operationView = operationView;
    
    //评论列表
    WeChatCellCommentView *commentView = [[WeChatCellCommentView alloc] init];
    [self addSubview:commentView];
    self.commentView = commentView;

}

- (void)cellRestLayout{

    //初始化布局器,指定布局器布局的view
    self.layoutView = self;
    //重置布局区域
    [self.layoutView resetLayoutView];
}

- (void)cellHandleLayout{
    //头像布局
    [self.iconView setSize:CGSizeMake(40, 40)];
    [self.iconView leftOffSetFrom:self.layoutView withOffset:bMargin];
    [self.iconView topOffSetFrom:self.layoutView withOffset:bPaddig];
    
    
    //昵称
    [self.nameLable sizeLevelHeight:18];
    [self.nameLable leftOffSetTo:self.iconView withOffset:bMargin];
    [self.nameLable topEqualTo:self.iconView];
   
    //消息标签
    [self.contentLabel leftEqualTo:self.nameLable];
    [self.contentLabel rightOffSetFrom:self.layoutView withOffset:bMargin];

    if(self.contentLabel.height == MAXFLOAT){
        [self.contentLabel sizeLevelWidth:self.contentLabel.width];
    }else{
      
        if([self layoutCheckHeightIsEqual:self.contentLabel]){
            [self.contentLabel sizeLevelWidth:self.contentLabel.width];
        }
    }
    
    [self.contentLabel topOffSetTo:self.nameLable withOffset:bMargin];
   
    //全文 高度在mode中设置了
    [self.moreButton leftEqualTo:self.contentLabel];
    [self.moreButton setWidth:30];
    [self.moreButton topOffSetTo:self.contentLabel withOffset:0];

    //配图
    [self.pictureView leftEqualTo:self.contentLabel];
    if(self.pictureView.height){
        [self.pictureView topOffSetTo:self.moreButton withOffset:bMargin];
    }else{
        [self.pictureView topOffSetTo:self.moreButton withOffset:0];
    }
    
    
    //时间戳
    [self.timeLabel sizeLevelHeight:15];
    [self.timeLabel leftEqualTo:self.contentLabel];
    [self.timeLabel topOffSetTo:self.pictureView withOffset:bMargin];
    
    //操作按钮
    [self.operationButton setSize:CGSizeMake(25, 25)];
    [self.operationButton rightOffSetFrom:self.layoutView withOffset:bMargin];
    [self.operationButton equalCenterYTo:self.timeLabel];

    //评论信息
    [self.commentView leftEqualTo:self.contentLabel];
    [self.commentView rightOffSetFrom:self.layoutView withOffset:bMargin];
    [self.commentView topOffSetTo:self.timeLabel withOffset:0];
    

    //操作面板
    weak_self weakSelf = self;
    //该block执行在重新布局操作面板时被调用
    [self.operationView setLayoutOperationMenuViewBlock:^{
        [weakSelf.operationView rightOffSetTo:weakSelf.operationButton withOffset:0];
        [weakSelf.operationView setHeight:36];
        [weakSelf.operationView equalCenterYTo:weakSelf.operationButton];
    }];
    //尝试执行一次,给操作面板初始化
    if(self.operationView.layoutOperationMenuViewBlock){
        self.operationView.layoutOperationMenuViewBlock();
    }
   
}

- (BOOL)layoutCheckHeightIsEqual:(UILabel *) lable{
  
    CGRect frame = [lable.text boundingRectWithSize:CGSizeMake(lable.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:lable.font} context:nil];
   
    if(frame.size.height <= lable.height){
        return YES;
    }
    
    return NO;
}


- (void)setModel:(WeChatMomentsCellModel *)model{
    _model = model;
    
    //重置开始布局
    model.cellHeight = 0;
    [self cellRestLayout];

    //设置头像
    [self.iconView setImage:[UIImage imageNamed:model.iconName]];
    //设置昵称
    [self.nameLable setText:model.name];
    
    //设置消息
    [self.contentLabel setText:model.msgContent];

    //设置配图
    [self.pictureView setPicPathString:model.picNamesArray];
    
    //全文展开按钮
    if(model.shouldShowMoreButton){
        [self.moreButton setHeight:20];
        [self.moreButton setHidden:NO];
        
        //展开全文
        if(model.isOpening){
            [self.contentLabel setHeight:MAXFLOAT];
            [self.moreButton setTitle:@"收起" forState:UIControlStateNormal];
        }else{
            [self.contentLabel setHeight:maxContentLabelHeight];
            [self.moreButton setTitle:@"全文" forState:UIControlStateNormal];
        }
    }else{
        //设置推荐最大的文章长度
        [self.contentLabel setHeight:maxContentLabelHeight];
        [self.moreButton setHeight:0];
        [self.moreButton setHidden:YES];
    }

    //配图布局
    if(!model.picNamesArray.count){
        [self.pictureView resetLayout];
    }
    
    
    [self.timeLabel setText:@"一分钟前"];
    
  
    [self.commentView setWidth:self.width - (bMargin + 60)];
    DebugLog(@"commentView 宽度%lf",self.commentView.width);
    //设置点赞数与评论数
    self.model.cellHeight = [self.commentView setupWithLikeItems:model.likeItems commentItemsArray:model.commentItems];
    
    //手动布局
    [self cellHandleLayout];
    
    //结束布局
    [self endLayoutWithEndMarginRightX:bMargin andMarginBottomY:bMargin];
    model.cellHeight = self.layoutView.height;
    

    
   DebugLog(@"nei--->图片数%lu",model.picNamesArray.count);
   DebugLog(@"nei--->点赞数%lu,评论数%lu",model.likeItems.count,model.commentItems.count);
   DebugLog(@"nei--->第%lu行 ---自动布局高度：%lf,自动布局宽度: %lf",self.indexPath.row, self.layoutView.height,self.layoutView.width);
   
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    if (self.operationView.isShowing){
        [self.operationView setShow:NO];
    }
}

- (void)moreButtonClicked{
    if (self.moreButtonClickedBlock) {
        self.moreButtonClickedBlock(self.indexPath);
    }
}

- (void)operationButtonClicked{
    DebugLog(@"点操作面板了");
    [self postOperationButtonClickedNotification];
     self.operationView.show  = !self.operationView.isShowing;

}

- (void)receiveOperationButtonClickedNotification:(NSNotification *)notification
{
    UIButton *button = [notification object];
    
    if (button != self.operationButton && self.operationView.isShowing) {
        self.operationView.show = NO;
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self postOperationButtonClickedNotification];
    if (self.operationView.isShowing) {
        self.operationView.show = NO;
    }
}

- (void)postOperationButtonClickedNotification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"OperationButtonClicked" object:self.operationButton];
}

@end
