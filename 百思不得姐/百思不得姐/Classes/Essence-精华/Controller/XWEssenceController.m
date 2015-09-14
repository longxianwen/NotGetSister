//
//  XWEssenceController.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/1.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  精华

#import "XWEssenceController.h"
#import "XWRecommendTagsViewController.h"

@interface XWEssenceController ()

@end

@implementation XWEssenceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupScrollView];
    
    [self setupTitleToolBar];
}

/**
 *  添加顶部标题工具条
 */
- (void)setupTitleToolBar
{
    //设置顶部标题工具条整体
    UIView *titleView = [[UIView alloc]init];
    titleView.frame = CGRectMake(0, XWNavBarMaxY, self.view.width, 35);
    titleView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    [self.view addSubview:titleView];
    
    //为标题工具条添加按钮
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    NSInteger count = titles.count;
    
    CGFloat buttonW = titleView.width / count;
    CGFloat buttonH = titleView.height;
    for(int index = 0; index < count;index++)
    {
        //设置按钮的x,y,w,h
        CGFloat buttonY = 0;
        CGFloat buttonX = index * buttonW;
        
        UIButton *button = [[UIButton alloc]init];
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        button.backgroundColor = XWRandomColor;
        [titleView addSubview:button];
        
        //设置内容
        [button setTitle:titles[index] forState:UIControlStateNormal];
    }
}

/**
 *  导航栏相关
 */
- (void)setupNav
{
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 导航栏左边的内容
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem buttonItemCreate:self andImage:@"MainTagSubIcon" andHighlightedImage:@"MainTagSubIconClick" andAction:@selector(tagClickEssence)];
}

/**
 *  设置显示view
 *  水平滚动
 */
- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.bounds;
    scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:scrollView];
}


- (void)tagClickEssence
{
//    NSLogFunc
    XWRecommendTagsViewController *tag = [[XWRecommendTagsViewController alloc]init];
    
    tag.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:tag animated:YES];
    
}

@end
