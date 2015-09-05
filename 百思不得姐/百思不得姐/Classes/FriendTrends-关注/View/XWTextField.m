//
//  XWTextField.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/5.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//

#import "XWTextField.h"
#import <objc/runtime.h>

// 占位文字颜色
#define XWPlaceholderColorKey @"placeholderLabel.textColor"
// 默认的占位文字颜色
#define XWPlaceholderDefaultColor [UIColor grayColor]
// 聚焦的占位文字颜色
#define XWPlaceholderFocusColor [UIColor whiteColor]

@interface XWTextField ()

@end

@implementation XWTextField

- (void)awakeFromNib
{
    //设置文本输入框占位光标颜色
    self.tintColor = XWPlaceholderFocusColor;
    
    //设置文本输入框输入文本颜色
    self.textColor = XWPlaceholderFocusColor;
    
    //设置文本输入框占位文本颜色
    [self resignFirstResponder];
}

//切换输入框颜色
/**
 * 文本框聚焦时调用（弹出当前文本框对应的键盘时调用）
 */
- (BOOL)becomeFirstResponder
{
    [self setValue:XWPlaceholderFocusColor forKeyPath:XWPlaceholderColorKey];
    return [super becomeFirstResponder];
}

/**
 * 文本框失去焦点时调用（隐藏当前文本框对应的键盘时调用）
 */
- (BOOL)resignFirstResponder
{
    [self setValue:XWPlaceholderDefaultColor forKeyPath:XWPlaceholderColorKey];
    return [super resignFirstResponder];
}

@end
