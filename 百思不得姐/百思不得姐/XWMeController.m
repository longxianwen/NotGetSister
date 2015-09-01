//
//  XWMeController.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/1.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//

#import "XWMeController.h"
#import "UIBarButtonItem+XWExtension.h"

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
}

- (void)tagClickMoon
{
    NSLogFunc
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
