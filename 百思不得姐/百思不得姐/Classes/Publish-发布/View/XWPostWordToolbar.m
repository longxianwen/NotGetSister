//
//  XWPostWordToolbar.m
//  百思不得姐
//
//  Created by longxianwen on 15/10/4.
//  Copyright © 2015年 longxianwen. All rights reserved.
//  发表文字页面--自定义底部工具条

#import "XWPostWordToolbar.h"
#import "XWAddTagViewController.h"
#import "XWNavigationController.h"

@interface XWPostWordToolbar ()

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewHeight;

/**保存标签*/
@property (nonatomic,strong) NSMutableArray *tagLabels;

/**addButton*/
@property (nonatomic,strong) UIButton *addButton;

@end

@implementation XWPostWordToolbar

- (NSMutableArray *)tagLabels
{
    if(!_tagLabels)
    {
        _tagLabels = [NSMutableArray array];
    }
    return _tagLabels;
}

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
    
    self.addButton = addbutton;
    
    [self.topView addSubview:addbutton];
}


//得到标签
- (void)addClick
{
    XWAddTagViewController *addTag = [[XWAddTagViewController alloc]init];
    
    addTag.tags = [self.tagLabels valueForKeyPath:@"text"];
    
    //这里需要拿到返回的标签数据
    XWWeakSelf;
    addTag.tagButtonData = ^(NSArray *tagTitles)
    {
        //创建标签，并添加到工具条的顶部标签栏
        [weakSelf createTagLabels:tagTitles];
    };
    
    XWNavigationController *nav = [[XWNavigationController alloc]initWithRootViewController:addTag];
    
    //根据源控制器拿到曾经modal出来的目标控制器(当前显示的发表文字控制器)
    UIViewController *vc = self.window.rootViewController.presentedViewController;
    
    //modal出添加标签控制器。
    [vc presentViewController:nav animated:YES completion:nil];
}

//添加标签到顶部标签栏
- (void)createTagLabels:(NSArray *)tagTitles
{
    //删除以前所有的标签
    [self.tagLabels removeAllObjects];
    
    for (NSString *text in tagTitles) {
        UILabel *newTagLabel = [[UILabel alloc]init];
        newTagLabel.backgroundColor = XWTagBgColor;
        newTagLabel.font = [UIFont systemFontOfSize:14];
        newTagLabel.textColor = [UIColor whiteColor];
        newTagLabel.textAlignment = NSTextAlignmentCenter;
        newTagLabel.text = text;
        
        //设置尺寸
        [newTagLabel sizeToFit];
        
        //微调高度
        newTagLabel.height = XWTagH;
        newTagLabel.width += 2 * XWCommonSmallMargin;
        
        //设置位置
        UILabel *lastLabel = self.tagLabels.lastObject;
        // 左边的总宽度
        CGFloat leftWidth = CGRectGetMaxX(lastLabel.frame) + XWCommonSmallMargin;
        CGFloat rightWidth = self.topView.width - leftWidth;
        
        if(lastLabel) //不是第一个标签
        {
            if(rightWidth >= newTagLabel.width)  //添加到本行的其他标签按钮的后面
            {
                newTagLabel.x = leftWidth;
                newTagLabel.y = lastLabel.y;
            } else  //换行
            {
                newTagLabel.x = 0;
                newTagLabel.y = CGRectGetMaxY(lastLabel.frame) + XWCommonSmallMargin;
            }
        } else //第一个标签
        {
            newTagLabel.x = 0;
            newTagLabel.y = 0;
        }
        
        [self.topView addSubview:newTagLabel];
        
        //添加标签按钮到数组
        [self.tagLabels addObject:newTagLabel];
    }
    
    //设置+号按钮位置
    UILabel *lastLabel = self.tagLabels.lastObject;
    // 左边的总宽度
    CGFloat leftWidth = CGRectGetMaxX(lastLabel.frame) + XWCommonSmallMargin;
    CGFloat rightWidth = self.topView.width - leftWidth;
    
    if(rightWidth >= 100 )
    {
        self.addButton.x = leftWidth;
        self.addButton.y = lastLabel.y;
    } else
    {
        self.addButton.x = 0;
        self.addButton.y = CGRectGetMaxY(lastLabel.frame) + XWCommonSmallMargin;
    }
    
    //计算工具条的高度
    self.topViewHeight.constant = CGRectGetMaxY(self.addButton.frame);
    CGFloat oldHeight = self.height;
    self.height = self.topViewHeight.constant + self.bottomView.height + XWCommonSmallMargin;
    self.y += oldHeight - self.height;
    
}

@end
