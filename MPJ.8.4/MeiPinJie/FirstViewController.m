//
//  FirstViewController.m
//  MeiPinJie
//
//  Created by mac on 15/6/29.
//  Copyright (c) 2015年 Alex. All rights reserved.
//

#import "FirstViewController.h"
#import "MenuViewController.h"
#import "YXTabBarViewController.h"
#import "MMDrawerController.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "UIViewController+JDSideMenu.h"
#import "SpecialViewController.h"
#import "APService.h"
#import <PgySDK/PgyManager.h>
@interface FirstViewController ()
@end

@implementation FirstViewController


-(instancetype)init{
    self =[super init];
    if (self) {
        if (IOS6) {
            [SVProgressHUD showSuccessWithStatus:@"加载成功"];
        }
    }
    return self;
}





- (void)viewDidLoad {
    
    //检查更新
    [super viewDidLoad];
   [[PgyManager sharedPgyManager] checkUpdate];

}
//    [[PgyManager sharedPgyManager] checkUpdateWithDelegete:self selector:@selector(upVersion:)];
//    NSLog(@"第一个视图控制器");
//
//}
//
//-(void)upVersion:(NSDictionary *)dict{
//    NSLog(@"%@",dict);
//}

-(void)pushToSpecialView:(NSNotification *)notification{
    NSLog(@"this is userInfo :%@",notification.userInfo);
    NSNumber *isav = [notification.userInfo objectForKey:@"isActive"];
    if ([isav integerValue]==1) {
        return;
    }
    SpecialViewController * svc =[[SpecialViewController alloc]init];
    svc.isHome =NO;
    svc.delegate =self;
    svc.hidesBottomBarWhenPushed =YES;
    NSString * str=[notification.userInfo objectForKey:@"url"];
    svc.currentUrl  =[NSURL URLWithString:str];
    [self.navigationController pushViewController:svc animated:YES];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString * tmpStr = [[NSString alloc]initWithFormat:@"%@",request.URL];
    NSLog(@"%@",tmpStr);



    if (navigationType ==UIWebViewNavigationTypeLinkClicked) {

        //视频详细页
        if ( [tmpStr rangeOfString:@"/Video/DailyLessonDetail"].length !=0) {
            app.isBack =YES;
        }

        if ( [tmpStr rangeOfString:@"/Video/Category"].length !=0) {
            app.isBack =NO;
        }

        if ( [tmpStr rangeOfString:@"/Raw/UploadAvator"].length !=0) {
            [self showphoto];
            return NO;
        }

        if ( [tmpStr rangeOfString:@"/Raw/Share"].length !=0) {
            [self share];
            return NO;
        }

        if ([tmpStr rangeOfString:@"tel"].length !=0) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:tmpStr]];
            return NO;
        }

        SecondViewController * svc =[[SecondViewController alloc]init];
        svc.currentUrl =request.URL;
        svc.delegate =self;
        svc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:svc animated:YES];
        return NO;

    }else if (navigationType == UIWebViewNavigationTypeOther){
        if ( [tmpStr rangeOfString:@"/Raw/Position/"].length != 0) {
            [SVProgressHUD showWithStatus:@"定位中"];
            [self useLocation];
            return NO;
        }

        if ( [tmpStr rangeOfString:@"/Raw/GetPhoneNo/"].length != 0) {
            NSString * tmpStr =[NSString stringWithFormat:@"$.Raw.CallBack(6,'%@')",app.currentAccountNumber];
            NSLog(@"tmpStr = %@",tmpStr);
            [_webView stringByEvaluatingJavaScriptFromString:tmpStr];
            return NO;
        }
        
    }else if (navigationType ==UIWebViewNavigationTypeFormSubmitted){
        if ([tmpStr rangeOfString:@"/Product/Search"].length !=0) {
            SecondViewController * svc =[[SecondViewController alloc]init];
            svc.currentUrl =request.URL;
            svc.delegate =self;
            svc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:svc animated:YES];
            return NO;
        }
    }
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)popwithSecondUrl:(NSURL *)url{
    self.currentUrl =url;
    NSURLRequest * reuqest =[NSURLRequest requestWithURL:self.currentUrl];
    [_webView loadRequest:reuqest];
}

@end
