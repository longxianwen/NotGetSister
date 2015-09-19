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

@interface XWTopicPictureView ()

/**  图片内容*/
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

/**  gif图标*/
@property (weak, nonatomic) IBOutlet UIImageView *gitIconView;

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
    //根据服务器返回的图片的宽度高度，根据等比例换算成屏幕真实显示的宽度高度
    //下载图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.image1] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        XWLog(@"图片下载成功");
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
}

#pragma mark - 点击查看全图
- (IBAction)checkAllImageClick:(id)sender {
    XWLog(@"点击查看全图");
}

@end
