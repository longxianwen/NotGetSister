//
//  XWEssenceController.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/1.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  精华

#import "XWEssenceController.h"
#import "XWRecommendTagsViewController.h"
#import "XWTitleButton.h"

@interface XWEssenceController ()

/**当前选中按钮*/
@property (nonatomic,weak) UIButton *selTitleButton;

/**存储标签栏按钮*/
@property (nonatomic,strong) NSMutableArray *arrTitleButtons;

/** 标题栏底部的指示器 */
@property (nonatomic, weak) UIView *titleBottomView;

@end

@implementation XWEssenceController

/**
 *  懒加载
 *
 *  @return self
 */
- (NSMutableArray *)arrTitleButtons
{
    if (!_arrTitleButtons) {
        _arrTitleButtons = [NSMutableArray array];
    }
    return _arrTitleButtons;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupScrollView];
    
    [self setupTitleToolBar];
}


#pragma mark - 添加顶部标题工具条
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
        
        XWTitleButton *titleButton = [[XWTitleButton alloc]init];
        titleButton.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        //监听按钮点击
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:titleButton];
        [self.arrTitleButtons addObject:titleButton];
        
        //设置内容
        [titleButton setTitle:titles[index] forState:UIControlStateNormal];
    }
    
    //设置标签栏底部的红色横线
    UIView *titleBottomView = [[UIView alloc]init];
    
    //不直接用frame设置尺寸应为x值和宽度不确定
    titleBottomView.height = 2;
    titleBottomView.y = titleView.height - titleBottomView.height;
    titleBottomView.backgroundColor = [UIColor redColor];
    [titleView addSubview:titleBottomView];
    
    //强引用
    //解决：刚开始有底部横线，后面没有的问题。(因为底部横线控件死了)
    self.titleBottomView = titleBottomView;
    
    //设置第一个按钮默认选中状态
    XWTitleButton *firstTitleButton = [self.arrTitleButtons firstObject];
    
    //解决:刚开始底部横线不显示问题,这是按钮内部文字宽度苹果内部还没处理完。
    //sizeToFit告诉苹果立刻计算
    [firstTitleButton.titleLabel sizeToFit];

    //解决:底部横线慢慢变大问题
    titleBottomView.width = firstTitleButton.titleLabel.width;
    titleBottomView.centerX = firstTitleButton.centerX;
    [self titleButtonClick:firstTitleButton];
    
}

#pragma mark - 导航栏相关
- (void)setupNav
{
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 导航栏左边的内容
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem buttonItemCreate:self andImage:@"MainTagSubIcon" andHighlightedImage:@"MainTagSubIconClick" andAction:@selector(tagClickEssence)];
}

#pragma mark - 设置显示view
- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.bounds;
    scrollView.backgroundColor = XWGlobalBg;
    [self.view addSubview:scrollView];
}

#pragma mark - 点击
- (void)titleButtonClick:(UIButton*)titleButton
{
    //点击文字变色变色
    self.selTitleButton.selected = NO;
    titleButton.selected = YES;
    self.selTitleButton = titleButton;
    
    XWLog(@"%f",titleButton.titleLabel.width);
    
    // 底部控件的位置和尺寸
    [UIView animateWithDuration:0.25 animations:^{
        self.titleBottomView.width = titleButton.titleLabel.width;
        self.titleBottomView.centerX = titleButton.centerX;
    }];
}


- (void)tagClickEssence
{
//    NSLogFunc
    XWRecommendTagsViewController *tag = [[XWRecommendTagsViewController alloc]init];
    
    tag.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:tag animated:YES];
    
}

@end
