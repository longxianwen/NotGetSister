//
//  XWQuickLoginButton.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/5.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  快速登录按钮

#import "XWQuickLoginButton.h"
#import "UIView+XWExtension.h"

@implementation XWQuickLoginButton

- (void)awakeFromNib
{
    //按钮文字居中对齐
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //布局子控件,将按钮文字位于图片的下方
    //调整按钮图片
    self.imageView.y = 0;
    self.imageView.centerX = self.width * 0.5;
//    self.imageView.x = (self.width - self.imageView.width) * 0.5;
    
    //调整按钮文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
    
}

@end
