//
//  XWTitleButton.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/15.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  自定义标题按钮

#import "XWTitleButton.h"

@implementation XWTitleButton

//自定义控件初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.backgroundColor = XWRandomColor;
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    }
    return self;
}

//去掉系统高亮
- (void)setHighlighted:(BOOL)highlighted{}

@end
