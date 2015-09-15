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
#import "XWAllViewController.h"
#import "XWVideoViewController.h"
#import "XWVoiceViewController.h"
#import "XWPictureViewController.h"
#import "XWWordViewController.h"

@interface XWEssenceController () <UIScrollViewDelegate>

/**主控制器UIScrollView*/
@property (nonatomic,strong) UIScrollView *scrollView;

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
    
    [self setupChildVcs];
    
    [self setupScrollView];
    
    [self setupTitleToolBar];
}

#pragma mark - 添加子控制器
- (void)setupChildVcs
{
    XWAllViewController *all = [[XWAllViewController alloc]init];
    all.title = @"全部";
    [self addChildViewController:all];
    all.view.backgroundColor = XWRandomColor;
    
    XWVideoViewController *video = [[XWVideoViewController alloc]init];
    video.title = @"视频";
    [self addChildViewController:video];
    video.view.backgroundColor = XWRandomColor;
    
    XWVoiceViewController *voice = [[XWVoiceViewController alloc]init];
    voice.title = @"声音";
    [self addChildViewController:voice];
    voice.view.backgroundColor = XWRandomColor;
    
    XWPictureViewController *picture = [[XWPictureViewController alloc]init];
    picture.title = @"图片";
    [self addChildViewController:picture];
    picture.view.backgroundColor = XWRandomColor;
    
    XWWordViewController *word = [[XWWordViewController alloc]init];
    word.title = @"文字";
    [self addChildViewController:word];
    word.view.backgroundColor = XWRandomColor;
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
    NSInteger count = self.childViewControllers.count;
    
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
        [titleButton setTitle:[self.childViewControllers[index] title] forState:UIControlStateNormal];
    }
    
    //设置标签栏底部的红色横线
    UIView *titleBottomView = [[UIView alloc]init];
    
    titleBottomView.height = 2;
    titleBottomView.y = titleView.height - titleBottomView.height;
    titleBottomView.backgroundColor = [UIColor redColor];
    [titleView addSubview:titleBottomView];
    self.titleBottomView = titleBottomView;
    
    //设置第一个按钮默认选中状态
    XWTitleButton *firstTitleButton = [self.arrTitleButtons firstObject];

    [firstTitleButton.titleLabel sizeToFit];

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

#pragma mark - 设置主控制器相关
- (void)setupScrollView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.bounds;
    scrollView.backgroundColor = XWGlobalBg;
    //设置分页效果
    scrollView.pagingEnabled = YES;
    
    //设置最大滚动范围
    scrollView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.width, 0);
    
    //设置代理
    scrollView.delegate = self;
    
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    //默认显示第0个控制器
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

#pragma mark - 点击
- (void)titleButtonClick:(UIButton*)titleButton
{
    //点击文字变色变色
    self.selTitleButton.selected = NO;
    titleButton.selected = YES;
    self.selTitleButton = titleButton;
    
    // 底部控件的位置和尺寸
    [UIView animateWithDuration:0.25 animations:^{
        self.titleBottomView.width = titleButton.titleLabel.width;
        self.titleBottomView.centerX = titleButton.centerX;
    }];
    
    // 让scrollView滚动到对应的位置
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = self.view.width * [self.arrTitleButtons indexOfObject:titleButton];
    [self.scrollView setContentOffset:offset animated:YES];
}

- (void)tagClickEssence
{
    XWRecommendTagsViewController *tag = [[XWRecommendTagsViewController alloc]init];
    
    tag.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:tag animated:YES];
    
}

#pragma mark - <UIScrollViewDelegate>

//通过代码。点击标签栏标题按钮动画结束时调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSLogFunc;
    //取出对应的即将要显示的控制器
    int index = scrollView.contentOffset.x / self.view.width;
    UIViewController *willShowChildVc = self.childViewControllers[index];
    
//    if(willShowChildVc.isViewLoaded) return;
    
    //设置即将要显示控制器view的位置
    willShowChildVc.view.frame = self.scrollView.bounds;
    
    //设置控制器的view为UIScrollView的view
    [self.scrollView addSubview:willShowChildVc.view];
}

//人为拖拽。减速完毕后调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    int index = scrollView.contentOffset.x / self.view.width;
    
    //移动到指定标签
    [self titleButtonClick:self.arrTitleButtons[index]];
}
@end
