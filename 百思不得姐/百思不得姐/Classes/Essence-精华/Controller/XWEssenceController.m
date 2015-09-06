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
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 导航栏左边的内容
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem buttonItemCreate:self andImage:@"MainTagSubIcon" andHighlightedImage:@"MainTagSubIconClick" andAction:@selector(tagClickEssence)];
}

- (void)tagClickEssence
{
//    NSLogFunc
    XWRecommendTagsViewController *tag = [[XWRecommendTagsViewController alloc]init];
    
    tag.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:tag animated:YES];
    
}

@end
