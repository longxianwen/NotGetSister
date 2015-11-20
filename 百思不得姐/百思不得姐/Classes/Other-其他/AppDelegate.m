//
//  AppDelegate.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/1.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//

#import "AppDelegate.h"
#import "XWTabBarController.h"
#import "XWWindowRootController.h"

@interface AppDelegate ()

/**顶部窗口*/
@property (nonatomic,strong) UIWindow *topWindow;

@end

@implementation AppDelegate

 //添加顶部状态栏窗口
- (UIWindow *)topWindow
{
    if(!_topWindow)
    {
        UIWindow *win = [[UIWindow alloc]init];
        win.frame = CGRectMake(0, 0, XWScreenW, 20);
        
        XWWindowRootController *con = [[XWWindowRootController alloc]init];
        
        win.rootViewController = con;
        win.windowLevel = UIWindowLevelAlert;
        win.hidden = NO;
        win.backgroundColor = [UIColor clearColor];
        
        [win addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(topWindowClick)]];
        _topWindow = win;
    }
    return _topWindow;
}

- (void)topWindowClick
{
    //如何点击顶部，就让窗口返回顶部呢?
    
    // 取出所有的window
    NSArray *windows = [UIApplication sharedApplication].windows;
    
    // 遍历程序中的所有控件
    for (UIWindow *window in windows) {
        [self searchSubviews:window];
    }
}

/**
 * 搜索superview内部的所有子控件
 */
- (void)searchSubviews:(UIView *)superview
{
    for (UIScrollView *scrollView in superview.subviews) {
        [self searchSubviews:scrollView];
        
        // 判断是否为scrollView
        if (![scrollView isKindOfClass:[UIScrollView class]]) continue;
        
        // 计算出scrollView在window坐标系上的矩形框
        CGRect scrollViewRect = [scrollView convertRect:scrollView.bounds toView:scrollView.window];
        CGRect windowRect = scrollView.window.bounds;
        
        XWLog(@"%@,%@",NSStringFromCGRect(scrollViewRect),NSStringFromCGRect(windowRect));
        
        XWLog(@"是否交叉---%d",CGRectIntersectsRect(scrollViewRect, windowRect));
        
        // 判断scrollView的边框是否和window的边框交叉
        if (!CGRectIntersectsRect(scrollViewRect, windowRect)) continue;
        
        // 让scrollView滚动到最前面
        CGPoint offset = scrollView.contentOffset;
        // 偏移量不一定是0
        offset.y = - scrollView.contentInset.top;
        [scrollView setContentOffset:offset animated:YES];
        
    }
}

#pragma mark - 程序的生命周期
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //1.添加窗口
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    //2.设置根控制器
    self.window.rootViewController = [[XWTabBarController alloc]init];
    
    //3.显示窗口
    [self.window makeKeyAndVisible];
    
//    XWLog(@"%f",self.window.windowLevel);
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

/**
 * 程序激活的时候调用一次
 */
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    // 显示顶部window
    //Application windows are expected to have a root view controller at the end of application launch，可以去除这个错误
    //因为到这里程序已经显示完毕，主窗口也已经加载好了
    [self topWindow];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
