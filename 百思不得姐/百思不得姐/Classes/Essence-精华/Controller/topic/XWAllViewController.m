//
//  XWAllViewController.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/15.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  全部

#import "XWAllViewController.h"

@implementation XWAllViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.type = 2;
    
    [self.view addSubview:[[UISwitch alloc]init]];
}

@end
