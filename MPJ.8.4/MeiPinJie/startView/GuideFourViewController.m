//
//  GuideFourViewController.m
//  MoJing
//
//  Created by mac on 15/7/21.
//  Copyright (c) 2015年 zh. All rights reserved.
//

#import "GuideFourViewController.h"
#import "GuideThrViewController.h"
#import "YXTabBarViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourViewController.h"
#import "FirstViewController.h"
#import "MenuViewController.h"
#import "JDSideMenu.h"
#import "MMExampleDrawerVisualStateManager.h"
#define image_x self.view.frame.size.width
#define image_y self.view.frame.size.height

@interface GuideFourViewController ()
@property (nonatomic, strong)UIImageView *fourOne;
@property (nonatomic, strong)UIImageView *fourTwo;
@property (nonatomic, strong)UIImageView *fourThr;

@end

@implementation GuideFourViewController

- (UIImageView *)fourOne{
    if (!_fourOne) {
        _fourOne = [[UIImageView alloc] initWithFrame:CGRectMake(image_x/6, image_y/20*6, image_x/3*2, image_x/10)];
        _fourOne.image = [UIImage imageNamed:@"4-1"];
    }
    return _fourOne;
}

- (UIImageView *)fourTwo{
    if (!_fourTwo) {
        _fourTwo = [[UIImageView alloc] initWithFrame:CGRectMake(image_x/6, image_y/20*6 +image_x/10 + 20, image_x/3*2, image_x/13)];
        _fourTwo.image = [UIImage imageNamed:@"4-2"];
    }
    return _fourTwo;
}

- (UIImageView *)fourThr{
    if (!_fourThr) {
        _fourThr = [[UIImageView alloc] init];
     //   _fourThr = [[UIImageView alloc] initWithFrame:CGRectMake(image_x/12 ,image_y/20*4 , image_x/12*11 ,image_y/20*16)];
        _fourThr.image = [UIImage imageNamed:@"4-3"];
    }
    return _fourThr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initGuide];

    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(RightAction)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];

    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(LeftAction)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
}
- (void)initGuide{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image_x, image_y)];
    
    imageView.image = [UIImage imageNamed:@"endview"];
    UIImageView *top = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, image_x/7*4, image_y*2/10)];
    top.image = [UIImage imageNamed:@"toplogo"];
    [imageView addSubview:top];
    [imageView addSubview:self.fourOne];
    [imageView addSubview:self.fourTwo];
    [imageView addSubview:self.fourThr];
    [self.view addSubview:imageView];
}


- (void)LeftAction{
    CATransition *animation = [CATransition animation];
    animation.duration = 2.0f;
    [animation setType:kCATransitionFade];
    //  [animation setSubtype:kCATransitionFromBottom];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    GuideThrViewController *guide = [[GuideThrViewController alloc] init];
    [self presentModalViewController:guide animated:NO];
    [self.view.window.layer addAnimation:animation forKey:nil];
}

- (void)RightAction{



    CATransition *animation = [CATransition animation];
    animation.duration = 2.0f;
    [animation setType:kCATransitionFade];
    //  [animation setSubtype:kCATransitionFromBottom];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];

    MenuViewController * menu = [[MenuViewController alloc]init];
    AppDelegate * app =(AppDelegate *)[UIApplication sharedApplication].delegate;

    if (IOS6) {
        app.rooVC  = [[MMDrawerController alloc] initWithCenterViewController:app.tabbar leftDrawerViewController:menu];
        [app.rooVC  setMaximumLeftDrawerWidth:200];
        //设置侧拉门开与关的动画
        [app.rooVC  setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
        [app.rooVC  setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
        [[MMExampleDrawerVisualStateManager sharedManager] setLeftDrawerAnimationType:MMDrawerAnimationTypeNone];
        [app.rooVC  setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
            MMDrawerControllerDrawerVisualStateBlock block;
            block = [[MMExampleDrawerVisualStateManager sharedManager]
                     drawerVisualStateBlockForDrawerSide:drawerSide];
            if(block){
                block(drawerController, drawerSide, percentVisible);
            }
            
        }];
        self.view.window.rootViewController =app.rooVC ;
    }else{
    JDSideMenu * sideMenu =[[JDSideMenu alloc]initWithContentController:app.tabbar menuController:menu];
    
    UINavigationController * mvc  = app.tabbar.viewControllers[0];
    UINavigationController * svc = app.tabbar.viewControllers[1];
    UINavigationController * tvc  = app.tabbar.viewControllers[2];
    UINavigationController * fvc   = app.tabbar.viewControllers[3];
    FirstViewController * mvc1 =   mvc.viewControllers[0];
    SecondViewController * svc1 = svc.viewControllers[0];
    ThirdViewController * tvc1 =tvc.viewControllers[0];
    FourViewController * fvc1 = fvc.viewControllers[0];

    mvc1.mainDelegate =sideMenu;
    svc1.mainDelegate =sideMenu;
    tvc1.mainDelegate =sideMenu;
    fvc1.mainDelegate =sideMenu;
    sideMenu.menuWidth =VIEW_WIDH/5*3;
    self.view.window.rootViewController =sideMenu;
    }
//    [self presentModalViewController:sideMenu animated:NO];
//    [self.view.window.layer addAnimation:animation forKey:nil];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    CATransition *animation2 = [CATransition animation];
    animation2.duration = 2.0f;
    [animation2 setType:kCATransitionMoveIn];
    [animation2 setSubtype:kCATransitionFromTop];
    [animation2 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [self.fourThr.layer addAnimation:animation2 forKey:nil];
    [self.fourThr setFrame:CGRectMake(image_x/12 ,image_y/20*4 , image_x/12*11 ,image_y/20*16)];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
