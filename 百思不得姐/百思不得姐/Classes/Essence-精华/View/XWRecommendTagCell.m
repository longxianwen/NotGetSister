//
//  XWRecommendTagCell.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/6.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//

#import "XWRecommendTagCell.h"
#import <UIImageView+WebCache.h>

@interface XWRecommendTagCell ()
@property (weak, nonatomic) IBOutlet UIImageView *tagImage_list;
@property (weak, nonatomic) IBOutlet UILabel *tagTheme_name;
@property (weak, nonatomic) IBOutlet UILabel *tagSub_number;

@end

@implementation XWRecommendTagCell

- (void)awakeFromNib {
    // Initialization code
//    NSLogFunc
    
    //设置圆角图片
//    self.tagImage_list.layer.cornerRadius = self.tagImage_list.width * 0.5;
//    
//    self.tagImage_list.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


//设置数据
- (void)setRecommendTag:(XWRecommendTag *)recommendTag
{
    _recommendTag = recommendTag;
    
    //标签名称
    self.tagTheme_name.text = recommendTag.theme_name;
    
    //订阅量
    NSInteger sub_number = [recommendTag.sub_number intValue];
    if([recommendTag.sub_number intValue] >= 10000)
    {
        self.tagSub_number.text = [NSString stringWithFormat:@"%.2f万人订阅",sub_number / 10000.0];
    } else
    {
        self.tagSub_number.text = recommendTag.sub_number;
    }
    
    //标签图片
    [self.tagImage_list sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if(image == nil) return ;
        
        // 开启图形上下文
        UIGraphicsBeginImageContext(image.size);
        
        // 获得上下文
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        // 矩形框
        CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
        
        // 添加一个圆
        CGContextAddEllipseInRect(ctx, rect);
        
        // 裁剪(裁剪成刚才添加的图形形状)
        CGContextClip(ctx);
        
        // 往圆上面画一张图片
        [image drawInRect:rect];
        
        // 获得上下文中的图片
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        
        // 关闭图形上下文
        UIGraphicsEndImageContext();
        
        self.tagImage_list.image = newImage;
        
    }];
}

//通过更改cell高度设置分隔线
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    
    //实现两边间距
//    frame.origin.x += 5;
//    frame.size.width -= 10;
    
    [super setFrame:frame];
}


@end
