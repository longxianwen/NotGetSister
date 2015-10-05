//
//  UIBarButtonItem+XWExtension.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/2.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  顶部导航栏内容设置


@implementation UIBarButtonItem (XWExtension)

/**
 *  创建导航栏顶部图片按钮内容
 *
 *  @param target    目标,self
 *  @param image     默认状态下图片
 *  @param highImage 高亮状态下图片
 *  @param action    点击执行的操作
 *
 *  @return 导航栏顶部图片按钮
 */
+ (instancetype)buttonItemCreate:(id)target andImage: (NSString*)image andHighlightedImage: (NSString*)highImage andAction:(SEL)action
{
    
    UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [itemButton setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [itemButton setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [itemButton sizeToFit];
    [itemButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc]initWithCustomView:itemButton];
}

@end
