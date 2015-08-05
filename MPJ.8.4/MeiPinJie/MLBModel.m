//
//  MLBModel.m
//  MeiPinJie
//
//  Created by mac on 15/6/25.
//  Copyright (c) 2015年 Alex. All rights reserved.
//

#import "MLBModel.h"

@implementation MLBModel
+(MLBModel *)makeModelWithDict:(NSDictionary *)dict{
    MLBModel * model =[[MLBModel alloc]init];
    model.isShowTabBar =[[dict objectForKey:@"hbm"]integerValue];
    model.isShowRefresh =[[dict objectForKey:@"ir"]integerValue];

    if ([[dict objectForKey:@"hs"] isKindOfClass:[NSString class]]) {
        model.isShowNavRightBtn2=[[dict objectForKey:@"hs"]integerValue];
    }else{
        model.isShowNavRightBtn2=1;
    }

    if ([[dict objectForKey:@"ir"] isKindOfClass:[NSString class]]) {
        model.isShowRefresh=[[dict objectForKey:@"ir"]integerValue];
    }else{
        model.isShowRefresh=1;
    }

    model.navBackColor =[[dict objectForKey:@"bc"] isEqualToString:@"#dd137b"];
    model.titleAligen =[dict objectForKey:@"ta"];
    model.isLoction =[[dict objectForKey:@"il"] integerValue];
    if ([[dict objectForKey:@"b"] isKindOfClass:[NSDictionary class]]) {
        NSDictionary * tmpDict =[NSDictionary dictionaryWithDictionary:[dict objectForKey:@"b"]];
        model.isShowNavRightBtn1 =1;
        model.btnImage =  [tmpDict objectForKey:@"p"];

        model.btnName  =  [tmpDict objectForKey:@"n"];

        model.btnType  =  [[tmpDict objectForKey:@"type"]integerValue];
        
        model.btnData  =  [tmpDict objectForKey:@"d"];
    }else{
        model.isShowNavRightBtn1 = 0;
    }
    if ([[dict objectForKey:@"s"] isKindOfClass:[NSDictionary class]]) {
        NSDictionary * tmpDict =[NSDictionary dictionaryWithDictionary:[dict objectForKey:@"s"]];
        model.rightBtnShareToWhere =1;
        model.shareTitle =  [tmpDict objectForKey:@"t"];

        model.shareUrl  =  [tmpDict objectForKey:@"u"];

        model.sharePicture  =  [tmpDict objectForKey:@"p"];

        model.sharedesc  =  [tmpDict objectForKey:@"d"];
    }else{
        model.rightBtnShareToWhere = 0;
    }
    return model;
}
+(MLBModel *)makePayModelWithDict:(NSDictionary *)dict{
    MLBModel * model =[[MLBModel alloc]init];
    model.OrderId =[dict objectForKey:@"o"];
    model.notifyUrl = [dict objectForKey:@"n"];
    model.OrderTitle =[dict objectForKey:@"t"];
    model.Amount =[dict objectForKey:@"a"];
    model.payType =[dict objectForKey:@"pt"];
    model.returnUrl =[dict objectForKey:@"r"];
    model.yinLiaTN=[dict objectForKey:@"tn"];
    if ([[dict objectForKey:@"tn"] isKindOfClass:[NSString class]]) {
        model.yinLiaTN=[dict objectForKey:@"tn"];
    }
    return model;
}
@end
