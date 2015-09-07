//
//  UIImage+XWExtension.h
//  百思不得姐
//
//  Created by longxianwen on 15/9/7.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XWExtension)

#pragma mark -m 获得一个圆形图片
- (instancetype)circleImage;

#pragma mark -m 通过给定图片的名字获得一张圆形图片
+ (instancetype)circleImageWithName:(NSString *)name;
@end
