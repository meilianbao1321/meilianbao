//
//  GuideThrViewController.m
//  MoJing
//
//  Created by mac on 15/7/21.
//  Copyright (c) 2015年 zh. All rights reserved.
//

#import "GuideThrViewController.h"
#import "GuideTwoViewController.h"
#import "GuideFourViewController.h"


#define image_x self.view.frame.size.width
#define image_y self.view.frame.size.height


@interface GuideThrViewController ()

@property (nonatomic, strong)UIImageView *thrOne;
@property (nonatomic, strong)UIImageView *thrTwo;


@end

@implementation GuideThrViewController

- (UIImageView *)thrOne{
    if (!_thrOne) {
        _thrOne = [[UIImageView alloc] initWithFrame:CGRectMake(image_x/8, image_y/3, image_x/4*3, image_x/5)];
        _thrOne.image = [UIImage imageNamed:@"3-1"];
    }
    return _thrOne;
}

- (UIImageView *)thrTwo{
    if (!_thrTwo) {
        _thrTwo = [[UIImageView alloc] initWithFrame:CGRectMake(image_x/5, image_y/3 + image_x/5 +20, image_x/5*3, image_x/3*2)];
        _thrTwo.image = [UIImage imageNamed:@"3-2"];
    }
    return _thrTwo;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initGuide];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(LeftAction)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(RightAction)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
}

- (void)LeftAction{
    CATransition *animation = [CATransition animation];
    animation.duration = 2.0f;
    [animation setType:kCATransitionFade];
    //  [animation setSubtype:kCATransitionFromBottom];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    GuideFourViewController *guide = [[GuideFourViewController alloc] init];
    [self presentModalViewController:guide animated:NO];
    [self.view.window.layer addAnimation:animation forKey:nil];
    
    
}

- (void)RightAction{
    CATransition *animation = [CATransition animation];
    animation.duration = 2.0f;
    [animation setType:kCATransitionFade];
    //  [animation setSubtype:kCATransitionFromBottom];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    GuideTwoViewController *guide = [[GuideTwoViewController alloc] init];
    [self presentModalViewController:guide animated:NO];
    [self.view.window.layer addAnimation:animation forKey:nil];
}



- (void)initGuide{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image_x, image_y)];
    
    imageView.image = [UIImage imageNamed:@"endview"];
    UIImageView *top = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, image_x/7*4, image_y*2/10)];
    top.image = [UIImage imageNamed:@"toplogo"];
    [imageView addSubview:top];
    [imageView addSubview:self.thrOne];
    [imageView addSubview:self.thrTwo];
    
    
    [self.view addSubview:imageView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    
    [self.thrTwo.layer addAnimation:[self opacityForver_Animation:2.0f] forKey:nil];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (CABasicAnimation *)opacityForver_Animation:(float)time
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.0f];
    animation.autoreverses = YES;
    animation.duration = time;
    animation.repeatCount = 1;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    return animation;
}



@end
