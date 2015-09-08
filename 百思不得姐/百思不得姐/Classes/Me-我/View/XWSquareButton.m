//
//  XWSquareButton.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/8.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  我--footView--方块按钮

#import "XWSquareButton.h"
#import <UIButton+WebCache.h>

@implementation XWSquareButton



- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        //设置带有分隔线的背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置图片位置
    
    self.imageView.width = self.width * 0.5;
    self.imageView.height = self.imageView.width;
    self.imageView.y = self.height * 0.1;
    self.imageView.centerX  = self.width * 0.5;

    //设置位子文字
    self.titleLabel.width = self.width;
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.height = self.height -  self.titleLabel.y;

}

- (void)setSquareButton:(XWSquare *)squareButton
{
    _squareButton = squareButton;
    
    //设置数据
    [self setTitle:_squareButton.name forState:UIControlStateNormal];
    
    [self sd_setImageWithURL:[NSURL URLWithString:_squareButton.icon] forState:UIControlStateNormal];
    
    /*
     //下载图片
     [[SDWebImageManager sharedManager]downloadImageWithURL:[NSURL URLWithString:square.icon] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
     
     [btn setImage:image forState:UIControlStateNormal];
     
     }];
     */
}

@end
