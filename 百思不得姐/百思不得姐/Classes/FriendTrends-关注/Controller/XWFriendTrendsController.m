//
//  XWFriendTrendsController.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/1.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//

#import "XWFriendTrendsController.h"
#import "UIBarButtonItem+XWExtension.h"

@interface XWFriendTrendsController ()

@end

@implementation XWFriendTrendsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //问题三:点击我的关注时,这个item会跑到最后面
//    self.title = @"我的关注";
    //是否为系统自动刷新了tabbar?然后重新布局？
    self.navigationItem.title = @"我的关注";
    
    
    UIBarButtonItem *leftButton = [UIBarButtonItem buttonItemCreate:self andImage:@"friendsRecommentIcon" andHighlightedImage:@"friendsRecommentIcon-click" andAction:@selector(tagClickFriendTrends)];
    
    self.navigationItem.leftBarButtonItem = leftButton;
}

/**
 * 左上角按钮点击
 */
- (void)tagClickFriendTrends
{
    NSLogFunc;
}

@end
