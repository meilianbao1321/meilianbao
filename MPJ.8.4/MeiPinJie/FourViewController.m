//
//  FourViewController.m
//  MeiPinJie
//
//  Created by mac on 15/7/4.
//  Copyright (c) 2015年 Alex. All rights reserved.
//

#import "FourViewController.h"
#import "MenuViewController.h"
#import "YXTabBarViewController.h"
#import "MMDrawerController.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "UIViewController+JDSideMenu.h"
#import "AppDelegate.h"

@interface FourViewController ()

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"第四个视图控制器");
//    [self createNavWithLeftImage:@"back.png" RightImage:@"about.png"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wetchatResult:) name:@"wetchatPayResult" object:nil];
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
    NSString * urlStr =[NSString stringWithFormat:@"%@",request.URL];
    NSLog(@"-=-=-=-%@",urlStr);
    NSString * viewUrlStr =[NSString stringWithFormat:@"%@",self.currentUrl];

    if (navigationType ==UIWebViewNavigationTypeLinkClicked) {

        if ( [urlStr rangeOfString:@"/Raw/UploadAvator"].length !=0) {
            [self showphoto];
            return NO;
        }
       
        
        if ( [urlStr rangeOfString:@"/Video/DailyLessonDetail"].length !=0) {
            if([self.delegate respondsToSelector:@selector(popwithFourUrl:)]){
                [self.delegate popwithFourUrl:request.URL];
                [self.navigationController popViewControllerAnimated:YES];
            }
            return NO;
        }
        
        if([urlStr rangeOfString:@"http://mall.m.meilianbao.net/Cart/Buy"].length !=0&&[viewUrlStr rangeOfString:@"/Order/SelAddress"].length !=0){
            if([self.delegate respondsToSelector:@selector(popwithFourUrl:)]){
                [self.delegate popwithFourUrl:request.URL];

                [self.navigationController popViewControllerAnimated:YES];
                return NO;
            }
        }

        if ([urlStr rangeOfString:@"/Order/Detail"].length !=0 ) {
            self.isDownRefresh =YES;
            return YES;
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

        if ([viewUrlStr rangeOfString:@"Order/Pay/"].length !=0&&[urlStr isEqualToString:@"http://m.meilianbao.net/"]) {
            [self.navigationController popToRootViewControllerAnimated:YES];
            return NO;

        }
        if ([viewUrlStr rangeOfString:@"/VIP/Pay/2"].length !=0&&[urlStr isEqualToString:@"http://m.meilianbao.net/"]) {

            app.isReload = YES;
            [self.navigationController popToRootViewControllerAnimated:YES];
            
            return NO;
        }
        if ([viewUrlStr rangeOfString:@"Order/Pay/"].length !=0&&[urlStr isEqualToString:@"http://user.m.meilianbao.net/Order/Index/1"]) {
            // [self.navigationController.viewControllers objectAtIndex:2];
            //            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1]animated:YES];
            
            if([self.delegate respondsToSelector:@selector(popwithFourUrl:)]){
                [self.delegate popwithFourUrl:request.URL];
                
                [self.navigationController popViewControllerAnimated:YES];
                return NO;
            }
            return NO;
        }

        
       
        
        if ([viewUrlStr rangeOfString:@"Account/AddBank"].length !=0 &&[urlStr isEqualToString:@"http://user.m.meilianbao.net/Account/Set"]) {
            [self.navigationController popViewControllerAnimated:YES];
            return NO;
        }


        if ( [urlStr rangeOfString:@"/Raw/Share"].length !=0) {
            [self share];
            return NO;
        }

        if ( [urlStr rangeOfString:@"/Raw/Back"].length !=0) {
            [self.navigationController popViewControllerAnimated:YES];
            return NO;
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

        SecondViewController * fvc =[[SecondViewController alloc]init];
        fvc.hidesBottomBarWhenPushed =YES;
        fvc.currentUrl =request.URL;
        fvc.isHome = NO;
        fvc.delegate=self;
        [self.navigationController pushViewController:fvc animated:YES];
        return NO;
    
    }    else if (navigationType ==UIWebViewNavigationTypeOther){
        if ( [urlStr rangeOfString:@"/Raw/Pay"].length !=0) {
            NSString * str = [_webView stringByEvaluatingJavaScriptFromString:@"SendToRaw()"];
            NSData *JSONData = [str dataUsingEncoding:NSUTF8StringEncoding];
            self.dic = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"dict == %@",self.dic);
            MLBModel * model   =[MLBModel makePayModelWithDict:self.dic];
            NSLog(@"dsadsa%@",model.yinLiaTN);
            //[self ]
            if ([model.payType isEqualToString:@"0"]) {
                [self AliPay];
            }else if ([model.payType isEqualToString:@"2"]){
                [self YinlianPay];
            }else if ([model.payType isEqualToString:@"1"]){

                [self wetchatPay];
            }
            
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
- (void)viewWillAppear:(BOOL)animated{
    if (app.isReload == YES) {
        [_webView reload];
    }else{
        NSLog(@"不知道咋的没刷新");
    }
    NSLog(@"123");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isrefresh:) name:@"isRefresh" object:nil];
}


- (void)isrefresh:(NSNotification *)notification{
    NSDictionary *dic = [notification userInfo];
    NSLog(@"dic== %@",dic);
    NSString *str = [dic objectForKey:@"result"];
    if ([str isEqualToString:@"1"]) {
        NSLog(@"页面刷新111");
        [_webView reload];
    }else{
        NSLog(@"不刷新");
    }

}

-(void)popwithSecondUrl:(NSURL *)url{
    self.currentUrl =url;
    NSURLRequest * reuqest =[NSURLRequest requestWithURL:self.currentUrl];
    [_webView loadRequest:reuqest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
