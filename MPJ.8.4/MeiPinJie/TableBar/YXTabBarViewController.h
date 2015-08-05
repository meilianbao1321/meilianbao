//
//  YXTabBarViewController.h
//  StoreDemo
//
//  Created by zh on 14-7-7.
//  Copyright (c) 2014年 lyx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXTabBarViewController : UITabBarController
{
    NSInteger *_selectedIndex;
    UIImage *_bgImg;
    NSArray *_barBtnImgArray;
    NSString *_pType;
    NSInteger g_selectedTag;
}
@property (nonatomic,strong) UIImage *bgImg;
@property (nonatomic,strong)NSArray *barBtnImgArray;
@property (nonatomic,strong)UIButton *fistBtn;
@property (nonatomic,strong)UIButton *secondBtn;
@property (nonatomic,strong)UIButton *thirdBtn;
@property (nonatomic,strong)UIButton *fourthBtn;
@property (nonatomic,strong)UIButton *shadeBtn;
@property (nonatomic,strong)UIButton *backBtn;
@property (nonatomic, assign)NSInteger g_selectedTag;

@property (nonatomic,strong)UIButton *shopBtn;
@property (nonatomic,strong)UIButton *commentBtn;
@property (nonatomic,strong)NSString *pType;


- (void)customBar;
-(void)buttonClickAction:(id)sender;
- (void)changeTextColor;

//- (void)hideMore;
//- (void)showMore;
@end
