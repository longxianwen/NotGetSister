//
//  XWCommentHeaderFooterView.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/25.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  评论，自定义 UITableView section

#import "XWCommentHeaderFooterView.h"

@interface XWCommentHeaderFooterView ()

/** 内部的label */
@property (nonatomic, strong) UILabel *label;

@end

@implementation XWCommentHeaderFooterView

//可循环利用,跟自定义cell一样
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithReuseIdentifier:reuseIdentifier])
    {
        //设置背景颜色
        self.contentView.backgroundColor = XWGlobalBg;
        
        //label
        self.label = [[UILabel alloc] init];
        self.label.x = XWCommMargin;
        
        //宽度和高度跟随父控件
        self.label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        //[label sizeToFit]; //这句无效，因为到这里还没有文字。。
        self.label.textColor = XWCommColor(120);
        self.label.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.label];
    }
    return self;
}

- (void)setText:(NSString *)text
{
    _text = [text copy];
    self.label.text = _text;
}

@end
