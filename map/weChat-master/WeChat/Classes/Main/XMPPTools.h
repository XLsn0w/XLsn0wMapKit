//
//  XMPPTools.h
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/22.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPPFramework.h"
#import "AppDelegate.h"


typedef enum{
    XmppResultTypeAuthenticateSuccess         =  0,
    XmppResultTypeAuthenticateFailed          =  1,
    XmppResultTypeNetWorkConnectFailed        =  2,
    XmppResultTypeNetWorkDisconnectSuccess    =  3,
    XmppResultTypeNetWorkAuthenticatePassword =  4,
    XmppResultTypeNetWorkRegisterSuccess      =  5,
    XmppResultTypeNetWorkRegisterFailed       =  6,
}XmppResultType;

typedef enum{
    ConnectToHostLogin    = 0,
    ConnectToHostRegister = 1,
}ConnectToHostStyle;

@protocol XmppToolsDelegate <NSObject>


@optional
- (void)xmppToolsDelegate:(AppDelegate *)app didAuthenticate:(XMPPStream *)sender;

@end

typedef void(^XmppToolsDelegateBlock)(XmppResultType result);
typedef void(^XmppToolsDelegateLogoutBlock)(XmppResultType result,AppDelegate *app);
typedef void(^XmppToolsDelegateRegisterBlock)(XmppResultType result,AppDelegate *app);

@interface XMPPTools : NSObject

@property (nonatomic,strong)XMPPStream *xmppstream;
// 个人电子名片
@property (nonatomic,strong)XMPPvCardTempModule *vCard;
// 好友花名册
@property (nonatomic,strong)XMPPRoster *roster;
//好友花名册数据存储
@property (nonatomic,strong)XMPPRosterCoreDataStorage *rosterStorage;

@property (nonatomic,weak)id<XmppToolsDelegate> delegate;
@property (nonatomic,copy)XmppToolsDelegateBlock block;
@property (nonatomic,copy)XmppToolsDelegateLogoutBlock logoutBlock;
@property (nonatomic,copy)XmppToolsDelegateRegisterBlock registerBlock;

- (void)XmppUsrConnectToHost:(NSString *) hostname withHostPort:(UInt16) port andCallBackResult:(XmppToolsDelegateBlock) block;

- (void)XmmpUsrReisterSendPasswordToHost:(NSString *) pwd;
- (void)XmppUsrRegisterToHost:(NSString *) hostname withHostPort:(UInt16) port andRegisterUsrName:(NSString *) name  andCallBackResult:(XmppToolsDelegateRegisterBlock) block;
- (void)XmppUsrLogoutwithCallBackResult:(XmppToolsDelegateLogoutBlock) block;

+ (instancetype )sharedXMPPTools;
@end
