//
//  XWLoginRegisterViewController.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/4.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//

#import "XWLoginRegisterViewController.h"

@interface XWLoginRegisterViewController ()

@end

@implementation XWLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma  mark -m 关闭注册登录
- (IBAction)closeRegisterLogin:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
