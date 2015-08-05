//
//  GuideTwoViewController.m
//  MoJing
//
//  Created by mac on 15/7/21.
//  Copyright (c) 2015年 zh. All rights reserved.
//

#import "GuideTwoViewController.h"
#import "UserGuideViewController.h"
#import "GuideThrViewController.h"


#define image_x self.view.frame.size.width
#define image_y self.view.frame.size.height

@interface GuideTwoViewController ()
@property (nonatomic,strong)UIImageView *twoone;
@property (nonatomic,strong)UIImageView *twotwo;
@property (nonatomic,strong)UIImageView *twoThree;
@property (nonatomic,strong)UIImageView *twoFour;
@property (nonatomic,strong)UIImageView *twoFive;
@property (nonatomic,strong)UIImageView *twoSix;


@end


@implementation GuideTwoViewController

- (UIImageView *)twoone{
    if (!_twoone) {
        _twoone = [[UIImageView alloc] init];
     //   _twoone = [[UIImageView alloc] initWithFrame:CGRectMake(image_x/2 - image_x/14*5/2, image_y/3, image_x/14*5, image_x/14*5/2)];
        _twoone.image = [UIImage imageNamed:@"2-1"];
    }
    return _twoone;
}

- (UIImageView *)twotwo{
    if (!_twotwo) {
        _twotwo = [[UIImageView alloc] initWithFrame:CGRectMake(image_x/2 - 15, image_y/3+image_x/14*5/2 +20, 20, 20 )];
        _twotwo.image = [UIImage imageNamed:@"2-2"];
        
    }
    return _twotwo;
}

- (UIImageView *)twoThree{
    if (!_twoThree) {
        _twoThree = [[UIImageView alloc] init];
      //  _twoThree = [[UIImageView alloc] initWithFrame:CGRectMake(image_x/2 - image_x/14*5/2,image_y/3+image_x/14*5/2 +60, image_x/14*5, image_x/14*6/2)];
        _twoThree.image = [UIImage imageNamed:@"2-3"];
    }
    return _twoThree;
}

- (UIImageView *)twoFour{
    if (!_twoFour) {
        _twoFour = [[UIImageView alloc] initWithFrame:CGRectMake(image_x/4, image_y/3+image_x/14*5/2 +60 +image_x/14*8/2, image_x/2, image_x/14*5/2)];
        _twoFour.image = [UIImage imageNamed:@"2-4"];
    }
    return _twoFour;
}

- (UIImageView *)twoFive{
    if (!_twoFive) {
        _twoFive = [[UIImageView alloc] initWithFrame:CGRectMake(0, image_y - 40, image_x, 3)];
        _twoFive.image = [UIImage imageNamed:@"2-5"];
    }
    return _twoFive;
}

- (UIImageView *)twoSix{
    if (!_twoSix) {
        _twoSix = [[UIImageView alloc] initWithFrame:CGRectMake(image_x/4 + 5 , image_y - 47, image_x /2 - 10, 15)];
        _twoSix.image = [UIImage imageNamed:@"2-6"];
    }
    return _twoSix;
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


- (void)initGuide{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image_x, image_y)];
    
    imageView.image = [UIImage imageNamed:@"endview"];
    UIImageView *top = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, image_x/7*4, image_y*2/10)];
    top.image = [UIImage imageNamed:@"toplogo"];
    [imageView addSubview:top];
    
    
    
    
    
    
    
    
    
    
    
    [self.view addSubview:imageView];
    [imageView addSubview:self.twoone];
    [imageView addSubview:self.twotwo];
    [imageView addSubview:self.twoThree];
    [imageView addSubview:self.twoFour];
    [imageView addSubview:self.twoFive];
    [imageView addSubview:self.twoSix];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    UserGuideViewController *guide = [[UserGuideViewController alloc] init];
    [self presentModalViewController:guide animated:NO];
    [self.view.window.layer addAnimation:animation forKey:nil];
}
- (void)viewDidAppear:(BOOL)animated{
    CATransition *animation1 = [CATransition animation];
    animation1.duration = 2.0f;
    [animation1 setType:kCATransitionMoveIn];
    [animation1 setSubtype:kCATransitionFromLeft];
    [animation1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [self.twoone.layer addAnimation:animation1 forKey:nil];
    [self.twoone setFrame: CGRectMake(image_x/2 - image_x/14*5/2, image_y/3, image_x/14*5, image_x/14*5/2)];
    
    CATransition *animation2 = [CATransition animation];
    animation2.duration = 2.0f;
    [animation2 setType:kCATransitionMoveIn];
    [animation2 setSubtype:kCATransitionFromRight];
    [animation2 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [self.twoThree.layer addAnimation:animation2 forKey:nil];
    [self.twoThree setFrame:CGRectMake(image_x/2 - image_x/14*5/2,image_y/3+image_x/14*5/2 +60, image_x/14*5, image_x/14*6/2)];
    
    [UIView beginAnimations:@"cur1UP" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.twoFour cache:YES];
    [UIView commitAnimations];

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
