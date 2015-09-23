//
//  XWTopicPictureView.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/19.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  图片中间内容

#import "XWTopicPictureView.h"
#import "XWTopic.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <DALabeledCircularProgressView.h>
#import "XWSeeBigPictureViewController.h"

@interface XWTopicPictureView ()

/**  图片内容*/
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

/**  gif图标*/
@property (weak, nonatomic) IBOutlet UIImageView *gitIconView;
@property (weak, nonatomic) IBOutlet UIButton *checkImageButton;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;

@end
@implementation XWTopicPictureView

- (void)awakeFromNib
{
    // 清空自动伸缩属性
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.imageView.userInteractionEnabled = YES;
    
    self.progressView.roundedCorners = 5;
    self.progressView.progressLabel.textColor = [UIColor whiteColor];
    
    //创建手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClick)];
    //添加手势
    [self.imageView addGestureRecognizer:tap];
}

//拦截设置中间图片内容方法,下载图片
#pragma mark - 下载图片
- (void)setTopic:(XWTopic *)topic
{
    
    _topic = topic;
    
    //下载图片
    XWWeakSelf;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        //进度条设置
        weakSelf.progressView.hidden = NO;
        weakSelf.progressView.progress = receivedSize * 1.0 / expectedSize;
        weakSelf.progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%", weakSelf.progressView.progress * 100];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        weakSelf.progressView.hidden = YES;
    }];
    
    //判断gif
    self.gitIconView.hidden = !topic.is_gif;
    
    //点击查看大图隐藏
    self.checkImageButton.hidden = !topic.isBigPicture;
    
    //如果是大图设置图片模式，显示top部分
    if(topic.isBigPicture)
    {
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
    } else
    {
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = NO;
    }
}

#pragma mark - 点击查看全图

- (void)imageClick
{
    [self seeBigPicture];
}

- (IBAction)checkAllImageClick:(id)sender {
    
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
