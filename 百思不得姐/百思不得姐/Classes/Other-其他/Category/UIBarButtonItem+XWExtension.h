//
//  UIBarButtonItem+XWExtension.h
//  百思不得姐
//
//  Created by longxianwen on 15/9/2.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (XWExtension)

/**
 *  创建导航栏顶部内容
 *
 *  @param target    导航控制器
 *  @param image     普通状态下图片
 *  @param highImage 高亮状态下图片
 *  @param action    调用方法
 *
 *  @return UIBarButtonItem
 */
+ (instancetype)buttonItemCreate:(id)target andImage: (NSString*)image andHighlightedImage: (NSString*)highImage andAction:(SEL)action;
@end
