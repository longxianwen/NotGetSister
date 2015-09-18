//
//  XWTopicCell.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/18.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  自定义帖子cell(全部，图片，段子，音频，视频)

#import "XWTopicCell.h"

@interface XWTopicCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@end

@implementation XWTopicCell

- (void)awakeFromNib {
    // Initialization code
    
    //设置背景图片
    self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    
    //设置cell选中效果
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - 设置数据
- (void)setTopic:(XWTopic *)topic
{
    _topic = topic;
    
    //设置头像
    [self.profileImageView setHeaderImage:topic.profile_image];
    self.nameLabel.text = topic.name;
    self.createAtLabel.text = topic.created_at;
    //日期处理
    
    
    self.text_label.text = topic.text;
    
    //设置工具条底部文字
    [self setupButtonTitle:self.dingButton andNSInteger:topic.ding andPlaceholder:@"顶"];
    
    [self setupButtonTitle:self.caiButton andNSInteger:topic.cai andPlaceholder:@"踩"];
    
    [self setupButtonTitle:self.repostButton andNSInteger:topic.repost andPlaceholder:@"转发/分享"];
    
    [self setupButtonTitle:self.commentButton andNSInteger:topic.comment andPlaceholder:@"评论"];
}

/**
 *  设置底部工具条数据
 *
 *  @param button      工具按钮
 *  @param number      顶/踩/转发/评论数量
 *  @param placeholder 默认占位文字
 */
- (void)setupButtonTitle:(UIButton*)button andNSInteger:(NSInteger)number andPlaceholder:(NSString*)placeholder
{
    if(number >=10000)
    {
       [button setTitle:[NSString stringWithFormat:@"%.1f万",number / 10000.0] forState:UIControlStateNormal];
    } else if (number > 0)
    {
        [button setTitle:[NSString stringWithFormat:@"%zd",number] forState:UIControlStateNormal];
    } else
    {
        [button setTitle:[NSString stringWithFormat:@"%@",placeholder] forState:UIControlStateNormal];
    }
    
}

#pragma mark - 更多点击
- (IBAction)moreClick:(id)sender {
    
    //弹出底部弹框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //添加内容
    
    [alert addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        XWLog(@"收藏");
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        XWLog(@"举报");
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        XWLog(@"取消");
    }]];
    
    //显示弹框
    [self.window.rootViewController presentViewController:alert animated:YES completion:nil];

}

- (void)setFrame:(CGRect)frame
{
    frame.origin.y += XWCommMargin;
    frame.size.height = frame.size.height - XWCommMargin;
    
    [super setFrame:frame];
}

@end
