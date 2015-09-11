//
//  XWPublishViewController.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/9.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  发布模块

#import "XWPublishViewController.h"

@interface XWPublishViewController ()
/**标题*/
@property (nonatomic,strong) UIImageView *sloganView;
@end

@implementation XWPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //为xib添加按钮子控件
    [self setupButtons];
    //为xib添加标语子控件
    [self setupSloganView];
}

#pragma mark -m xib中间添加子控件按钮
- (void)setupButtons
{
    //数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    //每行有多少个子控件
    NSInteger count = images.count;
    NSInteger maxColsCount = 3;
    //分页公式
    NSInteger maxRowsCount = (count + maxColsCount - 1) / maxColsCount;
    
    //设置按钮的w,h,x,y
    CGFloat bottonW = XWScreenW / maxColsCount;
    CGFloat bottomH = bottonW;
    CGFloat bottomStartY = (XWScreenH - maxRowsCount * bottomH ) * 0.5;
    
    for (int i = 0; i < count; i++) {
        
        //x,y
        CGFloat buttonX = bottonW * (i % maxColsCount);
        CGFloat buttonY = bottomH * (i / maxColsCount) + bottomStartY;
        
        UIButton *button = [[UIButton alloc]init];
        button.backgroundColor = XWRandomColor;
        button.frame = CGRectMake(buttonX , buttonY, bottonW, bottomH);
        
        //设置按钮内容
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        
        [self.view addSubview:button];
    }
    
}

#pragma mark -m xib上面添加子控件标语
- (void)setupSloganView
{
    UIImageView *sloganView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    
    //设置位置
    sloganView.y = 50;
    sloganView.centerX = XWScreenW * 0.5;
    
    [self.view addSubview:sloganView];
}


- (IBAction)cancel:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
