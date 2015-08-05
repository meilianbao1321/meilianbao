//
//  loadView.m
//  MeiPinJie
//
//  Created by mac on 15/6/29.
//  Copyright (c) 2015年 Alex. All rights reserved.
//

#import "loadView.h"

@implementation loadView{
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    if ( self =[super initWithFrame:frame]) {
        UIImageView * iv =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background.png"]];
        iv.frame =CGRectMake(0, 0, frame.size.width,frame.size.height);
        [self addSubview:iv];
        self.hidden =YES;
         _loadAV =[[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width-170)/2, 150 ,170 , 170)];
        NSMutableArray * avArr =[NSMutableArray array];
        for (NSInteger i=1 ; i<=30; i++) {
            [avArr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%ld.png",(long)i]]];
        }
        _loadAV.animationImages =avArr;
        _loadAV.animationDuration =20;
        _loadAV.animationRepeatCount =10;
        [self addSubview:_loadAV];
        
    }
    return self;
}

-(void)startLoad{
    [_loadAV startAnimating];
    self.hidden =NO;

}
-(void)stopLoad{
    [_loadAV stopAnimating];
    self.hidden =YES;
}
@end
