//
//  UIView+XWExtension.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/5.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  UIView控件x,y,w,h,centerX,centerY快速获取或者设置

#import "UIView+XWExtension.h"

@implementation UIView (XWExtension)

/**
 *  设置控件x坐标的值
 *
 *  @param x x坐标的位置
 */
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

/**
 *  获得控件x坐标的值
 */
- (CGFloat)x

{
    return self.frame.origin.x;
}

/**
 *  设置控件y坐标的值
 *
 *  @param y y坐标的位置
 */
- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

/**
 *  获得控件y坐标的值
 */
- (CGFloat)y

{
    return self.frame.origin.y;
}

/**
 *  设置控件width的值(宽度)
 *
 *  @param width 控件的宽度
 */
- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

/**
 *  获得控件width的值(宽度)
 */
- (CGFloat)width

{
    return self.frame.size.width;
}

/**
 *  设置控件height的值(宽度)
 *
 *  @param height 控件的高度
 */
- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

/**
 *  获得控件height的值(高度)
 */
- (CGFloat)height

{
    return self.frame.size.height;
}

/**
 *  设置控件的中心点x的值
 *
 *  @param centerX 中心点x的值
 */
- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

/**
 *  获得控件的中心点x的值
 */
- (CGFloat)centerX
{
    return self.center.x;
}

/**
 *  设置控件的中心点y的值
 *
 *  @param centerY 中心点y的值
 */
- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

/**
 *  获得控件的中心点y的值
 */
- (CGFloat)centerY
{
    return self.center.y;
}

@end
