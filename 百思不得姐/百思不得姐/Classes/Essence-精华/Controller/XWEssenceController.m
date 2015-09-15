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
@property (nonatomic,strong) UIButton *selTitleButton;

/**存储标签栏按钮*/
@property (nonatomic,strong) NSMutableArray *arrTitleButtons;

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
    //设置第一个按钮默认选中状态
    XWLog(@"%@",self.arrTitleButtons);
    XWTitleButton *titleButton = [self.arrTitleButtons firstObject];
    [self titleButtonClick:titleButton];
    
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
    scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:scrollView];
}

#pragma mark - 点击
- (void)titleButtonClick:(UIButton*)titleButton
{
    //点击文字变色变色
    self.selTitleButton.selected = NO;
    titleButton.selected = YES;
    self.selTitleButton = titleButton;
    
    XWLog(@"%@",titleButton.titleLabel.text);
}


- (void)tagClickEssence
{
//    NSLogFunc
    XWRecommendTagsViewController *tag = [[XWRecommendTagsViewController alloc]init];
    
    tag.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:tag animated:YES];
    
}

@end
