//
//  MLBModel.h
//  MeiPinJie
//
//  Created by mac on 15/6/25.
//  Copyright (c) 2015年 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLBModel : NSObject

@property (nonatomic,assign) NSInteger navBackColor;
@property (nonatomic,assign) NSInteger isShowTabBar;
@property (nonatomic,assign) NSInteger isShowNavRightBtn1;
@property (nonatomic,assign) NSInteger isShowNavRightBtn2;
@property (nonatomic,strong) NSString *titleAligen;
@property (nonatomic,assign) NSInteger isShowRefresh;
@property (nonatomic,strong) NSString *btnImage;
@property (nonatomic,strong) NSString *btnName;
@property (nonatomic,assign) NSInteger btnType;
@property (nonatomic,strong) NSString *btnData;
@property (nonatomic,assign) NSInteger isLoction;

@property (nonatomic,strong) NSString *OrderId; //订单ID
@property (nonatomic,strong) NSString *Amount; //金额
@property (nonatomic,strong) NSString *OrderTitle; //订单名称
@property (nonatomic,strong) NSString *returnUrl; //支付完成返回链接
@property (nonatomic,strong) NSString *notifyUrl; //服务端通知页面
@property (nonatomic,strong) NSString * payType; //支付类型
@property (nonatomic,strong) NSString  *yinLiaTN; //银联交易流水号

@property (nonatomic,assign) NSInteger rightBtnShareToWhere;
@property (nonatomic,strong) NSString *shareTitle; 
@property (nonatomic,strong) NSString *sharePicture;
@property (nonatomic,strong) NSString *sharedesc;
@property (nonatomic,strong) NSString *shareUrl;

+(MLBModel *)makeModelWithDict:(NSDictionary *)dict;
+(MLBModel *)makePayModelWithDict:(NSDictionary *)dict;
@end
