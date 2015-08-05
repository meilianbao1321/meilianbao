//
//  XMPPConfig.h
//  MeiPinJie
//
//  Created by mac on 15/6/26.
//  Copyright (c) 2015年 Alex. All rights reserved.
//

#ifndef MeiPinJie_XMPPConfig_h
#define MeiPinJie_XMPPConfig_h

//openfire服务器IP地址   yzbb.mzywx.com/yzbb/:9090   182.254.137.36
#define  kHostName      @"yzbb.mzywx.com"
//openfire服务器端口 默认5222
#define  kHostPort      5222
//openfire域名
#define kDomin @"openfireserver"
//resource
#define kResource @"iOS"

#define JID(userName) [XMPPJID jidWithString:[NSString stringWithFormat:@"%@@%@",userName,kHostName]]
#endif
