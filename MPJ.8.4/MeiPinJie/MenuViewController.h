//
//  MenuViewController.h
//  MeiPinJie
//
//  Created by mac on 15/6/27.
//  Copyright (c) 2015年 Alex. All rights reserved.
//

@protocol MenuControllerDelegate <NSObject>

- (void)showRootController:(BOOL)animated;

@end

#import "UILabel+BGChange.h"
#import <UIKit/UIKit.h>
#import "FirstViewController.h"
@interface MenuViewController : UIViewController<UIWebViewDelegate>

@property (nonatomic,assign) id mainDelegate;
@end
