//
//  IMCoreManager.m
//  WNL_IMCore
//
//  Created by wannili on 14/11/20.
//  Copyright (c) 2014年 wannili. All rights reserved.
//

#import "IMCoreManager.h"

typedef void(^SuccessBlock)(id successInfo);
typedef void(^FailureBlock)(id failureInfo);


@interface IMCoreManager ()<XMPPStreamDelegate,XMPPRosterDelegate,XMPPRoomDelegate,UIAlertViewDelegate>
{
    //  好友管理CoreData
    XMPPRosterCoreDataStorage       *_rosterCoreDataStorage;
    
    //好友请求来源于哪个jid
    XMPPJID                         *_friendRequestJID;
 
    
    //  登录时的用户名
    NSString *_currentUser;
    
    //  注册时的用户名
    NSString *_signUpUser;
    
    //  密码
    NSString *_password;
    
    
    //  成功&失败block，目前仅仅用于登录注册
    SuccessBlock _successBlock;
    FailureBlock _failureBlock;
    
    NSString *_user;

}

@end

@implementation IMCoreManager

+(IMCoreManager *)Core{
    static IMCoreManager *core = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        core = [IMCoreManager new];
    });
    return core;
}

- (instancetype)init{
    if (self = [super init]) {
        [self setupXMPP];
    }
    return self;
}

- (void)setupXMPP{
    //  1.初始化XMPPStream，XMPPStream是和服务器建立连接的关键
    _stream = [XMPPStream new];
    self.reconnect =[[XMPPReconnect alloc]init];
    [self.reconnect activate:_stream];
    _stream.hostName = kHostName;
    _stream.hostPort = kHostPort;
    _stream.enableBackgroundingOnSocket = YES;
    [_stream addDelegate:self delegateQueue:(dispatch_get_main_queue())];
    [self.reconnect addDelegate:self delegateQueue:dispatch_get_main_queue()];
    //  实例化好友管理对象，主线程创建使用CoreData的存储器（所以说可以用XMPPFramework自带的CoreData存储好友？）
    _rosterCoreDataStorage = [XMPPRosterCoreDataStorage sharedInstance];
    _roster = [[XMPPRoster alloc]initWithRosterStorage:_rosterCoreDataStorage dispatchQueue:(dispatch_get_main_queue())];
    
    [_roster activate:_stream];
    [_roster addDelegate:self delegateQueue:(dispatch_get_main_queue())];
    
    XMPPMessageArchivingCoreDataStorage *messageArchivingCoreDataStorage  =[XMPPMessageArchivingCoreDataStorage sharedInstance];
    self.xmppMessageArchiving = [[XMPPMessageArchiving alloc]initWithMessageArchivingStorage:messageArchivingCoreDataStorage dispatchQueue:dispatch_get_main_queue()];
    [self.xmppMessageArchiving activate:self.stream];
    self.messageArchivingManagedObjectContext = messageArchivingCoreDataStorage.mainThreadManagedObjectContext;

}

//连接服务器
- (void)connectToServer{
    //如果已经存在一个连接，需要断开当前连接，然后在建立新的链接
    if ([self.stream isConnected]) {
        [self disConnectWithServer];
    }    NSError *error;
    [self.stream connectWithTimeout:30 error:&error];
    
    if (error) {
        NSString *errorUserInfoMessage = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        
    }
}

//与服务器断开连接
- (void)disConnectWithServer{
    XMPPPresence *Presence = [XMPPPresence presenceWithType:@"unavailable"];
    [[IMCoreManager Core].stream sendElement:Presence];
    [self.stream disconnect];
}


- (void)connectToServerWithUserName:(NSString *)username{
    XMPPJID *myJID = [XMPPJID jidWithUser:username domain:kDomin resource:kResource];
    self.stream.myJID = myJID;
    [self connectToServer];
}

//登陆
- (instancetype)signInWithUserName:(NSString *)userName
                          password:(NSString *)password
                           success:(void (^)(id))success
                           failure:(void (^)(id))failure{
    
    _currentUser = userName;
    _password = password;
    _successBlock = success;
    _failureBlock = failure;

    [self connectToServerWithUserName:userName];
    return nil;
    
}

//登出()
- (void)signOutWhenSuccess:(void (^)(id))success failure:(void (^)(id))failure{

    [self disConnectWithServer];
}

//注册
- (instancetype)signUpWithUserName:(NSString *)userName password:(NSString *)password success:(void (^)(id))success failure:(void (^)(id))failure{
    
    _password = password;
    _signUpUser = userName;
    _successBlock = success;
    _failureBlock = failure;
    
    [self connectToServerWithUserName:userName];
    return nil;
}

//连接成功
- (void)xmppStreamDidConnect:(XMPPStream *)sender{
    NSLog(@"连接成功");
    NSError *error;
    if (_currentUser) {
        [sender authenticateWithPassword:_password error:&error];
    }else if (_signUpUser){
        [sender registerWithPassword:_password error:&error];
    }
}

// 与服务器连接超时
- (void)xmppStreamConnectDidTimeout:(XMPPStream *)sender{
    NSLog(@"连接超时");
}

//认证成功
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender{
//    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"haveLogin"] == NO) {
//        return;
//    }
    NSDictionary *successInfo = @{@"userName":      _currentUser,
                                  @"userPassword":  _password};
    P1Block(_successBlock, successInfo);
    //上线
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"available"];
    [[IMCoreManager Core].stream sendElement:presence];
    _currentUser = successInfo[@"userName"];
    
}
//认证失败
- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error{
    NSDictionary *failureInfo = @{@"userName":      _currentUser,
                                  @"userPassword":  _password};
    P1Block(_failureBlock, failureInfo);
    
}
//注册成功
- (void)xmppStreamDidRegister:(XMPPStream *)sender{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"注册成功" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}

//注册失败
- (void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error{
    
}

//收到好友请求
- (void)xmppRoster:(XMPPRoster *)sender didReceivePresenceSubscriptionRequest:(XMPPPresence *)presence{

    if (presence.from.user) {
        _friendRequestJID = presence.from;
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"收到好友请求"
                                                           message:[NSString stringWithFormat:@"是否同意用户%@的好友请求，并添加对方为好友？",presence.from.user]
                                                          delegate:self
                                                 cancelButtonTitle:@"取消"
                                                 otherButtonTitles:@"接受", nil];
        [alertView show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
        {
            [_roster rejectPresenceSubscriptionRequestFrom:_friendRequestJID];
        }
            break;
        case 1:
        {
            [_roster acceptPresenceSubscriptionRequestFrom:_friendRequestJID andAddToRoster:YES];
        }
            break;
        default:
            break;
    }
}
//再次处理加好友
- (void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence{
    //取得好友状态
    NSString *presenceType = [NSString stringWithFormat:@"%@", [presence type]]; //online/offline
    //在线用户
     NSString *presenceFromUser =[NSString stringWithFormat:@"%@", [[presence from] user]];
    NSLog(@"%@",presenceFromUser);
    //这里再次加好友
    if ([presenceType isEqualToString:@"subscribed"]) {
        XMPPJID *jid = [XMPPJID jidWithString:[NSString stringWithFormat:@"%@",[presence from]]];
        [self.roster acceptPresenceSubscriptionRequestFrom:jid andAddToRoster:YES];
    }
}
//处理好友请求并且加为好友
- (void)xmppRoster:(XMPPRoster *)sender didReceiveRosterItem:(DDXMLElement *)item{
    
    [self.rosterDelegate didReceiveRosterItem:item];
}
//添加好友
- (void)addUserWithUserName:(NSString *)userName nickName:(NSString *)nickName{
    
    XMPPJID *jid = [XMPPJID jidWithString:[NSString stringWithFormat:@"%@@%@",userName,kHostName]];
    NSLog(@"%@",jid);
    [self.roster subscribePresenceToUser:jid ];
}

#pragma mark - 发送消息
//文本
- (XMPPMessage *)sendTextMessage:(NSString *)text to:(NSString *)userName{
    
    XMPPMessage *message = [XMPPMessage messageWithType:@"chat" to:JID(userName)];
    [message addBody:text];
    [_stream sendElement:message];
    return message;
}

//音频
- (XMPPMessage *)sendVoiceMessage:(NSString *)voiceUrl to:(NSString *)userName{
    XMPPMessage *voiceMessage = [XMPPMessage messageWithType:@"voice" to:JID(userName)];
    [voiceMessage addBody:voiceUrl];
//    [voiceMessage addBody:@"kjdbfd"];
    [_stream sendElement:voiceMessage];
    return voiceMessage;
}
//图片
- (XMPPMessage *)sendImageMessage:(NSString *)imageUrl to:(NSString *)userName{
    XMPPMessage *message = [XMPPMessage messageWithType:@"image" to:JID(userName)];
    [message addBody:imageUrl];
    [_stream sendElement:message];
    return message;
}

- (BOOL)xmppStream:(XMPPStream *)sender didReceiveIQ:(XMPPIQ *)iq{
    if (iq.isGetIQ) {
        //解析iq 是ping类型则给openfier 响应一个IQ
        
        NSXMLElement *query = iq.childElement;
        
        if ([@"ping" isEqualToString:query.name]) {
            
            //服务器会在给定的时间内向客户端发送ping包（用来确认客户端用户是否在线）,当第二次发送bing包时，如果客户端无响应则会T用户下线
            
            NSXMLElement *ping = [NSXMLElement elementWithName:@"ping" xmlns:@"jabber:client"];
            
            NSXMLElement *iq = [NSXMLElement elementWithName:@"iq"];
            
            XMPPJID *myJID = self.stream.myJID;
            
            [iq addAttributeWithName:@"from" stringValue:myJID.description];
            
            [iq addAttributeWithName:@"to" stringValue:myJID.domain];
            
            [iq addAttributeWithName:@"type" stringValue:@"get"];
            
            [iq addChild:ping];
            
            //发送的iq可以不做任何的设置
            
            [self.stream sendElement:iq];
            
        }
    }
    return YES;
}

//  收到消息
- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message{
    sender.enableBackgroundingOnSocket = YES;
    [self.chatingMessageDelegate didReceiveMessage:message Sender:sender];
}

- (NSString *)currentUser{
    return _user;
}

-(void)dealloc{
    [self.reconnect deactivate];
}


@end
