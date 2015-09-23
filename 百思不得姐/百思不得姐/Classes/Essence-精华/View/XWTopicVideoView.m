//
//  XWTopicVideoView.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/22.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  视频中间内容

#import "XWTopicVideoView.h"
#import "XWTopic.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface XWTopicVideoView ()

/**  图片内容*/
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

/**  播放按钮*/
@property (weak, nonatomic) IBOutlet UIButton *playButton;

/**  播放次数*/
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;

/**  播放时间*/
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;

@end

@implementation XWTopicVideoView

- (void)awakeFromNib
{
    // 清空自动伸缩属性
    self.autoresizingMask = UIViewAutoresizingNone;
}

//拦截设置中间视频内容方法
- (void)setTopic:(XWTopic *)topic
{
    
    _topic = topic;
    
    //设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    
    NSString  *playCountStr = nil;
    //设置播放次数
    if(topic.playcount >=10000)
    {
        playCountStr = [NSString stringWithFormat:@"%.1f万播放",topic.playcount / 10000.0];
    } else if (topic.playcount > 0)
    {
        playCountStr = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    }
    
    self.playCountLabel.text = playCountStr;
    
    //设置播放时间
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    // %02zd ：显示这个数字需要占据2位空间，不足的空间用0替补
    self.videoTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
}

@end
