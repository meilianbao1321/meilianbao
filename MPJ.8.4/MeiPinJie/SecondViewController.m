//
//  SecondViewController.m
//  MeiPinJie
//
//  Created by mac on 15/7/1.
//  Copyright (c) 2015年 Alex. All rights reserved.
//

#import "SecondViewController.h"
#import "MenuViewController.h"
#import "YXTabBarViewController.h"
#import "MMDrawerController.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "UIViewController+JDSideMenu.h"


@interface SecondViewController ()

@end

@implementation SecondViewController


-(instancetype)init{
    self =[super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self createNavWithLeftImage:@"back.png" RightImage:@"about.png"];
    NSLog(@"第二个视图控制器");
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wetchatResult:) name:@"wetchatPayResult" object:nil];
}

-(void)back{
    NSString * viewUrlStr =[self.currentUrl absoluteString];
    NSLog(@"12312131231%@",viewUrlStr );
    if ([viewUrlStr isEqualToString:@"http://user.m.meilianbao.net/Account/Set"] || [viewUrlStr rangeOfString:@"Order/Index/"].length != 0|| [viewUrlStr rangeOfString:@"/Order/Detail"].length != 0) {
        app.isReload =YES;
    }
    NSLog(@"%d",self.isPresent);
    if (self.isPresent) {
        CATransition *animation = [CATransition animation];
        animation.duration = 0.5f;
        [animation setType:kCATransitionMoveIn];
        [animation setSubtype:kCATransitionFromLeft];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
        [self dismissViewControllerAnimated:NO completion:nil];
        [self.view.window.layer addAnimation:animation forKey:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];

        [self dismissViewControllerAnimated:YES completion:^{

        }];
    }
}

- (void)wetchatResult:(NSNotification *)notification{
    NSLog(@"通知传值");
    
    NSDictionary *dic = [notification userInfo];
    NSLog(@"dic== %@",dic);
    NSString *str = [dic objectForKey:@"result"];
    self.wetchatResult = [str integerValue];
    NSLog(@"str == %@",str);
    if (self.wetchatResult == 0) {
        NSLog(@"1");
        NSString *jsonStr = @"{\"f\":1,\"pt\":1}";
        [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"$.Raw.CallBack(3,'%@')",jsonStr]];
        
    }else if (self.wetchatResult == -1){
        NSLog(@"2");
        NSString *jsonStr = @"{\"f\":0,\"pt\":1}";
        [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"$.Raw.CallBack(3,'%@')",jsonStr]];
        
    }else if (self.wetchatResult == -2){
        NSLog(@"取消支付船只");
        
        NSString *jsonStr = @"{\"f\":2,\"pt\":1}";
        [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"$.Raw.CallBack(3,'%@')",jsonStr]];
        
    }
    
}







-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString * viewUrlStr =[NSString stringWithFormat:@"%@",self.currentUrl];
    NSString * urlStr =[NSString stringWithFormat:@"%@",request.URL];
    NSLog(@"this is urlStr = %@",urlStr);
    NSLog(@"this is viewUrlStr =%@",viewUrlStr);
    if (navigationType ==UIWebViewNavigationTypeLinkClicked) {

        if ( [urlStr rangeOfString:@"/Raw/UploadAvator"].length !=0) {
            [self showphoto];
            return NO;
        }

        if ([viewUrlStr rangeOfString:@"/Home/Feedback"].length != 0 && [urlStr isEqualToString:@"http://m.meilianbao.net/Home/About"]) {
            CATransition *animation = [CATransition animation];
            animation.duration = 0.3f;
            [animation setType:kCATransitionReveal];
            [animation setSubtype:kCATransitionFromLeft];
            [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
            [self.view.window.layer addAnimation:animation forKey:nil];
            [self dismissViewControllerAnimated:NO completion:^{
            }];

            return NO;
        }

        if ([viewUrlStr rangeOfString:@"/VIP/Pay/2"].length !=0&&[urlStr isEqualToString:@"http://m.meilianbao.net/"]) {
            
            app.isReload = YES;
            [self.navigationController popToRootViewControllerAnimated:YES];
            
            return NO;
        }

        

        if([urlStr rangeOfString:@"/Login/"].length !=0&&[viewUrlStr isEqualToString:@"http://user.m.meilianbao.net/Login/ForgetPwd"]){
            [self.navigationController popViewControllerAnimated:YES];
            return NO;
        }

        //添加银行卡返回
        if ([viewUrlStr rangeOfString:@"Account/AddBank"].length !=0 &&[urlStr isEqualToString:@"http://user.m.meilianbao.net/Account/Set"]) {
            [self.navigationController popViewControllerAnimated:YES];
            return NO;
        }
        //添加银行卡返回
        if ([viewUrlStr rangeOfString:@"Account/AddBank"].length !=0 &&[urlStr isEqualToString:@"http://user.m.meilianbao.net/Account/Withdraw"]) {
            app.isReload =YES;
            [self.navigationController popViewControllerAnimated:YES];
            return NO;
        }

        //退出登录
        if ([viewUrlStr rangeOfString:@"/Account/Set"].length !=0 &&[urlStr isEqualToString:@"http://user.m.meilianbao.net/Login"]) {
            if([self.delegate respondsToSelector:@selector(popwithSecondUrl:)]){
                [self.delegate popwithSecondUrl:request.URL];
                [self.navigationController popViewControllerAnimated:YES];
                return NO;
            }
        }
        //修改密码pop
        if ([urlStr isEqualToString:@"http://user.m.meilianbao.net/Account"] && [viewUrlStr isEqualToString:@"http://user.m.meilianbao.net/Account/ChangePwd"]) {
            app.isReload = YES;
            NSLog(@"dddddd");
            [self.navigationController popViewControllerAnimated:YES];
            return NO;
        }

        //视频详细页
        if ( [urlStr rangeOfString:@"/Video/DailyLessonDetail"].length !=0) {
            if([self.delegate respondsToSelector:@selector(popwithSecondUrl:)]){
                [self.delegate popwithSecondUrl:request.URL];
                [self.navigationController popViewControllerAnimated:YES];

            }
            return NO;
        }

        if ( [urlStr rangeOfString:@"/Video/Detail"].length !=0) {
            if([self.delegate respondsToSelector:@selector(popwithSecondUrl:)]){
                [self.delegate popwithSecondUrl:request.URL];
                [self.navigationController popViewControllerAnimated:YES];
            }
            return NO;
        }

        if ([viewUrlStr rangeOfString:@"Order/Pay/"].length !=0&&[urlStr isEqualToString:@"http://m.meilianbao.net/"]) {
            [self.navigationController popToRootViewControllerAnimated:YES];
            return NO;

        }


        if([urlStr rangeOfString:@"http://mall.m.meilianbao.net/Cart/Buy"].length !=0&&[viewUrlStr rangeOfString:@"/Order/SelAddress"].length !=0){
            if([self.delegate respondsToSelector:@selector(popwithSecondUrl:)]){
                [self.delegate popwithSecondUrl:request.URL];
                [self.navigationController popViewControllerAnimated:YES];
                return NO;
            }
        }


        if([urlStr rangeOfString:@"/m.meilianbao.net"].length !=0&&[viewUrlStr isEqualToString:@"http://user.m.meilianbao.net/Login/Register"]){
            app.tabbar.g_selectedTag = 4;
            [app.tabbar changeTextColor];
            app.tabbar.selectedIndex = 3;
            [self.navigationController popToRootViewControllerAnimated:YES];
            return NO;

        }

        if([urlStr isEqualToString:@"http://m.meilianbao.net/Home"]){
            [self.navigationController popViewControllerAnimated:YES];
            return NO;

        }

        if ( [urlStr rangeOfString:@"/Raw/Back"].length !=0) {
            [self.navigationController popViewControllerAnimated:YES];
            return NO;
        }

        if ( [urlStr rangeOfString:@"/Raw/Share"].length !=0) {
            [self share];
            return NO;
        }

        if ([urlStr rangeOfString:@"/Order/Index"].length !=0) {
            self.isDownRefresh =YES;
            return YES;
        }

        if ([urlStr rangeOfString:@"/Job/Find"].length !=0) {
            self.isDownRefresh =YES;
            return YES;
        }
        if ([urlStr rangeOfString:@"/Job/Hr"].length !=0) {
            self.isDownRefresh =YES;
            return YES;
        }

        if ([urlStr rangeOfString:@"tel"].length !=0) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
            return NO;
        }

        if([urlStr rangeOfString:@"/Order/Address"].length !=0&&[viewUrlStr rangeOfString:@"/Order/AddressEdit"].length !=0){
            app.isReload =YES;
            [self.navigationController popViewControllerAnimated:YES];
                return NO;

        }

        if([urlStr rangeOfString:@"/Cart/Buy"].length !=0&&[viewUrlStr rangeOfString:@"/Order/AddressEdit"].length !=0){
            app.isReload =YES;
            [self.navigationController popViewControllerAnimated:YES];
            return NO;

        }
        if ([urlStr rangeOfString:@"/Order/Detail"].length !=0 ) {
            self.isDownRefresh =YES;

            return YES;
        }

        ThirdViewController * tvc =[[ThirdViewController alloc]init];
        tvc.hidesBottomBarWhenPushed =YES;
        tvc.delegate =self;
        tvc.isHome = NO;
        tvc.currentUrl =request.URL;
        [self.navigationController pushViewController:tvc animated:YES];
        return NO;
        
    }else if (navigationType ==UIWebViewNavigationTypeOther){

        if ( [urlStr rangeOfString:@"/Raw/Pay"].length !=0) {
            NSString * str = [_webView stringByEvaluatingJavaScriptFromString:@"SendToRaw()"];
            NSData *JSONData = [str dataUsingEncoding:NSUTF8StringEncoding];
            self.dic = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"%@",self.dic);
            
            MLBModel * model   =[MLBModel makePayModelWithDict:self.dic];
          
            NSLog(@"dsadsa%@",model.yinLiaTN);

            if ([model.payType isEqualToString:@"0"]) {
                [self AliPay];
            }else if ([model.payType isEqualToString:@"2"]){
                [self YinlianPay];
            }else if ([model.payType isEqualToString:@"1"]){

                [self wetchatPay];
            }
            return NO;
        }

        if ( [urlStr rangeOfString:@"/Raw/GetPhoneNo/"].length != 0) {
            NSString * tmpStr =[NSString stringWithFormat:@"$.Raw.CallBack(6,'%@')",app.currentAccountNumber];
            NSLog(@"tmpStr = %@",tmpStr);
            [_webView stringByEvaluatingJavaScriptFromString:tmpStr];
            return NO;
        }

        if([urlStr isEqualToString:@"http://m.meilianbao.net/"]&&[viewUrlStr rangeOfString:@"/VIP/Pay"].length !=0){
            app.tabbar.g_selectedTag = 1;
            [app.tabbar changeTextColor];
            app.tabbar.selectedIndex = 0;
            [self.navigationController popToRootViewControllerAnimated:YES];
            return NO;

        }

        if([urlStr rangeOfString:@"/m.meilianbao.net"].length !=0&&[viewUrlStr isEqualToString:@"http://user.m.meilianbao.net/Login/Register"]){
            app.isReload =YES;
            app.tabbar.g_selectedTag = 4;
            [app.tabbar changeTextColor];
            app.tabbar.selectedIndex = 3;
            [self.navigationController popToRootViewControllerAnimated:YES];
            return NO;

        }


    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)popwithThirdUrl:(NSURL *)url{
    self.currentUrl =url;
    NSURLRequest * reuqest =[NSURLRequest requestWithURL:self.currentUrl];
    [_webView loadRequest:reuqest];
}

@end
