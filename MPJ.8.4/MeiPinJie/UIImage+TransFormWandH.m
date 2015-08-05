//
//  UIImage+TransFormWandH.m
//  MeiPinJie
//
//  Created by mac on 15/7/24.
//  Copyright (c) 2015年 Alex. All rights reserved.
//

#import "UIImage+TransFormWandH.h"

@implementation UIImage (TransFormWandH)
- (UIImage*)transformWidth:(CGFloat)width
                    height:(CGFloat)height {

    CGFloat destW = width;
    CGFloat destH = height;
    CGFloat sourceW = width;
    CGFloat sourceH = height;

    CGImageRef imageRef = self.CGImage;
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                destW,
                                                destH,
                                                CGImageGetBitsPerComponent(imageRef),
                                                4*destW,
                                                CGImageGetColorSpace(imageRef),
                                                (kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst));
    
    CGContextDrawImage(bitmap, CGRectMake(0, 0, sourceW, sourceH), imageRef);
    
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage *resultImage = [UIImage imageWithCGImage:ref];
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    
    return resultImage;
}
@end
