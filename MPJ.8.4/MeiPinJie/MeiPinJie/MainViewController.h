//
//  MainViewController.h
//  MeiPinJie
//
//  Created by mac on 15/6/25.
//  Copyright (c) 2015年 Alex. All rights reserved.
//
@protocol FirstControllerDelegate <NSObject>
-(void)showLeftMeun;
-(void)showLeftController:(BOOL)animated;
-(void)reloadHomeView;
@end
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "loadView.h"
#import "RightNavView.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "MLBModel.h"
#import "SVProgressHUD.h"
#import "WXApi.h"
#import "UPPayPlugin.h"
#import "UMSocial.h"

@interface MainViewController : UIViewController<UPPayPluginDelegate,UIScrollViewDelegate,UIWebViewDelegate,CLLocationManagerDelegate,EGORefreshTableHeaderDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,NSURLConnectionDataDelegate,WXApiDelegate>{
    UIView * _rnv;
    loadView * _lv;
    UIWebView * _webView;
    UIActionSheet *  _myActionSheet;
    NSMutableArray * _titleArr;
    NSMutableArray * _ivArr;
    NSMutableArray * _btnArr;
    NSMutableData* _responseData; //测试银联
    UIAlertView* _alertView;
    AppDelegate * app;
}

@property (nonatomic,assign) NSInteger wetchatResult;

@property (nonatomic,assign) BOOL isPresent;
//判断是否返回的时候需要dismiss
@property (nonatomic,assign) id mainDelegate;
//是否有下拉刷新中
@property (nonatomic,assign) BOOL isDownRefresh;
//下拉刷新中
@property (nonatomic,assign) BOOL reloading;
//判断是否是首页
@property (nonatomic,assign) BOOL isHome;
@property (nonatomic,assign) BOOL isMainHome;
@property (nonatomic,strong) CLLocationManager * location;
@property (nonatomic,strong) NSURL * currentUrl;
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) NSDictionary *dic;
@property(nonatomic, copy)NSString *tnMode;//银联测试

-(void)createRefreshView;
-(void)createWebViewWithUrl:(NSURL *)url;
-(void)useLocation;
-(void)showphoto;
-(void)share;
-(void)AliPay;
-(void)YinlianPay;
-(void)wetchatPay;
-(void)back;
@end
