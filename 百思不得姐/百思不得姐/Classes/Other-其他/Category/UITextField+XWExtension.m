//
//  UITextField+XWExtension.m
//  百思不得姐
//
//  Created by longxianwen on 15/10/5.
//  Copyright © 2015年 longxianwen. All rights reserved.
//

#import "UITextField+XWExtension.h"
/** 占位文字颜色 */
static NSString * const XWPlaceholderColorKey = @"placeholderLabel.textColor";

@implementation UITextField (XWExtension)

- (UIColor *)placeholderColor
{
    return [self valueForKeyPath:XWPlaceholderColorKey];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    //标志
    BOOL change = NO;
    
    //设置占位文字颜色
    if(self.placeholder == nil)
    {
        self.placeholder = @" ";
        change = YES;
    }
    [self setValue:placeholderColor forKeyPath:XWPlaceholderColorKey];
    
    //恢复原状
    if(change)
    {
        self.placeholder = nil;
    }
}

@end
