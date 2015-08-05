//
//  ShareManage.h
//  KONKA_MARKET
//
//  Created by wxxu on 14/12/18.
//  Copyright (c) 2014年 archon. All rights reserved.
//  分享管理

// 友盟APIKey
#define UMeng_APIKey        @"54929012fd98c5740b0003c1"

#define share_title         @"渠道系统APP下载地址共享"
#define share_content       @"渠道系统APP下载地址共享,请点右上角菜单，选择在浏览器打开新窗口打开此页面，然后点下载相应的APP即可到电脑即可"
#define share_url           @"http://qdgl.konka.com/files/konka/appdownloadofwap/index_wap.html"

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>

@interface ShareManage : NSObject <MFMessageComposeViewControllerDelegate>
+ (ShareManage *)shareManage;

- (void)shareConfig;

/**微信分享**/
- (void)wxShareWithViewControll:(UIViewController *)viewC;

/**新浪微博分享**/
- (void)wbShareWithViewControll:(UIViewController *)viewC;

/**微信朋友圈分享**/
- (void)wxpyqShareWithViewControll:(UIViewController *)viewC;

/**短信分享**/
- (void)smsShareWithViewControll:(UIViewController *)viewC;
@end
