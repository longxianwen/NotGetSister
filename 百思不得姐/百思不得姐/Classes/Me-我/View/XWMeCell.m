//
//  XWMeCell.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/8.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  我--自定义cell

#import "XWMeCell.h"

@implementation XWMeCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        //设置文字颜色
        self.textLabel.textColor = [UIColor darkGrayColor];
        
        //设置cell辅助视图
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        //设置背景图片
        self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
        
        //设置cell选中效果
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if(self.imageView.image == nil) return;
    
    //调整图片位置
    self.imageView.y = XWCommMargin * 0.5;
    self.imageView.height = self.height - 2 * self.imageView.y;
    self.imageView.width = self.imageView.height;

    //调整文字的位置
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + XWCommMargin;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//以下方式不能完美解决需求,footView不会想上移动25
/*
- (void)setFrame:(CGRect)frame
{
    frame.origin.y -= 25;
    return [super setFrame:frame];
}
 */

@end
