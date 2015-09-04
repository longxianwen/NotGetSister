//
//  XWNavigationController.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/3.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  导航控制器

#import "XWNavigationController.h"

@interface XWNavigationController ()

@end

@implementation XWNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/**
 *  拦截所有push进来的控制器
 *  重写的父类方法
 *  @param viewController 控制器
 *  @param animated       是否需要动画
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [self addBackItem:viewController];
    [super pushViewController:viewController animated:animated];
//    XWLog(@"%@,%@,%zd",viewController,self.childViewControllers,self.childViewControllers.count);
}

/**
 *  为顶部导航栏添加左边内容
 *
 *  @param viewController push进来的导航控制器
 */
- (void) addBackItem:(UIViewController *)viewController
{
    //为导航控制器子控制器添加返回按钮
    if(self.childViewControllers.count >= 1)
    {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [backButton sizeToFit];
        [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
}

+ (void)initialize
{
    //设置背景图片
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
}

/**
 *  返回到上一个控制器
 */
- (void)back
{
    [self popViewControllerAnimated:YES];
}

//统一修改push进去控制器状态栏颜色
//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}

@end
