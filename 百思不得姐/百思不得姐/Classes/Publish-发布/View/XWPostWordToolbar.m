//
//  XWPostWordToolbar.m
//  百思不得姐
//
//  Created by longxianwen on 15/10/4.
//  Copyright © 2015年 longxianwen. All rights reserved.
//  发表文字页面--自定义底部工具条

#import "XWPostWordToolbar.h"

@interface XWPostWordToolbar ()

@property (weak, nonatomic) IBOutlet UIView *topView;

@end

@implementation XWPostWordToolbar

- (void)awakeFromNib
{
    //添加标签按钮
    UIButton *addbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [addbutton setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    
    //自动计算尺寸
    //sizeToFit生效，必须要先有内容
    [addbutton sizeToFit];
    
    //监听事件
    [addbutton addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.topView addSubview:addbutton];
}


//添加标签
- (void)addClick
{
    XWLog(@"点击了...");
}

@end
