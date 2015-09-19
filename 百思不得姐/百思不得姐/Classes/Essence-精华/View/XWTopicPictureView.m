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
}

//拦截设置中间图片内容方法,下载图片
- (void)setTopic:(XWTopic *)topic
{
    //下载图片
    
    XWWeakSelf;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.image1] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        //进度条设置
        weakSelf.progressView.hidden = NO;
        weakSelf.progressView.progress = receivedSize * 1.0 / expectedSize;
        weakSelf.progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%", weakSelf.progressView.progress * 100];
        weakSelf.progressView.progressLabel.textColor = [UIColor whiteColor];
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
- (IBAction)checkAllImageClick:(id)sender {
    XWLog(@"点击查看全图");
}

@end
