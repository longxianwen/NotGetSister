//
//  XWMeController.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/1.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  我

#import "XWMeController.h"
#import "UIBarButtonItem+XWExtension.h"
#import "XWSettingTableController.h"

@interface XWMeController ()

@end

@implementation XWMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的";
    
    //设置右边两个按钮
    
    UIBarButtonItem *settingsItem = [UIBarButtonItem buttonItemCreate:self andImage:@"mine-setting-icon" andHighlightedImage:@"mine-setting-icon-click" andAction:@selector(tagClickSetting)];
    
    UIBarButtonItem *moonItem = [UIBarButtonItem buttonItemCreate:self andImage:@"mine-moon-icon" andHighlightedImage:@"mine-moon-icon-click" andAction:@selector(tagClickMoon)];
    
    
    self.navigationItem.rightBarButtonItems = @[settingsItem,moonItem];
    
    
}

- (void)tagClickSetting
{
    NSLogFunc
    
    //跳入到设置界面
    XWSettingTableController *settigs = [[XWSettingTableController alloc]init];
    
    settigs.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:settigs animated:YES];
    
}

- (void)tagClickMoon
{
    NSLogFunc
}

@end
