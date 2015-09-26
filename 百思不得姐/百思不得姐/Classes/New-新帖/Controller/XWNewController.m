//
//  XWNewController.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/1.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  新帖

#import "XWNewController.h"
#import "UIBarButtonItem+XWExtension.h"

@interface XWNewController ()

@end

@implementation XWNewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //设置左边按钮
    UIBarButtonItem *leftButton = [UIBarButtonItem buttonItemCreate:self andImage:@"MainTagSubIcon" andHighlightedImage:@"MainTagSubIconClick" andAction:@selector(tagClickNew)];
    
    self.navigationItem.leftBarButtonItem = leftButton;
    
//    UIScrollView *scrollView = [[UIScrollView alloc]init];
//    scrollView.frame = self.view.bounds;
//    scrollView.backgroundColor = XWGlobalBg;
//    
//    [self.view addSubview:scrollView];
    
    self.view.backgroundColor = [UIColor redColor];
}

/**
 * 左上角按钮点击
 */
- (void)tagClickNew
{
    NSLogFunc;
}


@end
