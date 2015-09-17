//
//  XWTopicCell.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/18.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  自定义帖子cell(全部，图片，段子，音频，视频)

#import "XWTopicCell.h"

@interface XWTopicCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;

@end

@implementation XWTopicCell

- (void)awakeFromNib {
    // Initialization code
    
    //设置背景图片
    self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTopic:(XWTopic *)topic
{
    _topic = topic;
    
    //设置头像
    [self.profileImageView setHeaderImage:topic.profile_image];
    self.nameLabel.text = topic.name;
    self.createAtLabel.text = topic.created_at;
    self.text_label.text = topic.text;
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.y += XWCommMargin;
    frame.size.height = frame.size.height - XWCommMargin;
    
    [super setFrame:frame];
}

@end
