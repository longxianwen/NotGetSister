//
//  XWTagButton.m
//  百思不得姐
//
//  Created by longxianwen on 15/10/6.
//  Copyright © 2015年 longxianwen. All rights reserved.
//  标签按钮

#import "XWTagButton.h"

@implementation XWTagButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.backgroundColor = XWTagBgColor;
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    //sizeToFit会自动计算出尺寸
    [self sizeToFit];
    
    //微调
    self.height = XWTagH;
    self.width += 3 * XWCommonSmallMargin;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.x = XWCommonSmallMargin;
    
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + XWCommonSmallMargin;
}
@end
