//
//  XWPlaceholderTextView.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/12.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  具有占位文字的UITextView

#import "XWPlaceholderTextView.h"

@interface XWPlaceholderTextView ()

/**占位文字label*/
@property (nonatomic,weak) UILabel * placeholderLabel;

@end

@implementation XWPlaceholderTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //添加占位文字label
        UILabel *placeholderLabel = [[UILabel alloc]init];
        placeholderLabel.numberOfLines = 0;
        [self addSubview:placeholderLabel];
        self.placeholderLabel = placeholderLabel;
        
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
    self.placeholderLabel.hidden = self.hasText;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 当用户手动修改属性
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //占位文字位置
    self.placeholderLabel.x = 5;
    self.placeholderLabel.y = 8;
    self.placeholderLabel.width =self.width -  2 * self.placeholderLabel.x;
    [self.placeholderLabel sizeToFit];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeholderLabel.font = font;
    [self.placeholderLabel sizeToFit];
    //强制刷新
//    [self setNeedsDisplay];
}

-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    self.placeholderLabel.text = _placeholder;
    [self.placeholderLabel sizeToFit];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    self.placeholderLabel.textColor = placeholderColor;
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    [self textDidChange:nil];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self textDidChange:nil];
}

@end
