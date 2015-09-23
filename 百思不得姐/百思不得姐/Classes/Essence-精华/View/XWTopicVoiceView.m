//
//  XWTopicVoiceView.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/22.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  声音中间内容

#import "XWTopicVoiceView.h"
#import "XWTopic.h"
#import "XWSeeBigPictureViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface XWTopicVoiceView ()


/**  图片内容*/
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

/**  播放按钮*/
@property (weak, nonatomic) IBOutlet UIButton *playButton;

/**  播放次数*/
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;

/**  播放时间*/
@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLabel;

@end

@implementation XWTopicVoiceView

- (void)awakeFromNib
{
    // 清空自动伸缩属性
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.imageView.userInteractionEnabled = YES;
    
    //创建手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClick)];
    //添加手势
    [self.imageView addGestureRecognizer:tap];
}

//拦截设置中间声音内容方法
- (void)setTopic:(XWTopic *)topic
{
    
    _topic = topic;
    
    //设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    //设置播放次数
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    
    //设置播放时间
    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    // %02zd ：显示这个数字需要占据2位空间，不足的空间用0替补
    self.voiceTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
}

- (void)imageClick
{
    [self seeBigPicture];
}

- (void)seeBigPicture
{
    if (self.imageView.image == nil) return;
    
    XWSeeBigPictureViewController *seeBigPicture = [[XWSeeBigPictureViewController alloc]init];
    
    seeBigPicture.topic = _topic;
    
    [self.window.rootViewController presentViewController:seeBigPicture animated:YES completion:nil];
}

@end
