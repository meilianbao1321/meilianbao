//
//  AppDelegate.h
//  MeiPinJie
//
//  Created by mac on 15/6/23.
//  Copyright (c) 2015年 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"
#import "MMDrawerController.h"
#import "YXTabBarViewController.h"
#import "UMSocial.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>{
    BOOL _isFull;
}
@property (strong,nonatomic) NSString *currentResp;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIWindow *tmpWomdow;
@property (strong,nonatomic) MMDrawerController * rooVC;
@property (strong, nonatomic) YXTabBarViewController *tabbar;
@property (strong, nonatomic) NSString * currentAccountNumber;
@property (assign, nonatomic) BOOL isFull;

@property (nonatomic ,assign )BOOL isBack;
@property (nonatomic,assign)BOOL isReload;

@end

