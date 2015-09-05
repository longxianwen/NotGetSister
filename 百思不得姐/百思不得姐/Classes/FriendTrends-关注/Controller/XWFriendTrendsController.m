//
//  XWFriendTrendsController.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/1.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  关注

#import "XWFriendTrendsController.h"
#import "UIBarButtonItem+XWExtension.h"
#import "XWLoginRegisterViewController.h"

@interface XWFriendTrendsController ()

@end

@implementation XWFriendTrendsController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的关注";
    
    
    UIBarButtonItem *leftButton = [UIBarButtonItem buttonItemCreate:self andImage:@"friendsRecommentIcon" andHighlightedImage:@"friendsRecommentIcon-click" andAction:@selector(tagClickFriendTrends)];
    
    self.navigationItem.leftBarButtonItem = leftButton;
}

/**
 *  立即登录注册
 *
 *  @param sender 登录/注册按钮
 */
- (IBAction)clickRegisterLogin:(UIButton *)sender {
//    XWLog(@"%s",__func__);
    
    //跳转到注册登录页面
    XWLoginRegisterViewController *loginRegister = [[XWLoginRegisterViewController alloc]init];
    
    [self presentViewController:loginRegister animated:YES completion:nil];
}
/**
 * 左上角按钮点击
 */
- (void)tagClickFriendTrends
{
    NSLogFunc;
}

@end
