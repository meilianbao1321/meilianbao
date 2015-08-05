//
//  YXTools.m
//  enKeJi
//
//  Created by tl on 14-5-9.
//  Copyright (c) 2014年 tl. All rights reserved.
//

#import "YXTools.h"
#import <CommonCrypto/CommonDigest.h>
#import <objc/runtime.h>

@implementation YXTools

+ (AppDelegate *)getApp
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return app;
}
+ (UIWindow *)getAppWindow
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return app.window;
}

//验证字符串不为空切不是空格
+ (BOOL)stringIsNotNullTrim:(NSString *)s
{
    NSString *ss = [s stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (ss == nil || ss.length == 0 || [ss isEqualToString:@""])
    {
        return YES;
    }
    return NO;
}

+ (UILabel *)allocLabel:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor frame:(CGRect)frame textAlignment:(UITextAlignment)textAlignment
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = text;
    label.font = font;
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    label.backgroundColor = [UIColor clearColor];
    return label;
}


+ (UIButton *)allocButton:(NSString *)title textColor:(UIColor *)textColor nom_bg:(UIImage *)nom_bg hei_bg:(UIImage *)hei_bg frame:(CGRect)frame
{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setBackgroundImage:nom_bg forState:UIControlStateNormal];
    [btn setBackgroundImage:hei_bg forState:UIControlStateHighlighted];
    [btn setTitleColor:textColor forState:UIControlStateNormal];
    return btn;
}
+ (UIImageView *)allocImageView:(CGRect)frame image:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = image;
    imageView.backgroundColor = [UIColor clearColor];
    return imageView;
}
+ (UITextField *)allocTextField:(CGRect)frame bgImg:(UIImage *)bgImg;
{
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.backgroundColor = [UIColor clearColor];
    textField.font = [UIFont systemFontOfSize:12];
    textField.background = bgImg;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    return textField;
}

//解析plist文件
+ (NSArray *)getPlistFileArray:(NSString *)fileName
{
    NSString *filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
    return [[NSArray alloc] initWithContentsOfFile:filePath];
}
#pragma mark -
#pragma mark ------
+ (void)cATransitionAnimation:(UIView *)toView typeIndex:(NSInteger)typeIndex subTypeIndex:(NSInteger)subTypeIndex duration:(NSTimeInterval)duration animation:(void(^)(void))animation
{
    @try {
        CATransition *transtion = [CATransition animation];
        transtion.duration = duration;
        transtion.timingFunction = UIViewAnimationCurveEaseInOut;
        switch (typeIndex) {
            case 0:
                transtion.type = kCATransitionFade;
                break;
            case 1:
                transtion.type = kCATransitionPush;
                break;
            case 2:
                transtion.type = kCATransitionReveal;
                break;
            case 3:
                transtion.type = kCATransitionMoveIn;
                break;
            case 4:
                transtion.type = @"cube";
                break;
            case 5:
                transtion.type = @"suckEffect";
                break;
            case 6:
                transtion.type = @"oglFlip";
                break;
            case 7:
                transtion.type = @"rippleEffect";
                break;
            case 8:
                transtion.type = @"pageCurl";
                break;
            case 9:
                transtion.type = @"pageUnCurl";
                break;
            case 10:
                transtion.type = @"cameraIrisHollowOpen";
                break;
            case 11:
                transtion.type = @"cameraIrisHollowClose";
                break;
            default:
                transtion.type = kCATransitionFade;
                break;
        }
        switch (subTypeIndex) {
            case 0:
                transtion.subtype = kCATransitionFromLeft;
                break;
            case 1:
                transtion.subtype = kCATransitionFromRight;
                break;
            case 2:
                transtion.subtype = kCATransitionFromBottom;
                break;
            case 3:
                transtion.subtype = kCATransitionFromTop;
                break;
            default:
                transtion.subtype = kCATransitionFromLeft;
                break;
        }
        animation();
        //XCLog(@"---  %@",toView);
        if (toView.layer != nil && (id)toView.layer != [NSNull null])
        {
            [[toView layer] addAnimation:transtion forKey:@"animation"];
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
}

+ (NSMutableDictionary *)getPlistFileDictionary:(NSString *)fileName
{
    NSString *filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
    return [[NSMutableDictionary alloc] initWithContentsOfFile:filePath] ;
}

//将gb2312转换成UTF-8
+(NSString *) gb2312toutf8:(NSData *) data{
    
    NSStringEncoding enc =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *retStr = [[NSString alloc] initWithData:data encoding:enc];
    
    return retStr;
}

//将UTF8转换成GB2312
+ (NSString*)UTF8_To_GB2312:(NSString*)utf8string
{
    NSStringEncoding encoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* gb2312data = [utf8string dataUsingEncoding:encoding];
    return [[NSString alloc] initWithData:gb2312data encoding:encoding];
}


//Unicode转UTF-8
+ (NSString*)replaceUnicode:(NSString*)aUnicodeString
{
    NSString *tempStr1 = [aUnicodeString stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"" withString:@"\\"];
    NSString *tempStr3 = [[@"" stringByAppendingString:tempStr2] stringByAppendingString:@""];
                          NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
                          NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                                                 mutabilityOption:NSPropertyListImmutable
                                                                                           format:NULL
                                                                                 errorDescription:NULL];
                          
                          return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"]; 
                          }

+(NSString *)utf8ToUnicode:(NSString *)string
{
    NSUInteger length = [string length];
    NSMutableString *s = [NSMutableString stringWithCapacity:0];
    for (int i = 0;i < length; i++)
    {
        unichar _char = [string characterAtIndex:i];
        //判断是否为英文和数字
        if (_char <= '9' && _char >= '0')
        {
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i, 1)]];
        }
        else if(_char >= 'a' && _char <= 'z')
        {
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i, 1)]];
            
        }
        else if(_char >= 'A' && _char <= 'Z')
        {
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i, 1)]];
            
        }
        else
        {
            [s appendFormat:@"\\u%x",[string characterAtIndex:i]];
        }
    }
    return s;
}


//普通字符装换为十六进制的
+ (NSString *)hexStringFromString:(NSString *)string{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    } 
    return hexStr; 
}

// 将JSON串转化为字典或者数组

+ (id)toArrayOrNSDictionary:(NSData *)jsonData{
    
    NSError *error = nil;
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                     
                                                    options:NSJSONReadingAllowFragments
                     
                                                      error:&error];
    
    
    
    if (jsonObject != nil && error == nil){
        
        return jsonObject;
        
    }else{
        
        // 解析错误
        
        return nil;
        
    }
    
}


#pragma mark -
#pragma mark 隐藏键盘
+ (void)autohideKeyBoard:(UIView *)view
{
    for (UIView *inView in [view subviews])
    {
        if ([inView isKindOfClass:[UITextField class]] || [inView isKindOfClass:[UITextView class]])
        {
            [inView resignFirstResponder];
        }
        if (inView.subviews.count > 0) {
            [self autohideKeyBoard:inView];
        }
    }
}


+ (NSMutableAttributedString *)converToDigitalString:(NSString *)ceshi Color:(UIColor *)red
{
    //扫描字符串中的数字
    NSScanner *scanner = [NSScanner scannerWithString:ceshi];
    [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:nil];
    int number;
    [scanner scanInt:&number];
    NSString *numberStr = [NSString stringWithFormat:@"%d",number];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:ceshi];
    [str addAttribute:NSForegroundColorAttributeName value:red range:NSMakeRange(0, numberStr.length)];
    //Arial-BoldItalicMT 倾斜字体
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13.0] range:NSMakeRange(0, numberStr.length)];
    return str;
}

//定义字符串中*的颜色
+(NSMutableAttributedString *)converToStart:(NSString *)title Color:(UIColor *)red
{
    NSString *temp = @"";
     NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:title];
    for (int i=0; i< title.length; i++)
    {
        temp = [title substringWithRange:NSMakeRange(i, 1)];
        if ([temp isEqualToString:@"*"]) {
            [str addAttribute:NSForegroundColorAttributeName value:red range:NSMakeRange(i, 1)];
        }
    }
    return str;
}
//md5 16位加密 （大写）
+ (NSString *)md5:(NSString *)str {
    const char *cStr = [str UTF8String];//转换成utf-8
    unsigned char result[16];//开辟一个16字节（128位：md5加密出来就是128位/bit）的空间（一个字节=8字位=8个二进制数）
    CC_MD5( cStr, strlen(cStr), result);
    /*
     extern unsigned char *CC_MD5(const void *data, CC_LONG len, unsigned char *md)官方封装好的加密方法
     把cStr字符串转换成了32位的16进制数列（这个过程不可逆转） 存储到了result这个空间中
     */
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
    /*
     x表示十六进制，%02X  意思是不足两位将用0补齐，如果多余两位则不影响
     NSLog("%02X", 0x888);  //888
     NSLog("%02X", 0x4); //04
     */
}

//md5 32位 加密 （小写）
+ (NSString *)md5Encrypt:(NSString *) str {
    const char *original_str = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}

//去掉webView的弹性效果
+ (void)deleteWebViewBord:(UIWebView *)webView
{
    for(id subview in webView.subviews)
    {
        if ([[subview  class] isSubclassOfClass: [UIScrollView  class]])
            
        {
            ((UIScrollView *)subview).bounces = NO;
        }
        
        webView.scrollView.bounces=NO;
    }
}

//获取版本号，去掉“.”
+ (NSString *)getVersionNumber:(NSString *)s
{
    NSString *getVersion = [s stringByReplacingOccurrencesOfString:@"." withString:@""];
    getVersion = [getVersion stringByReplacingOccurrencesOfString:@" " withString:@""];
    for (NSInteger i = getVersion.length; i<4; i++) {
        if (i==4) {
            return getVersion;
        }
        getVersion = [getVersion stringByAppendingString:@"0"];
    }
    return getVersion;
}

//将实体类转化为字典
+ (NSDictionary *) entityToDictionary:(id)entity
{
    
    Class clazz = [entity class];
    u_int count;
    
    objc_property_t* properties = class_copyPropertyList(clazz, &count);
    NSMutableArray* propertyArray = [NSMutableArray arrayWithCapacity:count];
    NSMutableArray* valueArray = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count ; i++)
    {
        objc_property_t prop=properties[i];
        const char* propertyName = property_getName(prop);
        
        [propertyArray addObject:[NSString stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
        
        //        const char* attributeName = property_getAttributes(prop);
        //        NSLog(@"%@",[NSString stringWithUTF8String:propertyName]);
        //        NSLog(@"%@",[NSString stringWithUTF8String:attributeName]);
        
        id value =  [entity performSelector:NSSelectorFromString([NSString stringWithUTF8String:propertyName])];
        if(value ==nil)
            [valueArray addObject:[NSNull null]];
        else {
            [valueArray addObject:value];
        }
        //        NSLog(@"%@",value);
    }
    
    free(properties);
    
    NSDictionary* returnDic = [NSDictionary dictionaryWithObjects:valueArray forKeys:propertyArray];
    NSLog(@"%@", returnDic);
    
    return returnDic;
}

//处理json数据中的\n\t特殊字符
+(NSData *)processCharacter:(NSData *)data
{
    NSString *responseString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    responseString = [responseString stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
    responseString = [responseString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    responseString = [responseString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    NSData *responseData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    return responseData;
}

id JsonStringTransToObject(id json ,id className)
{
    if ([json isKindOfClass:[NSDictionary class]])
    {
        id object = nil;
        if ([className isKindOfClass:[NSString class]])
        {
            Class isClass = NSClassFromString(className);
            
            object = [[isClass alloc] init];
        }
        else
            object = className;
        
        for (NSString *key in [json allKeys])
        {
            id value = [json objectForKey:key];
            if (value == nil || value == [NSNull null])
            {
                continue;
            }
            
            if (![value isKindOfClass:[NSString class]])
            {
                if ([value isKindOfClass:[NSDictionary class]])
                {
                    SEL sel = NSSelectorFromString(key);  //获取对象引用方法
                    if ([object respondsToSelector:sel])
                    {
                        id i = [object performSelector:sel];   //获取对象
                        if ([i isKindOfClass:[NSDictionary class]])
                        {
                            NSString *setSel = [NSString stringWithFormat:@"set%@:",[NSString stringWithFormat:@"%@%@",[[key substringToIndex:1] uppercaseString],[key substringFromIndex:1]]];
                            SEL sel = NSSelectorFromString(setSel);
                            if ([object respondsToSelector:sel])
                            {
                                [object performSelector:sel withObject:value];
                            }
                            
                            continue;
                        }
                        JsonStringTransToObject(value, i);
                    }
                    continue;
                }
                else if ([value isKindOfClass:[NSArray class]])
                {
                    NSString *setSel = [NSString stringWithFormat:@"set%@:",[NSString stringWithFormat:@"%@%@",[[key substringToIndex:1] uppercaseString],[key substringFromIndex:1]]];
                    SEL sel = NSSelectorFromString(setSel);
                    if ([object respondsToSelector:sel])
                    {
                        
                        [object performSelector:sel withObject:value];
                    }
                    continue;
                }
            }
            if ([value respondsToSelector:@selector(isEqualToString:)])
            {
                if ([value isEqualToString:@"null"])
                    continue;
            }
            
            NSString *setSel = [NSString stringWithFormat:@"set%@:",[NSString stringWithFormat:@"%@%@",[[key substringToIndex:1] uppercaseString],[key substringFromIndex:1]]];
            SEL sel = NSSelectorFromString(setSel);
            if ([object respondsToSelector:sel])
            {
                [object performSelector:sel withObject:value];
            }
            
        }
        
        return object;
    }
    else if ([json isKindOfClass:[NSArray class]])
    {
        NSMutableArray *array = [NSMutableArray array];
        
        for (NSDictionary *dic in json)
        {
            id object = JsonStringTransToObject(dic, className);
            [array addObject:object];
        }
        
        return array;
        
    }
    return nil;
}

+ (NSString *)dateSwicth:(NSString *)dateStr{
    //2014/3/10 0:00:00
    //2014/11/4 17:22:58-----2015-1-12 0:00:00
    dateStr = [dateStr stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    if (dateStr.length >= 9) {
        NSString *set = [dateStr substringWithRange:NSMakeRange(6, 1)];
        NSString *newStr= nil;
        if ([set isEqualToString:@"-"]) {
            newStr = [dateStr substringToIndex:9];
        }else
        {
            newStr = [dateStr substringToIndex:10];
        }
 
        return newStr;
        
    }else{
        return dateStr;
    }
    
    
}

//  将数组重复的对象去除，只保留一个
+ (NSMutableArray *)arrayWithMemberIsOnly:(NSArray *)array
{
    NSMutableArray *categoryArray = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < [array count]; i++)
    {
        @autoreleasepool
        {
            if ([categoryArray containsObject:[array objectAtIndex:i]] == NO)
            {
                [categoryArray addObject:[array objectAtIndex:i]];
            }
        }
    }
    return categoryArray;
}
@end
