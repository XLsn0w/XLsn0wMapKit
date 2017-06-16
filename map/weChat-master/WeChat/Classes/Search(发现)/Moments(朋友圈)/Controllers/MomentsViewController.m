//
//  MomentsViewController.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/8.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "MomentsViewController.h"
#import "MomentsHeaderView.h"
#import "PhotosViewController.h"
#import "AlbumReflashHeaderIcon.h"
#import "WeChatMomentsCell.h"
#import "WeChatMomentsCellModel.h"
#import "PhotoPickerController.h"
#import "ActionSheet.h"
//#import "UIView+AutoLayout.h"


#define TextFieldHeight   40
static NSString * const cellIdentifier =@"WeChatMomentsCell";

@interface MomentsViewController () <UITextFieldDelegate,WeChatMomentCellDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,PhotoPickerControllerDelegate,ActionSheetDelegate>
@property (nonatomic,strong)MomentsHeaderView *headerView;
@property (nonatomic,strong) AlbumReflashHeaderIcon *refreshHeader;

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, assign) BOOL isReplayingComment;
@property (nonatomic, strong) NSIndexPath *currentEditingIndexthPath;
@property (nonatomic, copy) NSString *commentToUser;
@end

@implementation MomentsViewController
{
//    AlbumReflashHeaderIcon *_refreshHeader;
    CGFloat _lastScrollViewOffsetY;
    
    CGFloat _totalKeyboardHeight;
}


- (instancetype)init{
    return [super initWithStyle:UITableViewStylePlain];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //注册cell
//    [self.tableView registerClass:[WeChatMomentsCell class] forCellReuseIdentifier:cellIdentifier];
    
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:@"朋友圈"];
    //加载模型
    [self.datalist addObjectsFromArray:[self creatMomentsModelDataWithCount:10]];

    //加载界面
    [self setMomentsView];
    
    
    [self updateNewData];
    
    
    DebugLog(@"view加载成功");
    
    //设置键盘与输入框，设置键盘通知
    [self setupTextField];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

#pragma mark - 数据模型 ---------------------------------------
- (NSArray *)creatMomentsModelDataWithCount:(NSInteger) count{
    NSMutableArray *data = [[NSMutableArray alloc] init];
    
    NSArray *iconImageNames = @[@"Alex是大叔.jpg",
                                     @"me",
                                     @"郭德纲.jpg",
                                     @"大城小胖.jpg",
                                     @"青音.jpeg",
                                     @"tencentTV",
                                     @"smartisan.jpg",
                                     @"主播糖糖.jpg",
                                     @"赵丽颖.jpg",
                                     @"StephenHawking.jpg",
                                     ];
    
    NSArray *names = @[@"Alex是大叔",
                       @"李莎鑫",
                       @"我叫郭德纲",
                       @"大城小胖",
                       @"青音❤️",
                       @"腾讯视频",
                       @"锤子科技",
                       @"主播糖糖",
                       @"赵丽颖",
                       @"StephenHawking",
                       ];
    
    NSArray *texts = @[@"明天就要迎来满月了，而且还记不记得我说过，满月会将T三角，暂时性的升级为“大十字”。最近应该有许多“想要做却不知如何做”或“想要做又不敢做”的事情吧。",
                           @"大家也别喷国内玩家没素质。去steam上看了一圈，都差不多。没有自己国家的语言就给差评的国外也有。只是中国人多，容易引起轰动而已。看到最奇葩的是，游戏作者好心在dropbox上提供免费试玩版，结果有个老哥回复到『作为google脑残粉，对于你不把游戏放到google driver上的行为，我只能给差评了』",
                           @"乞丐不会嫉妒世界首富，但会怨恨比自己收入多的乞丐...",
                           @"行了，你够了！你暗恋女王盐这事我早就知道了，不用再强调了！",
                           @"#听青音#别人为什么会占你的便宜？那是因为你把自己看得太便宜。不管你是备胎还是什么其他的，一定要在这个关系当中有尊严，因为你有尊严的话，你才有可能赢得爱情，不能赢得爱情也能赢得自己",
                           @"学习是最有用的，抱怨是最没用的",
                           @"1 月 13 日下午，锤子科技 CEO 罗永浩做客极客公园 2017 年 GIF 大会，与极客公园创始人张鹏一同畅谈锤子科技创业四年来的变化和成长，以及在不同时期思考问题的方式，并展望了未来一年锤子科技的发展方向。",
                           @"心素如简，人淡如菊...🌸.σ(✿✪‿✪｡)ﾉ🍭🍒 🍓…我是收音机里的糖糖…👠、👒🎁、💓",
                           @"#1108青云大战#以我血躯，奉为牺牲。#青云志#第一季收官，",
                           @"I wish to extend a genuine thank you to the Weibo community. It has been an illuminating experience, being able to communicate with all of you here, and I am glad we have had this opportunity to share our ideas and passions. From celebrating holidays together to talking about Zhuan Zhou's Butterfly Dream, our conversations have broadened the scope of my knowledge, as I hope they have broadened yours. In the future I know we will continue to have such fruitful exchanges, and I look forward to seeing what the talent and inquisitiveness of the Chinese people achieves in the realms of science and space.",
                           ];
    
    NSArray *comments = @[@"漂亮！本来好压抑，看这图心情都好起来了，第一时间给个赞并保存了👌👌👌👌",
                               @"学习是最有用的，抱怨是最没用的。。。",
                               @"谁能想到 历史的车轮滚滚 我们和霍金居然成了网友。",
                               @"总是没我",
                               @"你瞅啥？",
                               @"瞅你咋地？？？！！！",
                               @"hello，看我",
                               @"曾经在幽幽暗暗反反复复中追问，才知道平平淡淡从从容容才是真。😊",
                               @"我这评论厉害了，赞我的人三天内必会找到对象 ，吃什么都不胖 ，月薪翻三倍，考试不挂科！！😈",
                               @"咯咯哒",
                               @"呵呵~~~~~~~~",
                               @"握草，我小时候一定是看了假的舒克和贝塔。😓",
                               @"真有意思啊你💢💢💢"];
    
    NSArray *picImageNames = @[ @"1.jpg",
                                     @"2.jpg",
                                     @"3.jpg",
                                     @"4.jpg",
                                     @"5.jpg",
                                     @"6.jpg",
                                     @"7.jpg",
                                     @"8.jpg",
                                     @"9.jpg",
                                     @"10.jpg",
                                     @"11.jpg",
                                     @"12.jpg",
                                     @"13.jpg",
                                     @"14.jpg",
                                     @"15.jpg",
                                    @"16.jpg",
                                    @"17.jpg",
                                    @"18.jpg",
                                    @"19.jpg",
                                    @"20.jpg",
                                    @"21.jpg",
                                    @"22.jpg",
                                    @"23.jpg",
                                    @"24.jpg",
                                    @"25.jpg",
                                    @"26.jpg",
                                    @"27.jpg",
                                    @"28.jpg",
                                     ];
    
    for (int i = 0; i < count; i++) {
        
        WeChatMomentsCellModel *model = [[WeChatMomentsCellModel alloc] init];
        model.iconName = iconImageNames[i];
        model.name = names[i];
        model.msgContent = texts[i];
        
        
        // 模拟“随机图片”
        int random = arc4random_uniform(10);
        
        NSMutableArray *temp = [NSMutableArray new];
        for (int i = 0; i < random; i++) {
            int randomIndex = arc4random_uniform(28);
            [temp addObject:picImageNames[randomIndex]];
        }
        if (temp.count) {
            model.picNamesArray = [temp copy];
        }

        // 模拟随机评论数据
        int commentRandom = arc4random_uniform(3);
        NSMutableArray *tempComments = [NSMutableArray new];
        for (int i = 0; i < commentRandom; i++) {
            CellCommentItemModel *commentItemModel = [[CellCommentItemModel alloc] init];
            int index = arc4random_uniform((int)names.count);
            commentItemModel.firstUserName = names[index];
            commentItemModel.firstUserId = @"666";
            if (arc4random_uniform(13) < 5) {
                commentItemModel.secondUserName = names[arc4random_uniform((int)names.count)];
                commentItemModel.secondUserId = @"888";
            }
            commentItemModel.commentString = comments[arc4random_uniform((int)comments.count)];
            [tempComments addObject:commentItemModel];
        }
        model.commentItems = [tempComments copy];
        
        // 模拟随机点赞数据
        int likeRandom = arc4random_uniform(3);
        NSMutableArray *likes = [NSMutableArray new];
        for (int i = 0; i < likeRandom; i++) {
            CellLikeItemModel *model = [[CellLikeItemModel alloc] init];
            int index = arc4random_uniform((int)names.count);
            model.userName = names[index];
            model.userId = names[index];
            [likes addObject:model];
        }
        
        model.likeItems = [likes copy];
        
        [data addObject:model];
        
   
    }
    
    return [data copy];
}
- (void)setMomentsView{
    
   
#pragma mark - 取消自动适应导航导致TableView的起始位置偏差的问题
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self.tableView setContentInset:UIEdgeInsetsMake(-TopViewOnHeaderViewHeight, 0, 0, 0)];

    
    MomentsHeaderView *headerView = [[MomentsHeaderView alloc] init];
    [headerView setSize:CGSizeMake(self.tableView.width,TopViewOnHeaderViewHeight + AllImageViewHeight)];
    
    weak_self weakSelf = self;
    [headerView setIconImageClick:^{
        PhotosViewController *controller = [[PhotosViewController alloc] init];
        [controller setDelegate:(id)weakSelf];
        [weakSelf.navigationController pushViewController:controller animated:YES];
    }];
    
    
    
    [headerView setBackGroudImageClick:^{
        [weakSelf changePhotosCoverImage];
    }];
    
    self.headerView = headerView;

    
    [self.tableView setTableHeaderView:headerView];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_Camera"] style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClick)];
    self.navigationItem.rightBarButtonItem = right;
    

}

- (void)changePhotosCoverImage{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"更换相册封面" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}



- (void)rightButtonClick{
    
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    
//    [alert addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//#if TARGET_IPHONE_SIMULATOR
//
//#elif TARGET_OS_IPHONE
//        UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
//        ipc.delegate = self;
//        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
//        [self presentViewController:ipc animated:YES completion:nil];
//#endif
//        
//    }]];
//    
//    [alert addAction:[UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        // 采用系统默认的图片浏览器
//        UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
//        photoPicker.delegate = self;
//        photoPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        photoPicker.view.backgroundColor = [UIColor whiteColor];
//        [self presentViewController:photoPicker animated:YES completion:NULL];
//        
//        // 采用自定义的图片浏览器
////        PhotoPickerController *controller = [[PhotoPickerController alloc] initWithMaxImagesCount:9 delegate:self];
////        
////        controller.allowPickingVideo = NO;
////        [self presentViewController:controller animated:YES completion:nil];
//        
//    }]];
//    
//    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        
//    }]];
//    
//    [self presentViewController:alert animated:YES completion:nil];
    
    ActionSheet *actionSheet = [[ActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    [actionSheet show];
}

// 代理方法
- (void)actionSheet:(ActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(!buttonIndex){
#if TARGET_IPHONE_SIMULATOR
        
#elif TARGET_OS_IPHONE
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.allowsEditing = YES;
        
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
#endif
    }else if(buttonIndex == 1){
        // 采用系统默认的图片浏览器
        UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
        photoPicker.delegate = self;
        photoPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        photoPicker.view.backgroundColor = [UIColor whiteColor];
        [self presentViewController:photoPicker animated:YES completion:NULL];
    }
}

#pragma mark - image picker 的代理方法
- ( void )imagePickerController:( UIImagePickerController *)picker didFinishPickingMediaWithInfo:( NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *srcImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    // 进入发送说说界面
    
//    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 刷新图标 ------------------------------------
- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    

    if(!self.refreshHeader.superview){
        
        AlbumReflashHeaderIcon *refreshHeader = [AlbumReflashHeaderIcon refreshHeaderWithCenter:CGPointMake(40, 50)];
        
        weak_self weakSelf = self;
        [refreshHeader setRefreshingBlock:^{
            
        }];
        
        refreshHeader.scrollView = self.tableView;
        self.refreshHeader = refreshHeader;
        
       
    
        [self.tableView.superview addSubview:_refreshHeader];
    }else{
        [self.tableView.superview bringSubviewToFront:_refreshHeader];
    }
   
    [self.tableView setCanCancelContentTouches:NO];
   
}

- (void)updateNewData
{
    __weak typeof(_refreshHeader) weakHeader = _refreshHeader;
 
    [weakHeader endRefreshing];

}

- (void)InitUpdate{
   
}

- (void)dealloc
{
    [_refreshHeader removeFromSuperview];
     [_textField removeFromSuperview];
    
    DebugLog(@"释放了控制器%s",__func__);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_textField resignFirstResponder];
}


#pragma mark - tableView 数据源与代理方法 ---------------------------------------------------------

#pragma mark - 代理方法 计算行高

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    WeChatMomentsCellModel *model = self.datalist[indexPath.row];
    return model.cellHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.datalist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
//     WeChatMomentsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    WeChatMomentsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(!cell){
        cell = [[WeChatMomentsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.indexPath = indexPath;
    __weak typeof(self) weakSelf = self;
    if (!cell.moreButtonClickedBlock) {
        [cell setMoreButtonClickedBlock:^(NSIndexPath *indexPath) {
            //初始化操作
            WeChatMomentsCellModel *model = weakSelf.datalist[indexPath.row];
            WeChatMomentsCell *cell = [weakSelf.tableView cellForRowAtIndexPath:indexPath];
            model.isOpening = !model.isOpening;
            
            [cell setModel:model];
            
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
        
        [cell setDidClickCommentLabelBlock:^(NSString *commentId, CGRect rectInWindow, NSIndexPath *indexPath) {
            DebugLog(@"点赞功能");
            weakSelf.textField.placeholder = [NSString stringWithFormat:@"  回复：%@", commentId];
            weakSelf.currentEditingIndexthPath = indexPath;
            [weakSelf.textField becomeFirstResponder];
            weakSelf.isReplayingComment = YES;
            weakSelf.commentToUser = commentId;
            [weakSelf adjustTableViewToFitKeyboardWithRect:rectInWindow];
        }];
        
        cell.delegate = self;
    }

    cell.model = self.datalist[indexPath.row];
    
    
    return cell;

}

#pragma mark - WeChatMomentCell的代理方法

//点击了点赞按钮
- (void)didClickLikeButtonInCell:(WeChatMomentsCell *)cell{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    WeChatMomentsCellModel *model = self.datalist[indexPath.row];
    NSMutableArray *likes = [NSMutableArray arrayWithArray:model.likeItems];
    PersionModel *data = [PersionModel sharedPersionModel];
    
    //如果评论没有被登录用户点赞过
    if(!model.isLiked){
        CellLikeItemModel *likeMode = [[CellLikeItemModel alloc] init];
    
        //昵称
        likeMode.userName = data.name;
        //账号
        likeMode.userId = data.wechatID;
        [likes addObject:likeMode];
        model.liked = YES;
    }else{
        CellLikeItemModel *oldModel = nil;
        for(CellLikeItemModel *liked in model.likeItems){
            if([liked.userId isEqualToString: data.wechatID]){
                oldModel = liked;
                break;
            }
        }
        [likes removeObject:oldModel];
        model.liked = NO;
    }
    
    model.likeItems = [likes copy];
    
   
    //返回主线程刷新页面
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //重新布局界面
        [cell setModel:model];
        //刷新页面
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    });
}
//点击了评论按钮
- (void)didClickcCommentButtonInCell:(WeChatMomentsCell *)cell{
    [_textField becomeFirstResponder];
    _currentEditingIndexthPath = [self.tableView indexPathForCell:cell];
    
    [self adjustTableViewToFitKeyboard];

}


//适配键盘
- (void)adjustTableViewToFitKeyboard
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:_currentEditingIndexthPath];
    CGRect rect = [cell.superview convertRect:cell.frame toView:window];
    [self adjustTableViewToFitKeyboardWithRect:rect];
}


- (void)adjustTableViewToFitKeyboardWithRect:(CGRect)rect
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGFloat delta = CGRectGetMaxY(rect) - (window.bounds.size.height - _totalKeyboardHeight);
    
    CGPoint offset = self.tableView.contentOffset;
    offset.y += delta;
    if (offset.y < 0) {
        offset.y = 0;
    }
    
    [self.tableView setContentOffset:offset animated:YES];
}


//键盘通知
- (void)keyboardNotification:(NSNotification *)notification
{
    NSDictionary *dict = notification.userInfo;
    CGRect rect = [dict[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    

    CGRect textFieldRect = CGRectMake(0, rect.origin.y - TextFieldHeight, rect.size.width, TextFieldHeight);
    if (rect.origin.y == [UIScreen mainScreen].bounds.size.height) {
        textFieldRect = rect;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        _textField.frame = textFieldRect;
    }];
    
    CGFloat h = rect.size.height + TextFieldHeight;
    if (_totalKeyboardHeight != h) {
        _totalKeyboardHeight = h;
        [self adjustTableViewToFitKeyboard];
    }
}

#pragma mark - UITextFieldDelegate 代理方法

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length) {
        [_textField resignFirstResponder];
        
        WeChatMomentsCellModel *model = self.datalist[_currentEditingIndexthPath.row];
        WeChatMomentsCell *cell = [self.tableView cellForRowAtIndexPath:_currentEditingIndexthPath];
        NSMutableArray *temp = [NSMutableArray new];
        [temp addObjectsFromArray:model.commentItems];
        CellCommentItemModel *commentModel = [CellCommentItemModel new];
        PersionModel *data = [PersionModel sharedPersionModel];
        
        if (self.isReplayingComment) {
            commentModel.firstUserName = data.name;
            commentModel.firstUserId = data.wechatID;
            commentModel.secondUserName = self.commentToUser;
            commentModel.secondUserId = self.commentToUser;
            commentModel.commentString = textField.text;
            
            self.isReplayingComment = NO;
        } else {
            commentModel.firstUserName = data.name;
            commentModel.commentString = textField.text;
            commentModel.firstUserId = data.wechatID;
        }
        [temp addObject:commentModel];
        model.commentItems = [temp copy];
        //设置模型刷新数据
        [cell setModel:model];
        [self.tableView reloadRowsAtIndexPaths:@[_currentEditingIndexthPath] withRowAnimation:UITableViewRowAnimationNone];
        
        _textField.text = @"";
        _textField.placeholder = nil;
        
        return YES;
    }
    return NO;
}


- (void)setupTextField
{
    _textField = [UITextField new];
    _textField.returnKeyType = UIReturnKeyDone;
    _textField.delegate = self;
    _textField.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.8].CGColor;
    _textField.layer.borderWidth = 1;
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.textColor = [UIColor blackColor];
    
    //为textfield添加背景颜色 字体颜色的设置 还有block设置 , 在block中改变它的键盘样式 (当然背景颜色和字体颜色也可以直接在block中写)
    
    
    _textField.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, self.view.width, TextFieldHeight);
    [[UIApplication sharedApplication].keyWindow addSubview:_textField];
    
    [_textField becomeFirstResponder];
    [_textField resignFirstResponder];
}

@end
