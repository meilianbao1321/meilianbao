//
//  MenuViewController.m
//  MeiPinJie
//
//  Created by mac on 15/6/27.
//  Copyright (c) 2015年 Alex. All rights reserved.
//
#import "UIViewController+JDSideMenu.h"
#import "MenuViewController.h"
#import "loadView.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourViewController.h"
#import "YXTabBarViewController.h"
#import "DDMenuController.h"
#import "MMDrawerController.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "AppDelegate.h"
@interface MenuViewController (){
    UIWebView * _menuWebView;
    loadView * _lv;
}

@end

@implementation MenuViewController

-(instancetype)init{
    self =[super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createWebView];
    [self createNav];

}


-(void)createWebView{
    if (IOS6) {
        _menuWebView =[[UIWebView alloc]initWithFrame:CGRectMake(0,44,VIEW_WIDH,VIEW_HEIGHT -64)];

    }else{
        _menuWebView =[[UIWebView alloc]initWithFrame:CGRectMake(0,64,VIEW_WIDH,VIEW_HEIGHT -64)];
    }
    _menuWebView.backgroundColor =[UIColor whiteColor];
    _menuWebView.delegate =self;
    _menuWebView.scrollView.bounces =YES;
    _menuWebView.scrollView.showsVerticalScrollIndicator = NO;
    _menuWebView.scrollView.scrollEnabled =YES;
    [_menuWebView sizeToFit];
    NSURLRequest * request =[NSURLRequest requestWithURL:[NSURL URLWithString:MENU_URL]];
    [self.view addSubview:_menuWebView];
    [_menuWebView loadRequest:request];
    _lv =[[loadView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDH, _menuWebView.frame.size.height)];
    _lv.loadAV.frame =CGRectMake(30, _lv.loadAV.frame.origin.y, _lv.loadAV.frame.size.width, _lv.loadAV.frame.size.height);
    [_menuWebView addSubview:_lv];
    
}

-(void)createNav{
    self.navigationController.navigationBarHidden =YES;
    UIView * navView ;
    if (IOS6) {
        navView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDH, 44)];
    }else{
        navView =[[UIView alloc]initWithFrame:CGRectMake(0, 20, VIEW_WIDH, 44)];
    }
    navView.backgroundColor =UIColorFromRGB(0xdd127b);
    
    //标题
    UILabel * titleLabel =[[UILabel alloc]initWithFrame:CGRectMake(70, 7, 200, 30)];
    [titleLabel setTextAlignment:NSTextAlignmentLeft];
    titleLabel.textColor =[UIColor whiteColor];
    titleLabel.text =@"导航";
    titleLabel.backgroundColor = [UIColor clearColor];
    
    [titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [navView addSubview:titleLabel];
    
    //左btn
    UIButton * leftBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.tag =BTN_TAG+1;
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    leftBtn.frame =CGRectMake(15, 7, 30, 30);
    [leftBtn addTarget:self action:@selector(showLeftMeun) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:leftBtn];
    
    if (_lv !=nil) {
        [self.view insertSubview:navView belowSubview:_lv];
    }else{
        [self.view addSubview:navView];
    }
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
//    NSString* path = [[NSBundle mainBundle] pathForResource:@"error_page" ofType:@"html"];
//    NSURL* url = [NSURL fileURLWithPath:path];
//    NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
//    [webView loadRequest:request];
    NSLog(@"%@",error);
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{

    //取消长按手势
    [_menuWebView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];

    [_menuWebView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *str = [request.URL absoluteString];
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    if (navigationType ==UIWebViewNavigationTypeLinkClicked) {
        
        if ([str   isEqual: MAIN_URL]) {
            [self showLeftMeun];
            app.tabbar.g_selectedTag = 1;
            [app.tabbar changeTextColor];
            app.tabbar.selectedIndex = 0;
            [self.navigationController popToRootViewControllerAnimated:YES];



        }else if ([str isEqualToString:USER_URL]){
            [self showLeftMeun];
            AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            app.tabbar.g_selectedTag = 4;
            [app.tabbar changeTextColor];
            app.tabbar.selectedIndex = 3;
            [self.navigationController popToRootViewControllerAnimated:YES];

        }else if ([str isEqualToString:MALL_URL]){
            [self showLeftMeun];
            AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            app.tabbar.g_selectedTag = 2;
            [app.tabbar changeTextColor];
            app.tabbar.selectedIndex = 1;
            [self.navigationController popToRootViewControllerAnimated:YES];


        }else if ([str isEqualToString:CALL_URL]){
            [self showLeftMeun];
            AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            app.tabbar.g_selectedTag = 3;
            [app.tabbar changeTextColor];
            app.tabbar.selectedIndex = 2;
            [self.navigationController popToRootViewControllerAnimated:YES];


        }


        else{
            //视频详细页
            if ( [str rangeOfString:@"/Video/DailyLessonDetail"].length !=0) {
                app.isBack =YES;
            }

            if ( [str rangeOfString:@"/Video/Category"].length !=0) {
                app.isBack =NO;
            }

            [self showLeftMeun];
            SecondViewController * mvc =[[SecondViewController alloc]init];
            mvc.isHome = NO;
            CATransition *animation = [CATransition animation];
            animation.duration = 0.5f;
            [animation setType:kCATransitionMoveIn];
            [animation setSubtype:kCATransitionFromRight];
            [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
            mvc.hidesBottomBarWhenPushed =YES;
            mvc.mainDelegate =self;
            mvc.currentUrl =request.URL;
            UINavigationController * navC = [[UINavigationController alloc]initWithRootViewController:mvc];
            [self presentViewController:navC animated:NO completion:^{
                mvc.isPresent =YES;
            }];
            [self.view.window.layer addAnimation:animation forKey:nil];
        }
        return NO;
    }
    return YES;
}

-(void)showLeftMeun{
    if (IOS6) {
        AppDelegate * app =  (AppDelegate *)[UIApplication sharedApplication].delegate;
        [app.rooVC closeDrawerAnimated:YES completion:^(BOOL finished) {

        }];
    }else{
         [self.sideMenuController showMenu];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [_menuWebView reload];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
