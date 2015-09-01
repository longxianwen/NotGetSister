//
//  XWTabBarController.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/1.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//

#import "XWTabBarController.h"

@interface XWTabBarController ()

@end

@implementation XWTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //添加子控件
    [self addChildViews];
    
    //设置item属性
    [self setItems];
}

/**
 添加子控件
 */
- (void)addChildViews
{
    //设置底部4个tabBarItem
    UIViewController *vc1 = [[UIViewController alloc]init];
    vc1.view.backgroundColor = [UIColor greenColor];
    vc1.tabBarItem.title = @"精华";
    vc1.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    //设置选中状态下图片
    vc1.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_essence_click_icon"];
    [self addChildViewController:vc1];
    
    
    UIViewController *vc2 = [[UIViewController alloc]init];
    vc2.view.backgroundColor = [UIColor blueColor];
    vc2.tabBarItem.title = @"新帖";
    vc2.tabBarItem.image = [[UIImage imageNamed:@"tabBar_new_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc2.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_new_click_icon"];
    [self addChildViewController:vc2];
    
    UIViewController *vc3 = [[UIViewController alloc]init];
    vc3.view.backgroundColor = [UIColor purpleColor];
    vc3.tabBarItem.title = @"关注";
    vc3.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    vc3.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_friendTrends_click_icon"];
    [self addChildViewController:vc3];
    
    UIViewController *vc4 = [[UIViewController alloc]init];
    vc4.view.backgroundColor = [UIColor grayColor];
    vc4.tabBarItem.title = @"我";
    vc4.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    vc4.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_me_click_icon"];
    [self addChildViewController:vc4];
}

/**
 *  设置item文字属性
 */
- (void)setItems
{
    //设置文字属性
    NSMutableDictionary *attrsNomal = [NSMutableDictionary dictionary];
    //文字颜色
    attrsNomal[NSForegroundColorAttributeName] = [UIColor grayColor];
    //文字大小
    attrsNomal[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    
    NSMutableDictionary *attrsSelected = [NSMutableDictionary dictionary];
    //文字颜色
    attrsSelected[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    //统一整体设置
    UITabBarItem *item = [UITabBarItem appearance]; //拿到底部的tabBarItem
    [item setTitleTextAttributes:attrsNomal forState:UIControlStateNormal];
    [item setTitleTextAttributes:attrsSelected forState:UIControlStateSelected];
}

@end
