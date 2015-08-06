//
//  AppDelegate.m
//  MeiPinJie
//
//  Created by mac on 15/6/23.
//  Copyright (c) 2015年 Alex. All rights reserved.
//

#import "AppDelegate.h"
#import "Reachability.h"

#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourViewController.h"
#import "FirstViewController.h"
#import "MenuViewController.h"

#import "JDSideMenu.h"
#import "ErrorView.h"
#import "APService.h"
#import "UserGuideViewController.h"
#import "payRequsestHandler.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DDMenuController.h"
#import "MMExampleDrawerVisualStateManager.h"


@interface AppDelegate (){
    NSInteger n;
    Reachability * _hostReach;
    NetworkStatus  _currentStauts;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    if (launchOptions) {
        [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    }

    self.window =[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor =[UIColor whiteColor];
    n =0;

    FirstViewController * mvc =[[FirstViewController alloc]init];
    mvc.isHome = YES;
    mvc.isMainHome =YES;
    SecondViewController *sec = [[SecondViewController alloc] init];
    sec.isHome = YES;
    sec.currentUrl =[NSURL URLWithString:BBS_URL];


    ThirdViewController *thi = [[ThirdViewController alloc] init];
    thi.isHome = YES;
    thi.currentUrl = [NSURL URLWithString:BRAND_URL];
    FourViewController *fou = [[FourViewController alloc] init];
    fou.isHome = YES;
    fou.currentUrl = [NSURL URLWithString:USER_URL];

    UINavigationController * navC =[[UINavigationController alloc]initWithRootViewController:mvc];
    UINavigationController *second = [[UINavigationController alloc] initWithRootViewController:sec];
    UINavigationController *third = [[UINavigationController alloc] initWithRootViewController:thi];
    UINavigationController *four = [[UINavigationController alloc] initWithRootViewController:fou];
    self.tabbar = [[YXTabBarViewController alloc] init];
    self.tabbar.viewControllers = [[NSArray alloc] initWithObjects:navC,second,third,four, nil];
    [self.tabbar customBar];

    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
             [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
             NSLog(@"第一次启动");

//如果是第一次启动的话，使用UserGuideViewController（用户引导页面）作为根视图

        UserGuideViewController *userguide = [[UserGuideViewController alloc] init];
        self.window.rootViewController = userguide;
    }else{
        MenuViewController * menu = [[MenuViewController alloc]init];
        if (IOS6) {
            self.rooVC  = [[MMDrawerController alloc] initWithCenterViewController:self.tabbar leftDrawerViewController:menu];
            [self.rooVC  setMaximumLeftDrawerWidth:200];
            //设置侧拉门开与关的动画
            [self.rooVC  setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
            [self.rooVC  setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
            [[MMExampleDrawerVisualStateManager sharedManager] setLeftDrawerAnimationType:MMDrawerAnimationTypeNone];
            [self.rooVC  setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
                MMDrawerControllerDrawerVisualStateBlock block;
                block = [[MMExampleDrawerVisualStateManager sharedManager]
                         drawerVisualStateBlockForDrawerSide:drawerSide];
                if(block){
                    block(drawerController, drawerSide, percentVisible);
                }
                
            }];
            self.window.rootViewController =self.rooVC ;
        }else{
            JDSideMenu * sideMenu =[[JDSideMenu alloc]initWithContentController:self.tabbar menuController:menu];
            mvc.mainDelegate = sideMenu;
            sec.mainDelegate = sideMenu;
            thi.mainDelegate = sideMenu;
            fou.mainDelegate = sideMenu;
            sideMenu.menuWidth =VIEW_WIDH/5*3;
            self.window.rootViewController =sideMenu;
        }


          }


    [self.window makeKeyAndVisible];
    
    self.tmpWomdow =[[UIWindow alloc]initWithFrame:CGRectMake(0, VIEW_HEIGHT, VIEW_WIDH, VIEW_HEIGHT)];
    self.tmpWomdow.backgroundColor =[UIColor blackColor];
    ErrorView * rv =[[ErrorView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDH, VIEW_HEIGHT)];
    [rv.btn addTarget:self action:@selector(stateReload) forControlEvents:UIControlEventTouchUpInside];
    [self.tmpWomdow addSubview:rv];
    self.tmpWomdow.windowLevel =UIWindowLevelAlert;
    [self.tmpWomdow makeKeyAndVisible];


    

    
    //开始监听网络状况
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    _hostReach =[Reachability reachabilityForInternetConnection];
    [_hostReach startNotifier]; //开始监听。会启动一个 run loop
    [self updateInterfaceWithReachability:_hostReach];

//
//    //推送配置
//#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
//        //可以添加自定义categories
//        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
//                                                       UIUserNotificationTypeSound |
//                                                       UIUserNotificationTypeAlert)
//                                           categories:nil];
//    } else {
//        //categories 必须为nil
//        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
//                                                       UIRemoteNotificationTypeSound |
//                                                       UIRemoteNotificationTypeAlert)
//                                           categories:nil];
//    }
//#else
//    //categories 必须为nil
//    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
//                                                   UIRemoteNotificationTypeSound |
//                                                   UIRemoteNotificationTypeAlert)
//                                       categories:nil];
//#endif                       
//    // Required
//    [APService setupWithOption:launchOptions];

    return YES;
}


-(void)stateReload{
    [self updateInterfaceWithReachability:_hostReach];
}

-(void)dealloc{
    [_hostReach stopNotifier];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

//连接改变时
-(void)reachabilityChanged:(NSNotification *)note{
    Reachability * curReach =[note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
}

//发生网络状态改变的应对措施
-(void)updateInterfaceWithReachability:(Reachability *)curReach{
    NetworkStatus status =[curReach currentReachabilityStatus];
    n++;
    _currentStauts = status;

    if (status == NotReachable) {
        [UIView animateWithDuration:0.5 animations:^{
            self.tmpWomdow.frame =CGRectMake(0, 20, VIEW_WIDH, VIEW_HEIGHT-20);
        }];
    }else{
        if (n>1) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadWebView" object:nil];
        [UIView animateWithDuration:0.5 animations:^{
                self.tmpWomdow.frame =CGRectMake(0, VIEW_HEIGHT, VIEW_WIDH, VIEW_HEIGHT);
            }];
        }

    } 

}




- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    application.applicationIconBadgeNumber =0;
}

- (void)applicationWillTerminate:(UIApplication *)application {

}



//- (void)application:(UIApplication *)application
//didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//    NSLog(@"注册了token");
//    [APService registerDeviceToken:deviceToken];
//    [APService setDebugMode];
//}
//
//- (void)application:(UIApplication *)application
//didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
//    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
//}
//
//- (void)application:(UIApplication *)application
//didReceiveRemoteNotification:(NSDictionary *)userInfo {
//    [APService handleRemoteNotification:userInfo];
//    BOOL isActive;
//    if (application.applicationState == UIApplicationStateActive) {
//        isActive = TRUE;
//    } else {
//        isActive = FALSE;
//    }
//    NSDictionary *dict=[[NSMutableDictionary alloc] initWithDictionary:userInfo];
//    [dict setValue: [[NSNumber alloc] initWithBool:isActive] forKey:@"isActive" ];
//    [[NSNotificationCenter defaultCenter] postNotificationName:kJPFNetworkDidReceiveMessageNotification
//                                                        object:nil userInfo:dict] ;
//}
//
//
//- (void)application:(UIApplication *)application
//didReceiveRemoteNotification:(NSDictionary *)userInfo
//fetchCompletionHandler:
//(void (^)(UIBackgroundFetchResult))completionHandler {
//    [APService handleRemoteNotification:userInfo];
//    BOOL isActive;
//    if (application.applicationState == UIApplicationStateActive) {
//        isActive = TRUE;
//    } else {
//        isActive = FALSE;
//    }
//    NSDictionary *dict=[[NSMutableDictionary alloc] initWithDictionary:userInfo];
//    NSLog(@"%@",dict);
//    [dict setValue: [[NSNumber alloc] initWithBool:isActive] forKey:@"isActive" ];
//    [[NSNotificationCenter defaultCenter] postNotificationName:kJPFNetworkDidReceiveMessageNotification
//                                                        object:nil userInfo:dict] ;//viper
//}
//
//
//- (void)application:(UIApplication *)application
//didReceiveLocalNotification:(UILocalNotification *)notification {
//    [APService showLocalNotificationAtFront:notification identifierKey:nil];
//}


-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
   
    NSLog(@"%@",url.host);

    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"支付宝回调");
            NSLog(@"res ==== %@",resultDic);
        }];
        return YES;
    }else{
   return [WXApi handleOpenURL:url delegate:self];
    }

}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [WXApi handleOpenURL:url delegate:self];
    
}


- (void)onResp:(BaseResp *)resp{
    NSLog(@"执行了");
    
    NSString *strmsg = [NSString stringWithFormat:@"errcode:%d",resp.errCode];
    self.currentResp =[NSString stringWithFormat:@"%i",resp.errCode];

    NSLog(@"返回结果 ＝＝＝ %@",strmsg);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"wetchatPayResult" object:self userInfo:@{@"result":self.currentResp}];
}

//- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
//    if ([NSStringFromClass([[[window subviews]lastObject]class])isEqualToString:@"UITransitionView"]) {
//        return UIInterfaceOrientationMaskAll;
//    }
//    return UIInterfaceOrientationMaskPortrait;
//}




@end
