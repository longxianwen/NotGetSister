//
//  XWRecommendTagCell.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/6.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//

#import "XWRecommendTagCell.h"

@interface XWRecommendTagCell ()
@property (weak, nonatomic) IBOutlet UIImageView *tagImage_list;
@property (weak, nonatomic) IBOutlet UILabel *tagTheme_name;
@property (weak, nonatomic) IBOutlet UILabel *tagSub_number;

@end

@implementation XWRecommendTagCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


//设置数据
- (void)setRecommendTag:(XWRecommendTag *)recommendTag
{
    _recommendTag = recommendTag;
    
    //标签图片--圆形
    [self.tagImage_list setHeaderImage:recommendTag.image_list];
    
    //标签名称
    self.tagTheme_name.text = recommendTag.theme_name;
    
    //订阅量
    NSInteger sub_number = [recommendTag.sub_number intValue];
    if([recommendTag.sub_number intValue] >= 10000)
    {
        self.tagSub_number.text = [NSString stringWithFormat:@"%.2f万人订阅",sub_number / 10000.0];
    } else
    {
        self.tagSub_number.text = recommendTag.sub_number;
    }
}

//通过更改cell高度设置分隔线
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    
    //实现两边间距
//    frame.origin.x += 5;
//    frame.size.width -= 10;
    
    [super setFrame:frame];
}


@end
