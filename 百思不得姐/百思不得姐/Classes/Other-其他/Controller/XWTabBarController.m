//
//  XWTabBarController.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/1.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//

#import "XWTabBarController.h"
#import "XWEssenceController.h"
#import "XWFriendTrendsController.h"
#import "XWMeController.h"
#import "XWNewController.h"
#import "XWTabBar.h"
#import "XWNavigationController.h"

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
    
    //处理tabBar
    [self setupTabBar];
    
}

/**
 *  处理tabBar
 */
- (void)setupTabBar
{
    //用kvc的方式将系统的tabbar换成我们自定义的
    [self setValue:[[XWTabBar alloc]init] forKeyPath:@"tabBar"];

}

/**
 添加所有的子控制器
 */
- (void)addChildViews
{
    
    [self addChildViewVC:[[XWEssenceController alloc]init] andTitle:@"精华" andImage:@"tabBar_essence_icon" andSelectImage:@"tabBar_essence_click_icon"];
    
    [self addChildViewVC:[[XWNewController alloc]init] andTitle:@"新帖" andImage:@"tabBar_new_icon" andSelectImage:@"tabBar_new_click_icon"];
    
    [self addChildViewVC:[[XWFriendTrendsController alloc]init] andTitle:@"关注" andImage:@"tabBar_friendTrends_icon" andSelectImage:@"tabBar_friendTrends_click_icon"];
    
    [self addChildViewVC:[[XWMeController alloc]init] andTitle:@"我" andImage:@"tabBar_me_icon" andSelectImage:@"tabBar_me_click_icon"];
}

/**
 添加一个子控制器
 */
- (void)addChildViewVC:(UIViewController *) vc andTitle: (NSString *)title andImage:(NSString *)image andSelectImage:(NSString*)selectedImage
{
    XWNavigationController *nav = [[XWNavigationController alloc]initWithRootViewController:vc];
    
    vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
    
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    //设置选中状态下图片
    nav.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    [self addChildViewController:nav];
    
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
