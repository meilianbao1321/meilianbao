//
//  HttpRequest.m
//  MeiPinJie
//
//  Created by mac on 15/6/25.
//  Copyright (c) 2015年 Alex. All rights reserved.
//

#import "HttpRequest.h"
#import "AFNetworking/AFNetworking.h"
#import "MLBModel.h"
@implementation HttpRequest


+(HttpRequest *)share{
    static HttpRequest * request =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        request =[[HttpRequest alloc]init];
    });
    return request;
}

-(void)requestToLogin:(NSString *)userName withPassWord:(NSString *)passWord withComplete:(void (^)(BOOL))complete{
    AFHTTPRequestOperationManager * manager =[AFHTTPRequestOperationManager manager];
    NSDictionary * dict =@{
                           
                           };
    [manager POST:MAIN_URL parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        complete(YES);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        complete(NO);
        NSLog(@"%@",error);
    }];
    
}
//获得已经保存的cookie；
-(NSArray *)getAllcookies{
    NSHTTPCookieStorage * cookiejar =[NSHTTPCookieStorage sharedHTTPCookieStorage];
    return [cookiejar cookies];
}
//删除所有cookies
-(void)removeAllcookies{
    NSHTTPCookieStorage * cookiejar =[NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *tmpArr =[NSArray arrayWithArray:[cookiejar cookies]];
    for (id obj in tmpArr) {
        [cookiejar  delete:obj];
    }
}
//设置指定的cookie
-(void)makeCookieWithCookieProperties:(NSMutableDictionary *)mutDic{
    NSHTTPCookie * cookie =[NSHTTPCookie cookieWithProperties:mutDic];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
}
@end
