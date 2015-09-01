//
//  XWMeController.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/1.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//

#import "XWMeController.h"

@interface XWMeController ()

@end

@implementation XWMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的";
    
    //设置右边两个按钮
    
    UIButton *rightButtonMoon = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButtonMoon setBackgroundImage:[UIImage imageNamed:@"mine-moon-icon"] forState:UIControlStateNormal];
    [rightButtonMoon setBackgroundImage:[UIImage imageNamed:@"mine-moon-icon-click"] forState:UIControlStateHighlighted];
    [rightButtonMoon sizeToFit];
    [rightButtonMoon addTarget:self action:@selector(tagClickMoon) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightButtonSetting = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButtonSetting setBackgroundImage:[UIImage imageNamed:@"mine-setting-icon"] forState:UIControlStateNormal];
    [rightButtonSetting setBackgroundImage:[UIImage imageNamed:@"mine-setting-icon-click"] forState:UIControlStateHighlighted];
    [rightButtonSetting sizeToFit];
    [rightButtonSetting addTarget:self action:@selector(tagClickSetting) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItems = @[
            [[UIBarButtonItem alloc]initWithCustomView:rightButtonSetting],
            [[UIBarButtonItem alloc]initWithCustomView:rightButtonMoon]];
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
