//
//  XWTopicContentView.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/26.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//

#import "XWTopicContentView.h"
#import "XWSeeBigPictureViewController.h"

@interface XWTopicContentView ()

@end

@implementation XWTopicContentView

- (void)awakeFromNib
{
    // 清空自动伸缩属性(没有这句图片显示会不正常。而且会报约束错误)
    //原因:会随着父控件的等比拉伸。不是我们计算出来的效果
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.imageView.userInteractionEnabled = YES;
    
    //创建手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClick)];
    //添加手势
    [self.imageView addGestureRecognizer:tap];
}

#pragma mark - 点击查看全图

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
