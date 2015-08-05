//
//  SpecialViewController.h
//  MeiPinJie
//
//  Created by mac on 15/7/20.
//  Copyright (c) 2015年 Alex. All rights reserved.
//
@protocol SpecialViewDelegate <NSObject>

-(void)popwithUrl:(NSURL *)url;

@end
#import "MainViewController.h"
@interface SpecialViewController : MainViewController<UIAlertViewDelegate>
@property (nonatomic,assign)  id delegate;

@end
