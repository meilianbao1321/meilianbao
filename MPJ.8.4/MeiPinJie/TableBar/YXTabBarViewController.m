//
//  YXTabBarViewController.m
//  StoreDemo
//
//  Created by zh on 14-7-7.
//  Copyright (c) 2014年 lyx. All rights reserved.
//

#import "YXTabBarViewController.h"
#import "YXTools.h"
#import "PrefixHeader.pch"


#define  tabitem_width self.view.frame.size.width/4
#define  tabitem_hight  50/2
#define  other_offtop 2
#define  img_width  50/2
#define  img_x  (self.view.frame.size.width/4-img_width)/2

@interface YXTabBarViewController ()
{
    UIImageView *imageView1;
    UIImageView *imageView2;
    UIImageView *imageView3;
    UIImageView *imageView4;
    UILabel *tabbarTitle1;
    UILabel *tabbarTitle2;
    UILabel *tabbarTitle3;
    UILabel *tabbarTitle4;
}
@end

@implementation YXTabBarViewController
@synthesize bgImg = _bgImg;
@synthesize barBtnImgArray = _barBtnImgArray;
@synthesize pType = _pType;
@synthesize fistBtn,secondBtn,thirdBtn,fourthBtn,shadeBtn,backBtn,shopBtn,commentBtn,g_selectedTag = g_selectedTag;

enum barsize{
    img_hight=24,
    img_y=(49 - tabitem_hight)/5
    
    
};

- (BOOL)shouldAutorotate{
    //调用子视图控制器的shouldAutorotate
    return YES;
}
- (NSUInteger)supportedInterfaceOrientations{
    //self.topViewController 获取当前的子视图控制器地址
    
    
    return UIInterfaceOrientationMaskPortrait;
    //上面调用supportedInterfaceOrientations 的方法是当前显示的子视图控制器的supportedInterfaceOrientations
    
    //return UIInterfaceOrientationMaskPortrait;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
     
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)customBar
{
    self.view.backgroundColor = [UIColor whiteColor];
    if (iPhone6)
    {
        self.tabBar.backgroundImage = [UIImage imageNamed:@"tabBarBg_6.png"];
    }else if (iPhone6Plus)
    {
        self.tabBar.backgroundImage = [UIImage imageNamed:@"tabBarBg_6Plus.png"];
    }else
    {
        self.tabBar.backgroundImage = [UIImage imageNamed:@"tabBarBg"];
    }
    g_selectedTag = 1;
    [self hideBarSubView];
    [self createBarButton];
}
- (void)hideBarSubView
{
    for (UIView *view in self.tabBar.subviews)
    {
        view.hidden = YES;
    }
   
    
    

}

- (void)createBarButton
{
     //first
    
   
   
    fistBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    if (IOS6) {
        fistBtn.backgroundColor = [UIColor lightGrayColor];
    }else{
    fistBtn.backgroundColor = [UIColor clearColor];
    }
    [fistBtn setFrame:CGRectMake(0, other_offtop, tabitem_width, 70)];
    [fistBtn setTag:1];
    [fistBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabbarS0"] highlightedImage:nil];
    imageView1.frame = CGRectMake(img_x, img_y, img_width, tabitem_hight);
   // imageView1.backgroundColor = [UIColor blueColor];
    NSString *str = @"主页";

   // UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, tabitem_hight, tabitem_width, 20)];
   // label.text = str;
    //    label.font = [UIFont systemFontOfSize:10];
    //label.textAlignment = NSTextAlignmentCenter;
    [fistBtn setTitle:str forState:UIControlStateNormal];
    [fistBtn.titleLabel setFrame:CGRectMake(0, tabitem_hight, tabitem_width, 20)];
    fistBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    
    [fistBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

   // [fistBtn addSubview:label];
    
    [fistBtn addSubview:imageView1];
    
    //second
    imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabbar1"] highlightedImage:nil];
    imageView2.frame = CGRectMake(img_x, img_y, img_width, tabitem_hight);
    NSString *str1 = @"美业论坛";
    
//    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, tabitem_hight, tabitem_width, 20)];
//    label1.text = str1;
//    label1.font = [UIFont systemFontOfSize:10];
//    label1.textAlignment = NSTextAlignmentCenter;
    
   
    secondBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    if (IOS6) {
        secondBtn.backgroundColor = [UIColor lightGrayColor];
    }else{
        secondBtn.backgroundColor = [UIColor clearColor];
    }
    [secondBtn setFrame:CGRectMake(tabitem_width, other_offtop, tabitem_width, 70)];
    [secondBtn setTag:2];
    [secondBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [secondBtn setTitle:str1 forState:UIControlStateNormal];
    [secondBtn.titleLabel setFrame:CGRectMake(0, tabitem_hight, tabitem_width, 20)];
    secondBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [secondBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    

    [secondBtn addSubview:imageView2];
    
 
    
    //third
    
    imageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabbar2"] highlightedImage:nil];
    imageView3.frame = CGRectMake(img_x, img_y, img_width, tabitem_hight);
    
    NSString *str2 = @"名师名店";
   
    
    thirdBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    if (IOS6) {
        thirdBtn.backgroundColor = [UIColor lightGrayColor];
    }else{
        thirdBtn.backgroundColor = [UIColor clearColor];
    }
    [thirdBtn setFrame:CGRectMake(tabitem_width*2, other_offtop, tabitem_width, 70)];
    [thirdBtn setTag:3];
    [thirdBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [thirdBtn setTitle:str2 forState:UIControlStateNormal];
    [thirdBtn.titleLabel setFrame:CGRectMake(0, tabitem_hight, tabitem_width, 20)];
    thirdBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [thirdBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    [thirdBtn addSubview:imageView3];
   
  //  thirdBtn.backgroundColor = [UIColor grayColor];
    
    //four
    imageView4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabbar3"] highlightedImage:nil];
    imageView4.frame = CGRectMake(img_x, img_y, img_width, tabitem_hight);
    NSString *str3 = @"会员中心";
    
    fourthBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    if (IOS6) {
        fourthBtn.backgroundColor = [UIColor lightGrayColor];
    }else{
        fourthBtn.backgroundColor = [UIColor clearColor];
    }
    [fourthBtn setFrame:CGRectMake(tabitem_width*3, other_offtop, tabitem_width, 70)];
    [fourthBtn setTag:4];
    [fourthBtn addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [fourthBtn setTitle:str3 forState:UIControlStateNormal];
    [fourthBtn.titleLabel setFrame:CGRectMake(0, tabitem_hight, tabitem_width, 20)];
    fourthBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [fourthBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    [fourthBtn addSubview:imageView4];
   
   // fourthBtn.backgroundColor = [UIColor blackColor];
    
    
    [self.tabBar addSubview:fistBtn];
    [self.tabBar addSubview:secondBtn];
    [self.tabBar addSubview:thirdBtn];
    [self.tabBar addSubview:fourthBtn];
    

}


-(void)buttonClickAction:(UIButton *)sender{
    
    
  
    
    
  

     if(g_selectedTag==sender.tag)
        return;
    else
        g_selectedTag = sender.tag;
    

    
    /*
    if (fistBtn.tag!=sender.tag) {
        ((UIImageView *)fistBtn.subviews[0]).highlighted=NO;
    }
    
    if (secondBtn.tag!=sender.tag) {
        ((UIImageView *)secondBtn.subviews[0]).highlighted=NO;
    }
    if (secondBtn.tag!=sender.tag) {
        ((UIImageView *)thirdBtn.subviews[0]).highlighted=NO;
    }
    if (secondBtn.tag!=sender.tag) {
        ((UIImageView *)fourthBtn.subviews[0]).highlighted=NO;
    }
*/
    [self changeTextColor];
    [self imgAnimate:sender];
    
   // ((UIImageView *)sender.subviews[0]).highlighted=YES;
     self.selectedIndex = sender.tag-1;
    
    
   
}

- (void)changeTextColor
{
    [UIView animateWithDuration:0.3 animations:
     ^(void){
         
         if (g_selectedTag == 1) {
             imageView1.image = [UIImage imageNamed:@"tabbarS0"];
             imageView2.image = [UIImage imageNamed:@"tabbar1"];
             imageView3.image = [UIImage imageNamed:@"tabbar2"];
             imageView4.image = [UIImage imageNamed:@"tabbar3"];
         }else if (g_selectedTag == 2)
         {
             imageView1.image = [UIImage imageNamed:@"tabbar0"];
             imageView2.image = [UIImage imageNamed:@"tabbarS1"];
             imageView3.image = [UIImage imageNamed:@"tabbar2"];
             imageView4.image = [UIImage imageNamed:@"tabbar3"];
         }else if (g_selectedTag == 3){
             imageView1.image = [UIImage imageNamed:@"tabbar0"];
             imageView2.image = [UIImage imageNamed:@"tabbar1"];
             imageView3.image = [UIImage imageNamed:@"tabbarS2"];
             imageView4.image = [UIImage imageNamed:@"tabbar3"];
         }else{
             imageView1.image = [UIImage imageNamed:@"tabbar0"];
             imageView2.image = [UIImage imageNamed:@"tabbar1"];
             imageView3.image = [UIImage imageNamed:@"tabbar2"];
             imageView4.image = [UIImage imageNamed:@"tabbarS3"];
         }
         
         
     } completion:^(BOOL finished){//do other thing
     }];
    
}

- (void)imgAnimate:(UIButton*)btn{
    
    UIView *view=btn.subviews[1];
    NSLog(@"%@",btn.subviews);
    
    
 
    [UIView animateWithDuration:0.1 animations:
     ^(void){
         
         view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.5, 0.5);
       //  btn.titleLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.5, 0.5);
      //   view1.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.5, 0.5);

     } completion:^(BOOL finished){//do other thing
         [UIView animateWithDuration:0.2 animations:
          ^(void){
              
              view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.2, 1.2);
          //    btn.titleLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.2, 1.2);
        //      view1.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.2, 1.2);
              
          } completion:^(BOOL finished){//do other thing
              [UIView animateWithDuration:0.1 animations:
               ^(void){
                   
                   view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1,1);
           //        btn.titleLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
         //          view1.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.1, 1.1);
                   
               } completion:^(BOOL finished){//do other thing
               }];
          }];
     }];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
