//
//  UserGuideViewController.m
//  MoJing
//
//  Created by mac on 15/7/9.
//  Copyright (c) 2015年 zh. All rights reserved.
//

#import "UserGuideViewController.h"
#import "mainViewController.h"
#import "MenuViewController.h"
#import "GuideTwoViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourViewController.h"
#import "YXTabBarViewController.h"
#import "JDSideMenu.h"


#define image_x self.view.frame.size.width
#define image_y self.view.frame.size.height

@interface UserGuideViewController ()
@property (nonatomic,strong)UIImageView *oneone;
@property (nonatomic,strong)UIImageView *oneTwo;
@property (nonatomic,strong)UIImageView *oneThree;
@property (nonatomic,strong)UIImageView *oneFour;
@property (nonatomic,strong)UIImageView *oneFive;


@end

@implementation UserGuideViewController

- (UIImageView *)oneFour{
    if (!_oneFour) {
        
        _oneFour = [[UIImageView alloc] init];
     //   _oneFour = [[UIImageView alloc] initWithFrame:CGRectMake(image_x/3*2, image_y/2- image_x/64*5, image_x/4, image_x/4)];
        _oneFour.image = [UIImage imageNamed:@"1-4"];
    }
    return _oneFour;
}

- (UIImageView *)oneFive{
    if (!_oneFive) {
        _oneFive = [[UIImageView alloc] init];
      //  _oneFive = [[UIImageView alloc] initWithFrame:CGRectMake(image_x/3*2, image_y/2+ image_x/16*5, image_x/4, image_x/4)];
        _oneFive.image = [UIImage imageNamed:@"1-5"];
        
    }
    return _oneFive;
}


- (UIImageView *)oneThree{
    if (!_oneThree) {
        _oneThree = [[UIImageView alloc] init];
      //  _oneThree = [[UIImageView alloc] initWithFrame:CGRectMake(image_x/3*2,image_y/2 - image_x/2, image_x/4, image_x/4)];
        _oneThree.image = [UIImage imageNamed:@"1-3"];
    }
    return _oneThree;
}
- (UIImageView *)oneTwo{
    if (!_oneTwo) {
        _oneTwo = [[UIImageView alloc] initWithFrame:CGRectMake(image_x/8 +image_x/3,image_y/2 - image_y/8, image_x/5, image_y/3)];
        _oneTwo.image = [UIImage imageNamed:@"1-2"];
        
    }
    return _oneTwo;
}

- (UIImageView *)oneone{
    if (!_oneone) {
        _oneone = [[UIImageView alloc] init];
        
        _oneone.image = [UIImage imageNamed:@"1-1"];
    }
    return _oneone;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initGuide];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(buttonAction)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];


    
}
//加载scrollview
- (void)initGuide{
    /*
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, image_x , image_y)];
    [scrollView setContentSize:CGSizeMake(self.view.bounds.size.width * 4, 0)];
    //设置视图整页显示
    [scrollView setPagingEnabled:YES];
     */
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image_x, image_y)];
   
    imageView.image = [UIImage imageNamed:@"endview"];
    UIImageView *top = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, image_x/7*4, image_y*2/10)];
    top.image = [UIImage imageNamed:@"toplogo"];
    
   
    
    NSString *str = @"掌上移动学院";
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(image_x/3*2,image_y/2 - image_x/2 + image_x/4, image_x/4, 20)];
    label.text = str;
    label.textAlignment = NSTextAlignmentCenter;
    if (iPhone5) {
        label.font = [UIFont italicSystemFontOfSize: 13];
    }else if (iPhone6){
    label.font = [UIFont italicSystemFontOfSize: 15];
    }else{
        label.font = [UIFont italicSystemFontOfSize: 13];
    }
    [label.layer addAnimation:[self opacityForver_Animation:1.5f] forKey:nil];
    
    NSString *str1 = @"美业招聘求职";
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(image_x/3*2, image_y/2- image_x/64*5 +image_x/4, image_x/4, 20)];
    label1.text = str1;
    label1.textAlignment = NSTextAlignmentCenter;
    if (iPhone5) {
        label1.font = [UIFont italicSystemFontOfSize:13];
    }else if (iPhone6){
    label1.font = [UIFont italicSystemFontOfSize:15];
    }else{
        label1.font = [UIFont italicSystemFontOfSize:13];
    }
    [label1.layer addAnimation:[self opacityForver_Animation:1.5f] forKey:nil];
    
    NSString *str3 = @"管理咨询策划";
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(image_x/3*2, image_y/2+ image_x/16*5 +image_x/4, image_x/4, 20)];
    label2.text = str3;
    label2.textAlignment = NSTextAlignmentCenter;
    if (iPhone5) {
        label2.font = [UIFont italicSystemFontOfSize:13];
    }else if (iPhone6 && iPhone6Plus){
        label2.font = [UIFont italicSystemFontOfSize:15];
    }else{
        label2.font = [UIFont italicSystemFontOfSize:13];
    }
    [label2.layer addAnimation:[self opacityForver_Animation:1.5f] forKey:nil];
    
   
    
   
    [imageView addSubview:label];
    [imageView addSubview:label1];
    [imageView addSubview:label2];
    [imageView addSubview:self.oneTwo];
    [imageView addSubview:self.oneone];
    [imageView addSubview:self.oneThree];
    [imageView addSubview:self.oneFour];
    [imageView addSubview:self.oneFive];
    [imageView addSubview:top];
    [self.view addSubview:imageView];
    /*
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    imageView1.backgroundColor = [UIColor greenColor];
    [scrollView addSubview:imageView1];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * 2, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    imageView2.backgroundColor = [UIColor blueColor];
    [scrollView addSubview:imageView2];
    
    UIImageView *imageview3 = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * 3, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    imageview3.backgroundColor = [UIColor grayColor];
    //打开imageview3的用户交互，否则下面的button无法响应
    imageview3.userInteractionEnabled = YES;
    [scrollView addSubview:imageview3];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:nil forState:UIControlStateNormal];
    [button setFrame:CGRectMake(self.view.bounds.size.width/2 - 150, self.view.frame.size.height - 100, 300, 50)];
    button.backgroundColor = [UIColor cyanColor];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [imageview3 addSubview:button];
    
    [self.view addSubview:scrollView];
    
    */
    
    
}
//跳转到主页面
- (void)buttonAction{
    
    CATransition *animation = [CATransition animation];
    animation.duration = 1.0f;
    [animation setType:kCAEmitterLayerSphere];
    [animation setSubtype:kCATransitionFromTop];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    
    GuideTwoViewController *two = [[GuideTwoViewController alloc] init];
    [self presentModalViewController:two animated:NO];
    [self.view.window.layer addAnimation:animation forKey:nil];
    

}

- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"即将加载出来");
 
    [self.oneone setFrame:CGRectMake(image_x/8, image_y/2 - image_y/8, image_x/3, image_y/3)];
    [self.oneone.layer addAnimation:[self scale:[NSNumber numberWithFloat:0.0f] orgin:[NSNumber numberWithFloat:1.0f] durTimes:2.0f Rep:MAXFLOAT] forKey:nil];
    CATransition *animation = [CATransition animation];
    animation.duration = 2.0f;
    [animation setType:kCATransitionMoveIn];
    [animation setSubtype:kCATransitionFromBottom];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [self.oneThree.layer addAnimation:animation forKey:nil];
    [self.oneThree setFrame:CGRectMake(image_x/3*2,image_y/2 - image_x/16*8, image_x/4, image_x/4)];
    
    CATransition *animation1 = [CATransition animation];
    animation1.duration = 2.0f;
    [animation1 setType:kCATransitionMoveIn];
    [animation1 setSubtype:kCATransitionFromRight];
    [animation1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [self.oneFour.layer addAnimation:animation1 forKey:nil];
    [self.oneFour setFrame:CGRectMake(image_x/3*2, image_y/2- image_x/64*5, image_x/4, image_x/4)];
    
    CATransition *animation2 = [CATransition animation];
    animation2.duration = 2.0f;
    [animation2 setType:kCATransitionMoveIn];
    [animation2 setSubtype:kCATransitionFromTop];
    [animation2 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [self.oneFive.layer addAnimation:animation2 forKey:nil];
    [self.oneFive setFrame:CGRectMake(image_x/3*2, image_y/2+ image_x/16*5, image_x/4, image_x/4)];
  
    
    
}

- (void)LeftAction{
    CATransition *animation = [CATransition animation];
    animation.duration = 2.0f;
    [animation setType:kCATransitionFade];
  //  [animation setSubtype:kCATransitionFromBottom];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    GuideTwoViewController *guide = [[GuideTwoViewController alloc] init];
    [self presentModalViewController:guide animated:NO];
    [self.view.window.layer addAnimation:animation forKey:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark

- (CABasicAnimation *)opacityForver_Animation:(float)time
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.0f];
    animation.autoreverses = YES;
    animation.duration = time;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    return animation;
}

//缩放动画
-(CABasicAnimation *)scale:(NSNumber *)Multiple orgin:(NSNumber *)orginMultiple durTimes:(float)time Rep:(float)repertTimes
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = Multiple;
    animation.toValue = orginMultiple;
    animation.autoreverses =  NO;
   // animation.repeatCount = repertTimes;
    animation.duration = time;//不设置时候的话，有一个默认的缩放时间.
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    
    return  animation;
}
@end
