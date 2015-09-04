//
//  XWTabBar.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/1.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  表格控制器-底部导航条

#import "XWTabBar.h"

@interface XWTabBar ()

@property (nonatomic,weak) UIButton *publishButton;   /**<发布按钮*/

@end

@implementation XWTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        //设置背景图片
        self.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
        
        //添加+号按钮
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [publishButton sizeToFit];
        
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        
        self.publishButton = publishButton;
        
        [self addSubview:self.publishButton];
        
    }
    return self;
}

- (void)publishClick
{
    NSLogFunc
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置发布按钮位置
    self.publishButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    
    //设置索引
    int index = 0;
    
    CGFloat tabBarButtonW = self.frame.size.width / 5;
    CGFloat tabBarButtonH = self.frame.size.height;
    CGFloat tabBarButtonY = 0;
    
    //设置UITabBarButton的位置
    for (UIView *tabBarButton in self.subviews) {
        if([NSStringFromClass([tabBarButton class]) isEqualToString:@"UITabBarButton"])
        {
            //计算x的位置
            CGFloat tabBarButtonX = index * tabBarButtonW;
            
            if(index >=2)
            {
                tabBarButtonX += tabBarButtonW;
            }
            
            //设置系统自带的UITabBarButton的frame
            tabBarButton.frame = CGRectMake(tabBarButtonX, tabBarButtonY, tabBarButtonW, tabBarButtonH);
            
            index++;
        }
    }

}

@end
