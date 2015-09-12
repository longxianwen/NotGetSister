//
//  XWPlaceholderTextView.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/12.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  具有占位文字的UITextView

#import "XWPlaceholderTextView.h"

@implementation XWPlaceholderTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //设置默认字体、颜色
        self.placeholderColor = [UIColor grayColor];
        self.font = [UIFont systemFontOfSize:15];
        
        //监听文本框输入
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:self];

    }
    return self;
}

#pragma mark - 监听文本框输入
- (void)textDidChange:(NSNotification*)notification
{
    [self setNeedsDisplay];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 绘制占位文字
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    //如果有文字就直接返回,不需要画占位文字
    if(self.hasText) return;
    
    //设置占位文字属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    
    attrs[NSForegroundColorAttributeName] = self.placeholderColor;
    attrs[NSFontAttributeName] = self.font;
    
    //画占位文字
    rect.origin.x = 5;
    rect.origin.y = 8;
    rect.size.width -= 2*rect.origin.x;
    [self.placeholder drawInRect:rect withAttributes:attrs];
    
}

#pragma mark - 当用户手动修改属性
- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    //强制刷新
//    [self setNeedsDisplay];
}

-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
}

- (void)setText:(NSString *)text
{
    [super setText:text];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
}

@end
