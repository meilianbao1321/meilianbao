//
//  HttpRequest.h
//  MeiPinJie
//
//  Created by mac on 15/6/25.
//  Copyright (c) 2015年 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#define AlexCores [HttpRequest share]
@class  MLBModel;
//typedef void(^RequestBlock)(MLBModel * model);
@interface HttpRequest : NSObject{
    
}

//@property (nonatomic,strong) RequestBlock downBlock;

+(HttpRequest *)share;

-(void)requestToLogin:(NSString *)userName withPassWord:(NSString *)passWord withComplete:(void(^)(BOOL success))complete;
@end
