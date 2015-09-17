//
//  XWTopicCell.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/18.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  自定义帖子cell(全部，图片，段子，音频，视频)

#import "XWTopicCell.h"

@implementation XWTopicCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTopic:(XWTopic *)topic
{
    _topic = topic;
    
    //设置数据
    self.textLabel.text = topic.name;
    self.detailTextLabel.text = topic.text;
    //设置头像
    [self.imageView setHeaderImage:topic.profile_image] ;
}

@end
