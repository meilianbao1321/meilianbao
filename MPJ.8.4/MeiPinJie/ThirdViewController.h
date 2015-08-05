//
//  ThirdViewController.h
//  MeiPinJie
//
//  Created by mac on 15/7/4.
//  Copyright (c) 2015年 Alex. All rights reserved.
//
@protocol ThirdViewDelegate <NSObject>

-(void)popwithThirdUrl:(NSURL *)url;

@end
#import "MainViewController.h"
#import "FourViewController.h"
@interface ThirdViewController : MainViewController<FourViewDelegate>
@property (nonatomic,assign)  id delegate;

@end
