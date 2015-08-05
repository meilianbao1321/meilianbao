//
//  GlobalMacro.h
//  MZ_KGTeacher
//
//  Created by wannili on 14/12/10.
//  Copyright (c) 2014年 马 忠. All rights reserved.
//

#ifndef MZ_KGTeacher_GlobalMacro_h
#define MZ_KGTeacher_GlobalMacro_h


//nslog
#define whatIs(X)               NSLog(@"%@", X)
#define wIsNumber(X)            NSLog(@"%@", @(X))
#define wIsResult(result)       NSLog(@"%@", result?@"YES":@"NO");
#define wIsFrame(view)          NSLog(@"%@", NSStringFromCGRect(view.frame))
#define wIsImageSize(Image)     NSLog(@"%@", NSStringFromCGSize(Image.size))
#define wIsSize(Size)           NSLog(@"%@", NSStringFromCGSize(Size));
#define wIsPoint(Point)         NSLog(@"%@", NSStringFromCGPoint(Point));
#define wIsEdgeInset(EdgeInset) NSLog(@"%@", NSStringFromUIEdgeInsets(EdgeInset));

//快速makeCGFloat
#define CM(Y,W,H)               CGRectMake((SWIDTH-W)/2, Y, W, H)
#define XCM(X,Y,H)              CGRectMake(X, Y, (SWIDTH-X*2), H)
#define RM(X, Y, W, H)          CGRectMake(X, Y, W, H)
#define PM(X, Y)                CGPointMake(X, Y)
#define SM(W, H)                CGSizeMake(W, H)
#define EM(T, L, B, R)          UIEdgeInsetsMake(T, L, B, R)

//快速alloc、快速改变背景颜色、混合
#define QA(class)               [[class alloc]init]
#define QNA(name,class)         class*name=[[class alloc]init]
#define SB(name,color)          name.backgroundColor=color
#define QF(class,frame)         [[class alloc]initWithFrame:frame]
#define QNF(name,class,frame)   class*name=[[class alloc]initWithFrame:frame]


//定制颜色
#define white(White,Alpha)      [UIColor colorWithWhite:White alpha:Alpha]

#define hongSystem              [UIColor colorWithRed:1.000 green:0.150 blue:0.300 alpha:1.000]
#define cheng                   [UIColor colorWithRed:1.000 green:0.668 blue:0.422 alpha:1.000]
#define huang                   [UIColor colorWithRed:1.000 green:0.839 blue:0.482 alpha:1.000]
#define lv                      [UIColor colorWithRed:0.619 green:1.000 blue:0.742 alpha:1.000]
#define lan                     [UIColor colorWithRed:0.439 green:0.816 blue:1.000 alpha:1.000]
#define zizi                    [UIColor colorWithRed:0.728 green:0.579 blue:1.000 alpha:1.000]

//文件
#define fDocuments              NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject
#define fLibrary                NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject
#define fCaches                 NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject
#define fTmp                    NSTemporaryDirectory()
#define fHome                   NSHomeDirectory()

//  方法
#define VCAV(View)              [self.view addSubview:View]
#define AV(View)                [self addSubview:View]
#define ScreenSize_3_5                  ([UIScreen mainScreen].bounds.size.height == 480)
#define HasBlock(block)                 if(block){block();}
#define P1Block(block,param)            if(block){block(param);}
#define P2Block(block,param1,param2)    if(block){block(param1,param2);}


#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define RGBA(R/*红*/, G/*绿*/, B/*蓝*/, A/*透明*/) \
[UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]


//上传图片、音频、视频
#define UPLOADURL @"http://weixin.mzywx.com/fileupload/FileUploadServlet"
//用户Id
#define USER_ID  [[NSUserDefaults standardUserDefaults]objectForKey:@"teacherId"]

//服务器地址
#define BaseURL @"http://yzbb.mzywx.com/yzbb"
//#define BaseURL @"http://114igo.cn/youeryuan"
//#define BaseURL @"http://10.0.212.249/youeryuan"

//用户名
#define LoginName [[NSUserDefaults standardUserDefaults]objectForKey:@"userName"]
//密码
#define LoginPassword [[NSUserDefaults standardUserDefaults]objectForKey:@"passWord"]

//AppDelegate
//#define g_App ((AppDelegate*)[[UIApplication sharedApplication] delegate])


#endif
