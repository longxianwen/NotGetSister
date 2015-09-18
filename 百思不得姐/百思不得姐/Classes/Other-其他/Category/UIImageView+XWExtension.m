//
//  UIImageView+XWImageView.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/7.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  对图片进行封装-获得不同样式的的图片

#import "UIImageView+XWExtension.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (XWExtension)

/**
 *  根据图片的地址的获得对应的图片
 *
 *  @param imageName 图片的地址
 *
 *  @return 对应样式的图片
 */
- (void)setHeaderImage:(NSString *)imageUrl
{
    [self setCircleImage:imageUrl];
}

//圆形图片
- (void)setCircleImage:(NSString *)imageUrl
{
    [self sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if(image == nil) return ;
        
        //设置圆形图片
        self.image = [image circleImage];
        
    }];
}

//方形图片
- (void)setRectImage:(NSString *)imageUrl
{
    [self sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] completed:nil];
}
@end
