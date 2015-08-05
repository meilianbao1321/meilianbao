//
//  YXTools.h
//  enKeJi
//
//  Created by tl on 14-5-9.
//  Copyright (c) 2014年 tl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@interface YXTools : NSObject

+ (AppDelegate *)getApp;
+ (UIWindow *)getAppWindow;


+ (BOOL)stringIsNotNullTrim:(NSString *)s;

+ (UILabel *)allocLabel:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor frame:(CGRect)frame textAlignment:(UITextAlignment)textAlignment;
+ (UIButton *)allocButton:(NSString *)title textColor:(UIColor *)textColor nom_bg:(UIImage *)nom_bg hei_bg:(UIImage *)hei_bg frame:(CGRect)frame;

+ (UIImageView *)allocImageView:(CGRect)frame image:(UIImage *)image;

+ (UITextField *)allocTextField:(CGRect)frame bgImg:(UIImage *)bgImg;

+ (NSArray *)getPlistFileArray:(NSString *)fileName;
//CATransition 动画
+ (void)cATransitionAnimation:(UIView *)toView typeIndex:(NSInteger)typeIndex subTypeIndex:(NSInteger)subTypeIndex duration:(NSTimeInterval)duration animation:(void(^)(void))animation;
//解析plist文件
+ (NSMutableDictionary *)getPlistFileDictionary:(NSString *)fileName;

//将gb2312转换成UTF-8
+(NSString *) gb2312toutf8:(NSData *) data;

//将UTF8转换成GB2312
+ (NSString*)UTF8_To_GB2312:(NSString*)utf8string;

+ (NSString*)replaceUnicode:(NSString*)aUnicodeString;

+(NSString *)utf8ToUnicode:(NSString *)string;
//普通字符串转换为十六进制的
+ (NSString *)hexStringFromString:(NSString *)string;

+(id)toArrayOrNSDictionary:(NSData *)jsonData;


+ (void)autohideKeyBoard:(UIView *)view;

//定义字符串中数字的颜色
+ (NSMutableAttributedString *)converToDigitalString:(NSString *)ceshi Color:(UIColor *)red;
//定义字符串中*的颜色
+(NSMutableAttributedString *)converToStart:(NSString *)title Color:(UIColor *)red
;
//MD5 32位加密 （大写)
+ (NSString *)md5:(NSString *)str;
//md5 32位 加密 （小写）
+ (NSString *)md5Encrypt:(NSString *) str;
//去掉webView的弹性效果
+ (void)deleteWebViewBord:(UIWebView *)webView;
//获取版本号，去掉“.”
+ (NSString *)getVersionNumber:(NSString *)s;

//将实体类转化为字典
+ (NSDictionary *) entityToDictionary:(id)entity;
//处理json数据中的\n\t特殊字符
+(NSData *)processCharacter:(NSData *)data;

//json转化为实体类
extern id JsonStringTransToObject(id json ,id className);

+ (NSString *)dateSwicth:(NSString *)dateStr;

//  将数组重复的对象去除，只保留一个
+ (NSMutableArray *)arrayWithMemberIsOnly:(NSArray *)array;
@end
