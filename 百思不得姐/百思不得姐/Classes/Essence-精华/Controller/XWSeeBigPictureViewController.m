//
//  XWSeeBigPictureViewController.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/19.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  查看大图

#import "XWSeeBigPictureViewController.h"
#import "XWTopic.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface XWSeeBigPictureViewController ()<UIScrollViewDelegate>

/** 图片 */
@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation XWSeeBigPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //滚动控件
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.bounds;
    //查看如果没有下面设置背景色语句效果
    scrollView.backgroundColor = [UIColor blackColor];
    [self.view insertSubview:scrollView atIndex:0];
    
    //图片控件
    UIImageView *imageView = [[UIImageView alloc]init];
    
    //下载大图
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.image1]];
    [scrollView addSubview: imageView];
    scrollView.delegate = self;
    self.imageView = imageView;

    
    //设置图片位置
    imageView.x = 0;
    imageView.width = XWScreenW;
    
    //等比拉伸尺寸:根据服务器返回的图片的宽度高度，根据等比例换算成屏幕真实显示的宽度高度
    imageView.height = self.topic.height * imageView.width / self.topic.width;
    
    //设置y值
    if(imageView.height > XWScreenH)
    {
        imageView.y = 0;
        //滚动范围
        scrollView.contentSize = CGSizeMake(0, imageView.height);
    }  else
    {
        imageView.centerY = XWScreenH * 0.5;
    }
    
    //缩放
    //如何做到定点缩放?
    
    //缩放到实际尺寸
    CGFloat maxScale = self.topic.height / imageView.height;
    if (maxScale > 1.0) {
        scrollView.maximumZoomScale = maxScale;
    }
}

#pragma mark - <UIScrollViewDelegate>
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)save:(id)sender {
    NSLogFunc;
}

@end
