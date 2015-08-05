//
//  ErrorView.m
//  MeiPinJie
//
//  Created by mac on 15/6/29.
//  Copyright (c) 2015年 Alex. All rights reserved.
//

#import "ErrorView.h"

@implementation ErrorView

-(id)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        UIImageView * iv =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"error.png"]];
        iv.frame =CGRectMake((VIEW_WIDH-166)/2, VIEW_HEIGHT/4, 166,130);
        [self addSubview:iv];
        
        self.backgroundColor =UIColorFromRGB(0xF5F4F4);
        
        UILabel *  titleLB =[[UILabel alloc]initWithFrame:CGRectMake((VIEW_WIDH - 150)/2, iv.frame.size.height + iv.frame.origin.y +20, 150, 40)];
        titleLB.text =@"噢，崩溃啦！";
        [titleLB setFont:[UIFont systemFontOfSize:20]];
        [titleLB setTextAlignment:NSTextAlignmentCenter];
        [titleLB setTextColor:UIColorFromRGB(0x666666)];
        [self addSubview:titleLB];
        
        UILabel *  textLB =[[UILabel alloc]initWithFrame:CGRectMake((VIEW_WIDH - 320)/2, titleLB.frame.size.height + titleLB.frame.origin.y +20, 320, 30)];
        textLB.text =@"显示此网页时出现了错误，请检查网络状况是否正常。";
        [textLB setFont:[UIFont systemFontOfSize:13]];
        [textLB setTextAlignment:NSTextAlignmentCenter];
        [textLB setTextColor:UIColorFromRGB(0x626A6E)];
        [self addSubview:textLB];
        
        self.btn =[UIButton buttonWithType:UIButtonTypeCustom];
        [self.btn setTitle:@"点此处刷新" forState:UIControlStateNormal];
        [self.btn setTitleColor:UIColorFromRGB(0xEF2F72) forState:UIControlStateNormal];
        [self.btn.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [self.btn.titleLabel setTextAlignment:NSTextAlignmentCenter];
        self.btn.frame =CGRectMake((VIEW_WIDH - 120)/2, textLB.frame.size.height + textLB.frame.origin.y +20, 120, 35);
        [self.btn.layer setBorderWidth:1.2]; //边框宽度
        [self.btn.layer setCornerRadius:4.0];
        CGColorSpaceRef colorSpace =CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref =CGColorCreate(colorSpace, (CGFloat[]){((0xEF2F72 & 0xFF0000) >> 16)/255.0,((0xEF2F72 & 0xFF00) >> 16)/255.0,((0xEF2F72 & 0xFF) >> 16)/255.0,0.3});
        [self.btn.layer setBorderColor:colorref];
        [self addSubview:self.btn];
    }
    return self;
}

@end
