//
//  XWSquareWebViewController.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/8.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  超链接页面。。

#import "XWSquareWebViewController.h"

@interface XWSquareWebViewController ()

@end

@implementation XWSquareWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSLogFunc;
    
    NSLog(@"%@---%@",self.squareButton.name,self.squareButton.url);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
