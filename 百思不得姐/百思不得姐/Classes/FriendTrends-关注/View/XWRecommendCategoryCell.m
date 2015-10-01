//
//  XWRecommendCategoryCell.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/5.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  推荐关注--左边类别cell

#import "XWRecommendCategoryCell.h"
#import "XWCategoryModel.h"

@interface XWRecommendCategoryCell ()
/**右边竖条指示器*/
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;

@end

@implementation XWRecommendCategoryCell

- (void)awakeFromNib {
    // 清除文字背景色（这样就不会挡住分割线）
    self.textLabel.backgroundColor = [UIColor clearColor];
}

/**
 * 这个方法可以用来监听cell的选中和取消选中
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    self.textLabel.textColor = selected?[UIColor redColor]:[UIColor grayColor];
    self.selectedIndicator.hidden = !selected;
}

//设置数据
- (void)setCategory:(XWCategoryModel *)category
{
    _category = category;
    
    // 设置文字
    self.textLabel.text = category.name;
}

@end
