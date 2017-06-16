//
//  XMPPTools.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/22.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "XMPPTools.h"
#import "UIDevice+IphoneType.h"
#import "HomePageViewController.h"
#import "MUAssosiation.h"


@interface XMPPTools () <XMPPStreamDelegate>
{
    // 重连模块
    XMPPReconnect *_reconnect;
    // 电子名片数据库
    XMPPvCardCoreDataStorage * _vCardStorage;
    // 头像模块
    XMPPvCardAvatarModule    * _vCardAvatar;
}

@property (nonatomic,assign) ConnectToHostStyle connectStyle;

//1. 初始化xmppstream

- (void)setupXMPPStream;

//2. 连接到服务器
- (void)connectToHost:(NSString *) hostname withPort:(UInt16) port withConnectStyle:(ConnectToHostStyle) style andUserName:(NSString *) User;

//3. 连接到服务器成功后，再发送密码授权
- (void)sendPassWordToHost:(NSString *) password;

//4. 授权成功后，发送在线消息
- (void)sendOnlineToHost;
@end

@implementation XMPPTools

// 声明一个全局对象
static id _instance;

// 实现创建单例对象的类方法
+ (instancetype)sharedXMPPTools {
    
    static dispatch_once_t onceToken;
    
    /**
     dispatch_once  一次性执行
     它是安全的，系统已经自动帮我们加了锁，所以在多个线程抢夺同一资源的时候，也是安全的
     */
    
    dispatch_once(&onceToken, ^{
        NSLog(@"---once---");
        
        // 这里也会调用到 allocWithZone 方法
        _instance = [[self alloc] init];
    });
    return _instance;
}

#warning 一般单例直接share，但是写上 copy 和 alloc 更加严谨
// 利用alloc 创建对象也要返回单例
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
#warning 这里必须调用父类的方法，把空间传给父类，让父类进行空间的分配，若还用[[self allic] init] 则会产生死循环
        _instance = [super allocWithZone:zone];
    });
    
    return _instance;
}

// 遵守NSCopying 协议,ios7 以后不遵守也可以
- (id)copyWithZone:(NSZone *)zone {
    
    // 这里直接返回对象，因为既然是赋值，说明已经通过上面两种方式之一开始创建了
    return _instance;
}

#pragma mark - xmpp 登录服务器方法 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
//1. 初始化xmppstream
- (void)setupXMPPStream{
    _xmppstream = [[XMPPStream alloc] init];
    
    //自动重连功能
    _reconnect = [[XMPPReconnect alloc] init];
    [_reconnect activate:_xmppstream];
    
#pragma mark - 电子名片模块，每一个模块都要激活才能使用
    //电子名片
    _vCardStorage = [XMPPvCardCoreDataStorage sharedInstance];
    
    _vCard = [[XMPPvCardTempModule alloc] initWithvCardStorage:_vCardStorage];
    [_vCard activate:_xmppstream];
    //头像模块
    _vCardAvatar = [[XMPPvCardAvatarModule alloc] initWithvCardTempModule:_vCard];
    [_vCardAvatar activate:_xmppstream];
    //好友列表
    _rosterStorage =  [[XMPPRosterCoreDataStorage alloc] init];
    _roster = [[XMPPRoster alloc] initWithRosterStorage:_rosterStorage];
    [_roster activate:_xmppstream];
    
    
    //设置代理
    [_xmppstream addDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
}

//2. 连接到服务器
- (void)connectToHost:(NSString *) hostname withPort:(UInt16) port withConnectStyle:(ConnectToHostStyle) style andUserName:(NSString *) User{
    
    if(!_xmppstream){
        //a. 初始化xmppstream
        [self setupXMPPStream];
    }
    
    //设置链接类型
    self.connectStyle = style;
    
    //b. 设置JID
    XMPPJID *jid = [XMPPJID jidWithUser:User domain:hostname resource:[[UIDevice currentDevice] iphoneType]];
    
    
    [_xmppstream setMyJID:jid];
    
    //c. 设置服务器域名或者对应的ip
    [_xmppstream setHostName:hostname];
    
    
    
    //d. 设置端口，如果服务器端口是5222，可省略
    [_xmppstream setHostPort:port];
    
    //e. 连接
    NSError *error = nil;
    if(![_xmppstream connectWithTimeout:XMPPStreamTimeoutNone error:&error]){
        NSLog(@"%@",error);
    }
}

//3. 连接到服务器成功后，再发送密码授权
- (void)sendPassWordToHost:(NSString *) password{
    //f. 发送密码授权
    NSError *error = nil;
    
    [_xmppstream authenticateWithPassword:password error:&error];
    if(error){
        NSLog(@"%@",error);
    }
}

//4. 授权成功后，发送“在线”消息
- (void)sendOnlineToHost{
    XMPPPresence *presence = [XMPPPresence presence];
    
    //g. 发送在线消息
    [_xmppstream sendElement:presence];
}

// 用户注销接口函数
- (void)XmppUsrLogoutwithCallBackResult:(XmppToolsDelegateLogoutBlock) block{
    
    self.logoutBlock = block;
    
    //1. 发送“离线”消息
    XMPPPresence *offline = [XMPPPresence presenceWithType:@"unavailable"];
    [_xmppstream sendElement:offline];
    
    //2. 与服务器断开连接
    [_xmppstream disconnect];
    
    NSLog(@"注销");
}

// 用户登录函数
- (void)XmppUsrConnectToHost:(NSString *) hostname withHostPort:(UInt16) port andCallBackResult:(XmppToolsDelegateBlock) block{
    
    self.block = block;
    
    if(_xmppstream.isConnected){
        [_xmppstream disconnect];
    }
    
    NSString *User = [[NSUserDefaults standardUserDefaults] objectForKey:@"usr"];
    [self connectToHost:hostname withPort:port withConnectStyle:ConnectToHostLogin andUserName:User];
}

// 用户注册函数

- (void)XmppUsrRegisterToHost:(NSString *)hostname withHostPort:(UInt16)port andRegisterUsrName:(NSString *)name andCallBackResult:(XmppToolsDelegateRegisterBlock)block{
    self.registerBlock = block;
    
    if(_xmppstream.isConnected){
        [_xmppstream disconnect];
    }
    
    // 发送注册链接
    [self connectToHost:hostname withPort:port withConnectStyle:ConnectToHostRegister andUserName:name];
}

// 发送登录密码
- (void)XmmpUsrReisterSendPasswordToHost:(NSString *) pwd{
    [_xmppstream registerWithPassword:pwd error:nil];
}
#pragma mark - xmppstream代理方法
// 链接服务器成功
- (void)xmppStreamDidConnect:(XMPPStream *)sender{
    NSLog(@"连接主机成功！");
    
    AppDelegate *app =(AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if(self.connectStyle == ConnectToHostLogin){
        //3. 连接主机成功后发送登录密码授权
        NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"pwd"];
        [self sendPassWordToHost:password];
    }else{
        //3. 连接主机成功后提示发送注册密码授权
        if(self.registerBlock){
            dispatch_async(dispatch_get_main_queue(), ^{
                self.registerBlock(XmppResultTypeNetWorkAuthenticatePassword,app);
            });
        }
    }
}

// 服务器断开链接
- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error{
    NSLog(@"与主机断开连接! %@",error);
    if(error && self.block){
        dispatch_async(dispatch_get_main_queue(), ^{
            self.block(XmppResultTypeNetWorkConnectFailed);
        });
    }
    
    AppDelegate *app =(AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if(error && self.registerBlock){
        dispatch_async(dispatch_get_main_queue(), ^{
            self.registerBlock(XmppResultTypeNetWorkConnectFailed,app);
        });
    }
    
    if(self.logoutBlock){
        dispatch_async(dispatch_get_main_queue(), ^{
            self.logoutBlock(XmppResultTypeNetWorkDisconnectSuccess,app);
        });
    }
}

// 授权成功
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender{
    NSLog(@"授权成功！");
    
    //4. 授权成功后，发送在线消息
    [self sendOnlineToHost];
    
    //销毁控制器
    if(self.block){
        self.block(XmppResultTypeAuthenticateSuccess);
    }
    
    //更新同步数据
    PersionModel *data = [PersionModel sharedPersionModel];
    data.wechatID = [[NSUserDefaults standardUserDefaults] objectForKey:@"usr"];
    [data asyLocalDataFormServers];
    
     AppDelegate *app =(AppDelegate *)[[UIApplication sharedApplication] delegate];

    //切换控制器
    if([self.delegate respondsToSelector:@selector(xmppToolsDelegate:didAuthenticate:)]){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate xmppToolsDelegate:app didAuthenticate:sender];
        });
    }
    
    
}

// 登录密码授权失败
- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error{
    NSLog(@"授权失败 - %@",error);
    
    if(self.block){
        dispatch_async(dispatch_get_main_queue(), ^{
            self.block(XmppResultTypeAuthenticateFailed);
        });
    }
}

// 注册成功
- (void)xmppStreamDidRegister:(XMPPStream *)sender{
     AppDelegate *app =(AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(self.registerBlock){
        dispatch_async(dispatch_get_main_queue(), ^{
            self.registerBlock(XmppResultTypeNetWorkRegisterSuccess,app);
        });
    }
}

// 注册失败
- (void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error{
     AppDelegate *app =(AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if(self.registerBlock){
        dispatch_async(dispatch_get_main_queue(), ^{
            self.registerBlock(XmppResultTypeNetWorkRegisterFailed,app);
        });
    }
}


- (void)dealloc{
    [self teardownXmppStream];
    DebugLog(@"释放资源了");
}

#pragma mark - 释放xmppStream相关的资源

- (void)teardownXmppStream{
    // 移除代理
    [_xmppstream removeDelegate:self];
    // 停止模块
    [_reconnect deactivate];
    [_vCard deactivate];
    [_vCardAvatar deactivate];
    [_roster deactivate];
    //  断开连接
    [_xmppstream disconnect];
    // 清空资源
    _xmppstream = nil;
    _vCard = nil;
    _vCardAvatar = nil;
    _vCardStorage = nil;
    _reconnect = nil;
    _roster = nil;
    _rosterStorage = nil;
    
}
@end
