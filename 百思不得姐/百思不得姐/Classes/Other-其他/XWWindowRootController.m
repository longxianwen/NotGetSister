//
//  XWWindowRootController.m
//  百思不得姐
//
//  Created by longxianwen on 15/10/8.
//  Copyright © 2015年 longxianwen. All rights reserved.
//

#import "XWWindowRootController.h"

@interface XWWindowRootController ()

@end

@implementation XWWindowRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//显示状态栏,ios9之后默认是隐藏的
- (BOOL)prefersStatusBarHidden
{
    return NO;
}

@end
