//
//  SpecialViewController.m
//  MeiPinJie
//
//  Created by mac on 15/7/20.
//  Copyright (c) 2015年 Alex. All rights reserved.
//

#import "SpecialViewController.h"
#import "SecondViewController.h"
#import "SDImageCache.h"
@interface SpecialViewController ()

@end

@implementation SpecialViewController

- (void)viewDidLoad {
    self.hidesBottomBarWhenPushed =YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isrefresh:) name:@"isRefresh" object:nil];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

//- (void)viewWillAppear:(BOOL)animated{
//    NSString *str = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//    [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"$.Raw.CallBack(5,'%@')",str]];
//    NSLog(@"str == %@",str);
//}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString * urlStr =[NSString stringWithFormat:@"%@",request.URL];
    NSLog(@"urlStr = %@",urlStr);
    NSString * viewUrlStr =[NSString stringWithFormat:@"%@",self.currentUrl];


    if (navigationType ==UIWebViewNavigationTypeLinkClicked) {
        
        if ([viewUrlStr rangeOfString:@"/about"].length != 0 && [urlStr isEqualToString:@"itms-services://?action=download-manifest&url=https%3A%2F%2Fwww.pgyer.com%2Fapiv1%2Fapp%2Fplist%3FaId%3Da576560c3f94b3115e7653671a26997e%26_api_key%3D90146f0a35b1481efb46e34b0d5e8c1c"]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-services://?action=download-manifest&url=https%3A%2F%2Fwww.pgyer.com%2Fapiv1%2Fapp%2Fplist%3FaId%3Da576560c3f94b3115e7653671a26997e%26_api_key%3D90146f0a35b1481efb46e34b0d5e8c1c"]];
            return NO;
            
        }



        if ( [urlStr rangeOfString:@"/Video/DailyLessonDetail"].length !=0) {
            
            if([self.delegate respondsToSelector:@selector(popwithUrl:)]){
                [self.delegate popwithUrl:request.URL];
                [self.navigationController popViewControllerAnimated:YES];
            }
            return NO;
        }

        if ( [urlStr rangeOfString:@"/Video/Detail"].length !=0) {
            if([self.delegate respondsToSelector:@selector(popwithUrl:)]){
                [self.delegate popwithUrl:request.URL];
                [self.navigationController popViewControllerAnimated:YES];
            }
            return NO;
        }


        if([urlStr rangeOfString:@"xdreceive.htm"].length !=0){
            if([self.delegate respondsToSelector:@selector(popwithUrl:)]){
                [self.delegate popwithUrl:request.URL];
                [self.navigationController popViewControllerAnimated:YES];
                return NO;
            }
        }



        if ( [urlStr rangeOfString:@"/Product"].length !=0 && [viewUrlStr isEqualToString:@"http://mall.m.meilianbao.net/Cart/"]) {
            [self.navigationController popViewControllerAnimated:YES];

            return NO;
        }

        if ([urlStr rangeOfString:@"tel"].length !=0) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
            return NO;
        }

        if ([urlStr rangeOfString:@"/Raw/ClearCache"].length !=0) {
            NSString * path =[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            float size =[self folderSizeAtPath:path];
            NSString * clearStr =[NSString stringWithFormat:@"缓存大小为%.2fM.确定要清理缓存吗？",size];
            UIAlertView * clearAV = [[UIAlertView alloc]initWithTitle:@"提示" message:clearStr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            [clearAV show];
            return NO;
        }


        if ([urlStr rangeOfString:@"/Raw/CheckVer"].length != 0) {
            NSArray * tmpArr = [NSArray arrayWithArray:[[[urlStr componentsSeparatedByString:@"?"]objectAtIndex:1] componentsSeparatedByString:@"&"]];
            NSString * ver = [tmpArr[0] substringFromIndex:4];
            NSString * url = [tmpArr[1] substringFromIndex:4];
            NSLog(@"%@",url);
            NSLog(@"%@",ver);
            NSDictionary * infoDict =[[NSBundle mainBundle]infoDictionary];
            NSString * verCurrent = [infoDict objectForKey:@"CFBundleVersion"];
            NSLog(@"------%@",verCurrent);
            if ([verCurrent compare:ver] <0) {
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url]];
            }else{
               UIAlertView * av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"当前版本已经是最新版本，不需要更新" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [av show];
            }
            return NO;
        }
        SecondViewController * svc =[[SecondViewController alloc]init];
        svc.currentUrl =request.URL;
        svc.isHome = NO;
        svc.hidesBottomBarWhenPushed =YES;

        if ([urlStr isEqualToString:@"http://m.meilianbao.net/Home/Feedback"]) {
            CATransition *animation = [CATransition animation];
            animation.duration = 0.5f;
            [animation setType:kCATransitionMoveIn];
            [animation setSubtype:kCATransitionFromRight];
            [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
                    svc.isPresent =YES;
            [self presentViewController:svc animated:NO completion:nil];
            [self.view.window.layer addAnimation:animation forKey:nil];

            return NO;
        }

        if ([urlStr rangeOfString:@"/Home/Share"].length !=0) {

            CATransition *animation = [CATransition animation];
            animation.duration = 0.5f;
            [animation setType:kCATransitionMoveIn];
            [animation setSubtype:kCATransitionFromRight];
            [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
            svc.isPresent =YES;
            [self presentViewController:svc animated:NO completion:nil];
            [self.view.window.layer addAnimation:animation forKey:nil];

            return NO;
        }



       [self.navigationController pushViewController:svc animated:YES];
        return NO;

    }else if(navigationType ==UIWebViewNavigationTypeOther){

    }else if (navigationType ==UIWebViewNavigationTypeFormSubmitted){
                if (([urlStr rangeOfString:@"/Job/Find"].length !=0||[urlStr rangeOfString:@"/Job/Hr"].length !=0) && [viewUrlStr isEqualToString:@"http://m.meilianbao.net/Job/RecruitSearch"]) {
                    if([self.delegate respondsToSelector:@selector(popwithUrl:)]){
                        [self.delegate popwithUrl:request.URL];
                        [self.navigationController popViewControllerAnimated:YES];
                        return NO;
                    }
                }
    }
    return YES;
}


#pragma mark --clearCache
//计算单个文件的大小；
-(float)fileSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}
//计算目录文件的大小：
-(float)folderSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            folderSize +=[self fileSizeAtPath:absolutePath];
            NSLog(@"%f",folderSize);

        }
        folderSize+=[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
        return folderSize;
    }
    return 0;
}

//清理缓存
-(void)clearCache:(NSString *)path{
    //清除本地缓存
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] cleanDisk];

    //清除webView缓存
    NSURLCache * cache =[NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
}

//清除成功回调

-(void)clearCacheSuccess{
    NSLog(@"清理成功");
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self clearCache:[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]];
        [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];
    });
}
@end