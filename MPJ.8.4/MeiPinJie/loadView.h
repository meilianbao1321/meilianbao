//
//  loadView.h
//  MeiPinJie
//
//  Created by mac on 15/6/29.
//  Copyright (c) 2015年 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface loadView : UIView{

}
@property (nonatomic,strong)     UIImageView * loadAV;

-(void)startLoad;
-(void)stopLoad;
@end
