//
//  FourViewController.h
//  MeiPinJie
//
//  Created by mac on 15/7/4.
//  Copyright (c) 2015年 Alex. All rights reserved.
//
@protocol FourViewDelegate <NSObject>

-(void)popwithFourUrl:(NSURL *)url;

@end
#import "MainViewController.h"
#import "SecondViewController.h"

@interface FourViewController : MainViewController<SecondViewDelegate>
@property (nonatomic,assign)  id delegate;

@end
