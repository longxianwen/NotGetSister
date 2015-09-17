//
//  XWFooterView.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/18.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  MJRefresh自定义上拉刷新控件

#import "XWFooterView.h"

@implementation XWFooterView

- (void)prepare
{
    [super prepare];
    
    UISwitch *mySwitch = [[UISwitch alloc]init];
    mySwitch.on = YES;
    [self addSubview:mySwitch];
}

@end
