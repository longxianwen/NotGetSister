//
//  XWPostWordToolbar.m
//  百思不得姐
//
//  Created by longxianwen on 15/10/4.
//  Copyright © 2015年 longxianwen. All rights reserved.
//  发表文字页面--自定义底部工具条

#import "XWPostWordToolbar.h"
#import "XWAddTagViewController.h"
#import "XWNavigationController.h"

@interface XWPostWordToolbar ()

@property (weak, nonatomic) IBOutlet UIView *topView;

@end

@implementation XWPostWordToolbar

- (void)awakeFromNib
{
    //添加标签按钮
    UIButton *addbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [addbutton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    
    //自动计算尺寸
    //sizeToFit生效，必须要先有内容
    [addbutton sizeToFit];
    
    //监听事件
    [addbutton addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.topView addSubview:addbutton];
}


//添加标签
- (void)addClick
{
    XWAddTagViewController *addTag = [[XWAddTagViewController alloc]init];
    
    XWNavigationController *nav = [[XWNavigationController alloc]initWithRootViewController:addTag];
    
    //根据源控制器拿到曾经modal出来的目标控制器(当前显示的发表文字控制器)
    UIViewController *vc = self.window.rootViewController.presentedViewController;
    
    //modal出添加标签控制器。
    [vc presentViewController:nav animated:YES completion:nil];
}

@end
