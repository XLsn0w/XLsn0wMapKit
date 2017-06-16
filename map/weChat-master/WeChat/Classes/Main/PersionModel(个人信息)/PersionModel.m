//
//  PersionModel.m
//  WeChat
//
//  Created by 李莎鑫 on 2017/1/22.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

#import "PersionModel.h"
#import "XMPPvCardTemp.h"
#import "ServersConfig.h"

@implementation PersionModel

static id _instance;

// 实现创建单例对象的类方法
+ (instancetype)sharedPersionModel {
    
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


- (void)asyLocalDataFormServers{
     XMPPvCardTemp *myCard = [XMPPTools sharedXMPPTools].vCard.myvCardTemp;
    
    // 1.取出头像
    if(myCard.photo){
        self.headIcon = [UIImage imageWithData:myCard.photo];
        //缓存头像
        // 存入沙盒预留缓存图片
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *imageFilePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",self.wechatID]];
        DebugLog(@"路径：%@",imageFilePath);
        NSData *data = [NSData dataWithContentsOfFile:imageFilePath];
        
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:self.headIcon];
        [imageView setSize:CGSizeMake(100, 100)];
        
        UIGraphicsBeginImageContext(imageView.size);
        
        [imageView.layer renderInContext:UIGraphicsGetCurrentContext()];
        
        UIImage *temp = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        UIImageWriteToSavedPhotosAlbum(temp, nil, nil, nil);
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        // 保存文件的名称
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",self.wechatID]];
        //判断沙盒中是否缓存了该图片,且图片是否被修改了
        if(!data || ![data isEqualToData:UIImagePNGRepresentation(imageView.image)]){
            // 保存成功会返回YES
            BOOL result = [UIImagePNGRepresentation(imageView.image) writeToFile: filePath atomically:YES];
            if(result){
                DebugLog(@"写入图片成功");
            }
        }
    }
    
    // 2.取出用户名
    if(myCard.formattedName){
        self.name = [NSString replaceUnicode:myCard.formattedName];
    }
    
    // 3.取出昵称
    if(myCard.nickname){
        self.nickName = [NSString replaceUnicode:myCard.nickname];
    }
    
    // 4.取出微信号
    if(myCard.jid.user){
        self.wechatID = myCard.jid.user;
    }
    
    // 5.个性签名
    if(myCard.title){
        self.signature = [NSString replaceUnicode:myCard.title];
    }
    
    // 6.性别
    if(myCard.prefix){
        self.gender = [NSString replaceUnicode:myCard.prefix];
    }
    
    
    
}

- (void)updateLocalDataToServers{
    XMPPvCardTemp *myCard = [XMPPTools sharedXMPPTools].vCard.myvCardTemp;
    // 1.默认图片
    if(!self.headIcon){
        self.headIcon = [UIImage imageNamed:@"DefaultProfileHead"];
    }
    
    // 2.默认用户名
    if(!self.name){
        self.name = self.wechatID;
    }
    
    // 3.默认昵称
        self.nickName = self.wechatID;
    
    // 5. 个性签名
    if(!self.signature){
        self.signature = @"做一个快乐的人";
    }
    
    // 6.存入沙盒预留缓存图片
      NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *imageFilePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",self.wechatID]];
    DebugLog(@"路径：%@",imageFilePath);
    NSData *data = [NSData dataWithContentsOfFile:imageFilePath];
    
   
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.headIcon];
    [imageView setSize:CGSizeMake(100, 100)];
    
    UIGraphicsBeginImageContext(imageView.size);
    
    [imageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *temp = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(temp, nil, nil, nil);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    // 保存文件的名称
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",self.wechatID]];
   //判断沙盒中是否缓存了该图片,且图片是否被修改了
    if(!data || ![data isEqualToData:UIImagePNGRepresentation(imageView.image)]){
        // 保存成功会返回YES
        BOOL result = [UIImagePNGRepresentation(imageView.image) writeToFile: filePath atomically:YES];
        if(result){
            DebugLog(@"写入图片路径：%@",filePath);
            DebugLog(@"写入图片成功");
        }
    }
    
    //7.性别
    if(!self.gender){
        self.gender = @"男";
    }
    
    
    myCard.photo = UIImagePNGRepresentation(self.headIcon);
    myCard.formattedName =[NSString utf8ToUnicode:self.name];
    myCard.nickname = [NSString utf8ToUnicode:self.nickName];
    myCard.prefix = [NSString utf8ToUnicode:self.gender];
    myCard.title = [NSString utf8ToUnicode:self.signature];
    myCard.jid = [XMPPJID jidWithUser:self.wechatID domain:LOCALHOSTIP resource:[[UIDevice currentDevice] iphoneType]];

    [[XMPPTools sharedXMPPTools].vCard updateMyvCardTemp:myCard];
}



@end
