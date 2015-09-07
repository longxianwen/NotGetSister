//
//  UIImage+XWExtension.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/7.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  UIImage扩展

#import "UIImage+XWExtension.h"

@implementation UIImage (XWExtension)

/**
 *  通过绘画获得圆形图片
 */
- (instancetype)circleImage
{
    // 开启图形上下文
    UIGraphicsBeginImageContext(self.size);
    
    // 获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 矩形框
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    // 添加一个圆
    CGContextAddEllipseInRect(ctx, rect);
    
    // 裁剪(裁剪成刚才添加的图形形状)
    CGContextClip(ctx);
    
    // 往圆上面画一张图片
    [self drawInRect:rect];
    
    // 获得上下文中的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    
    return  newImage;
}

/**
 *  通过给定图片的名字获得一张圆形图片
 *
 *  @param name 图片的名称
 *
 *  @return 圆形图片
 */
+ (instancetype)circleImageWithName:(NSString *)name
{
    return [[self imageNamed:name] circleImage];
}

@end
