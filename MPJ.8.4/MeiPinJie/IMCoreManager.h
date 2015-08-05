//
//  IMCoreManager.h
//  WNL_IMCore
//
//  Created by wannili on 14/11/20.
//  Copyright (c) 2014年 wannili. All rights reserved.


//  和XMPP的通讯都应该在本类实现


#import <Foundation/Foundation.h>
#import "XMPPFramework.h"


@protocol IMCoreRosterDelegate,IMCoreMessageDelegate;

@interface IMCoreManager : NSObject


#define ChatCore  [IMCoreManager Core]

//创建单利来管理XMPP通信

+(IMCoreManager *)Core;

//通信管道，所有与服务器的交互都要通过通信管道完成
@property(nonatomic,strong)XMPPStream *stream;
@property(nonatomic,strong)XMPPRoster *roster;
@property(nonatomic,strong)XMPPReconnect * reconnect;
@property (nonatomic, weak) id<IMCoreRosterDelegate> rosterDelegate;

@property (nonatomic, strong) id<IMCoreMessageDelegate> chatingMessageDelegate;

@property (nonatomic, weak) id<IMCoreMessageDelegate> listMessageDelegate;

// 信息归档
@property(nonatomic,strong) XMPPMessageArchiving *xmppMessageArchiving;

@property (nonatomic,strong) NSManagedObjectContext *messageArchivingManagedObjectContext;

@property (nonatomic, readonly) NSString *currentUser;


#pragma mark - 和XMPPStreamDelegate密切相关
#pragma mark 登陆
- (instancetype)signInWithUserName:(NSString *)userName
                          password:(NSString *)password
                           success:(void(^)(id successInfo))success
                           failure:(void(^)(id failureInfo))failure;

#pragma mark 注册
- (instancetype)signUpWithUserName:(NSString *)userName
                          password:(NSString *)password
                           success:(void(^)(id successInfo))success
                           failure:(void(^)(id failureInfo))failure;

#pragma mark 登出
- (void)signOutWhenSuccess:(void(^)(id successInfo))success
                           failure:(void(^)(id failureInfo))failure;



#pragma mark - 加好友
- (void)addUserWithUserName:(NSString *)userName nickName:(NSString *)nickName;


#pragma mark - 发送消息

#pragma mark 纯文本
- (XMPPMessage *)sendTextMessage:(NSString *)text to:(NSString *)userName;
#pragma mark 图片
- (XMPPMessage *)sendImageMessage:(NSString *)imageUrl to:(NSString *)userName ;
#pragma mark 声音
- (XMPPMessage *)sendVoiceMessage:(NSString *)voiceUrl to:(NSString *)userName;


@end

@protocol IMCoreRosterDelegate <NSObject>

- (void)didReceiveRosterItem:(DDXMLElement *)item;

@end

@protocol IMCoreMessageDelegate <NSObject>

- (void)didReceiveMessage:(XMPPMessage *)message Sender:(XMPPStream *)sender;

@end

