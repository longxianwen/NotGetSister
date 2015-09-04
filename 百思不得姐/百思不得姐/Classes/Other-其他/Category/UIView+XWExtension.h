//
//  UIView+XWExtension.h
//  百思不得姐
//
//  Created by longxianwen on 15/9/5.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XWExtension)

/**
 *  设置控件x坐标的值
 */
- (void)setX:(CGFloat)x;

/**
 *  获得控件x坐标的值
 */
- (CGFloat)x;

/**
 *  设置控件y坐标的值
 */
- (void)setY:(CGFloat)y;

/**
 *  获得控件y坐标的值
 */
- (CGFloat)y;

/**
 *  设置控件width的值(宽度)
 */
- (void)setWidth:(CGFloat)width;

/**
 *  获得控件width的值(宽度)
 */
- (CGFloat)width;

/**
 *  设置控件height的值(宽度)
 */
- (void)setHeight:(CGFloat)height;

/**
 *  获得控件height的值(高度)
 */
- (CGFloat)height;

/**
 *  设置控件的中心点x的值
 */
- (void)setCenterX:(CGFloat)centerX;

/**
 *  获得控件的中心点x的值
 */
- (CGFloat)centerX;

/**
 *  设置控件的中心点y的值
 */
- (void)setCenterY:(CGFloat)centerY;

/**
 *  获得控件的中心点y的值
 */
- (CGFloat)centerY;

@end
