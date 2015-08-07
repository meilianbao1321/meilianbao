//
//  SecondViewController.h
//  MeiPinJie
//
//  Created by mac on 15/7/1.
//  Copyright (c) 2015年 Alex. All rights reserved.
//
@protocol SecondViewDelegate <NSObject>

-(void)popwithSecondUrl:(NSURL *)url;

@end

#import "MainViewController.h"
#import "ThirdViewController.h"
@interface SecondViewController : MainViewController<ThirdViewDelegate>
@property (nonatomic,assign)  id delegate;
@property (nonatomic,strong) NSString * isrefresh;

@end
