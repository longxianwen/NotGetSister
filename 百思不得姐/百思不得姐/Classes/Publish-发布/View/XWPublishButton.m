//
//  XWPublishButton.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/12.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  发布按钮

#import "XWPublishButton.h"

@implementation XWPublishButton

- (void)awakeFromNib
{
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        //设置文字属性
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //调整图片位置
    self.imageView.centerX = self.width * 0.5;
    self.imageView.y = 0;
   
    //调整文字位置
    self.titleLabel.width = self.width;
    self.titleLabel.x= 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    //UITextField默认会居中显示
    self.titleLabel.height = self.height - CGRectGetMaxY(self.imageView.frame);
}

@end
