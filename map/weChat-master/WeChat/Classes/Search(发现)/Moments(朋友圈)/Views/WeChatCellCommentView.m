//
//  WeChatCellCommentView.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/15.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "WeChatCellCommentView.h"
#import "WeChatMomentsCellModel.h"
#import "MLLinkLabel.h"


#define bPadding        5
#define bMargin         10
#define LabelFontSize   [UIFont systemFontOfSize:14]
#define CellHighlightedColor [UIColor colorWithRed:92/255.0 green:140/255.0 blue:193/255.0 alpha:1.0]
#define RGBColor(r, g, b, a) [UIColor colorWithRed:(r / 255.0) green:(g / 255.0) blue:(b / 255.0) alpha:a]

@interface WeChatCellCommentView ()<MLLinkLabelDelegate>
@property (nonatomic, strong) NSArray *likeItems;
@property (nonatomic, strong) NSArray *commentItems;

@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) MLLinkLabel *likeLabel;
@property (nonatomic, strong) UIView *likeLableBottomLine;

@property (nonatomic, strong) NSMutableArray *commentLabels;
@end

@implementation WeChatCellCommentView

- (NSMutableArray *)commentLabels{
    if(!_commentLabels){
        _commentLabels = [[NSMutableArray alloc] init];
    }
    return _commentLabels;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setupCellCommentView];
        
        
    }
    return self;
}

- (void)setupCellCommentView{
    //背景图
    UIImageView *bgImageView = [[UIImageView alloc] init];
    [bgImageView setImage:[UIImage resizedImageWithName:@"LikeCmtBg"]];
    [bgImageView setBackgroundColor:[UIColor clearColor]];
    [self addSubview:bgImageView];
    self.bgImageView = bgImageView;
    
    //点赞标签
    MLLinkLabel *likeLabel = [[MLLinkLabel alloc] init];
    [likeLabel setFont:LabelFontSize];
    [likeLabel setNumberOfLines:0];
    [likeLabel setLinkTextAttributes:@{NSForegroundColorAttributeName : CellHighlightedColor}];

    [self addSubview:likeLabel];
    self.likeLabel = likeLabel;
    
    //点赞与评论分割线
    UIView *likeLabelBottomLine = [[UIView alloc] init];
    [likeLabelBottomLine setBackgroundColor:RGBColor(210, 210, 210, 1.0f)];
    [self addSubview:likeLabelBottomLine];
    self.likeLableBottomLine = likeLabelBottomLine;
   
}

- (void)setCommentItems:(NSArray *)commentItems{
    _commentItems = commentItems;
    
    long originLabelsCount = self.commentLabels.count;
    long needAddCount = commentItems.count > originLabelsCount ?  (commentItems.count - originLabelsCount) : 0;

    
    for(NSInteger index = 0; index < needAddCount; index++){
        MLLinkLabel *label = [[MLLinkLabel alloc] init];
        [label setLinkTextAttributes: @{NSForegroundColorAttributeName : CellHighlightedColor}];
        [label setFont:LabelFontSize];
        [label setDelegate:self];
        [self addSubview:label];
        [self.commentLabels addObject:label];
    }
 
    for(NSInteger index = 0; index < commentItems.count;index++){
        CellCommentItemModel *model = commentItems[index];
        MLLinkLabel *label = self.commentLabels[index];
        [label setNumberOfLines:0];
        if(!model.attributedContent){
            model.attributedContent = [self generateAttributedCommentItemModel:model];
        }
        label.attributedText = model.attributedContent;
    }
}

- (void)setLikeItems:(NSArray *)likeItems{
    _likeItems = likeItems;
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.image = [UIImage imageNamed:@"Like"];
    
    attach.bounds = CGRectMake(0, -3, 16, 16);
    NSAttributedString *likeIcon = [NSAttributedString attributedStringWithAttachment:attach];
    NSMutableAttributedString *attributeText = [[NSMutableAttributedString alloc] initWithAttributedString:likeIcon];
    for(NSInteger index  = 0; index < likeItems.count; index++){
        CellLikeItemModel *model = likeItems[index];
        if(index > 0){
            [attributeText appendAttributedString:[[NSAttributedString alloc] initWithString:@"，"]];
        }
        
        if(!model.attributedContent){
            model.attributedContent = [self generateAttributedLinkeItemModel:model];
        }
        [attributeText appendAttributedString:model.attributedContent];
    }
    _likeLabel.attributedText = [attributeText copy];
}


- (NSInteger)setupWithLikeItems:(NSArray *)likeItems commentItemsArray:(NSArray *)commentItems{
    self.likeItems = likeItems;
    self.commentItems = commentItems;
    
    //评论视图重置高度
    [self setHeight:0];
    
    //重用评论label
    if(self.commentLabels.count){
        [self.commentLabels enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL * _Nonnull stop) {
            //重置布局
            [label resetLayout];
            [label setHidden:YES];

        }];
    }
    //若没有评论与点赞
    if(!commentItems.count&&!likeItems.count){
        // 如果没有评论或者点赞，设置commentview的固定宽度为0（设置了fixedWith的控件将不再在自动布局过程中调整宽度）
        self.width = 0;
    }


    UIView *lastTopView = nil;
    [lastTopView resetLayout];
    
    if(likeItems.count){
        
//        [self.likeLabel leftOffSetFrom:self withOffset:bPadding];
//        [self.likeLabel rightOffSetFrom:self withOffset:bPadding];
        [self.likeLabel setWidth:(self.width - bPadding*2)];
        [self.likeLabel topOffSetTo:lastTopView withOffset:bMargin];
        DebugLog(@"like label width %lf",self.likeLabel.width);
        //固定宽度,自定义宽度
        [self.likeLabel sizeLevelWidth:self.likeLabel.width];
        DebugLog(@"like label width %lf",self.likeLabel.width);
        lastTopView = self.likeLabel;
    
    }else{
        self.likeLabel.attributedText = nil;
        [self.likeLabel resetLayout];
    }
    
    //如果同时存在评论和点赞显示分割线
    if(self.commentItems.count&&self.likeItems.count){
        [self.likeLableBottomLine setSize:CGSizeMake(self.width, 1)];
        [self.likeLableBottomLine topOffSetTo:lastTopView withOffset:3];
        
        DebugLog(@"nei--->分割线的 frame:%@",NSStringFromCGRect(self.likeLableBottomLine.frame));
        lastTopView = self.likeLableBottomLine;
    }else{
        [self.likeLableBottomLine resetLayout];
    }

    for(NSInteger index = 0; index < self.commentItems.count; index++){
        UILabel *label = (UILabel *)self.commentLabels[index];
        label.hidden = NO;
        CGFloat labelMargin = (index == 0 && likeItems.count == 0) ? bMargin : bPadding;
        [label leftOffSetFrom:self withOffset:bMargin - 2];
        [label rightOffSetFrom:self withOffset:bPadding];
        [label sizeLevelWidth:label.width];
        [label topOffSetTo:lastTopView withOffset:labelMargin];
        //自定义高度
        [label sizeLevelWidth:self.width];
        DebugLog(@"####--->commentView frame %@",NSStringFromCGRect(self.frame));
         DebugLog(@"####--->Label frame %@",NSStringFromCGRect(label.frame));
        lastTopView = label;
    }
    self.height = lastTopView.y + lastTopView.height + bMargin;
    //布局背景图
    [self.bgImageView setFrame:self.frame];
    return self.height;
}


- (NSMutableAttributedString *)generateAttributedCommentItemModel:(CellCommentItemModel *)model
{
    NSString *text = model.firstUserName;
    if (model.secondUserName.length) {
        text = [text stringByAppendingString:[NSString stringWithFormat:@"回复%@", model.secondUserName]];
    }
    text = [text stringByAppendingString:[NSString stringWithFormat:@"：%@", model.commentString]];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text];
    [attString setAttributes:@{NSLinkAttributeName : model.firstUserId} range:[text rangeOfString:model.firstUserName]];
    if (model.secondUserName) {
        [attString setAttributes:@{NSLinkAttributeName : model.secondUserId} range:[text rangeOfString:model.secondUserName]];
    }
    return attString;
}


- (NSMutableAttributedString *)generateAttributedLinkeItemModel:(CellLikeItemModel *)model{
    NSString *text = model.userName;
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text];
    [attString setAttributes:@{NSForegroundColorAttributeName : [UIColor blueColor], NSLinkAttributeName : model.userId} range:[text rangeOfString:model.userName]];
    return attString;
}

#pragma mark - MLLinkLabelDelegate

- (void)didClickLink:(MLLink *)link linkText:(NSString *)linkText linkLabel:(MLLinkLabel *)linkLabel{
    NSLog(@"%@", link.linkValue);
}

@end
