//
//  XWTopicCommentCell.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/24.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  评论自定义cell

#import "XWTopicCommentCell.h"
#import "XWComment.h"

@interface XWTopicCommentCell ()

/** 用户头像 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

/** 用户性别 */
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;

/** 用户姓名 */
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

/** 评论内容 */
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

/** 点赞数量 */
@property (weak, nonatomic) IBOutlet UILabel *likecountLabel;

/** 语音信息 */
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@end

@implementation XWTopicCommentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setComment:(XWComment *)comment
{
    _comment = comment;
    
    //设置数据
    [self.profileImageView setHeaderImage:comment.user.profile_image];
    
    //设置性别图像
    if([comment.user.sex isEqualToString:XWUserSexMale])
    {
        self.sexImageView.image = [UIImage imageNamed:@"Profile_manIcon"];
    } else
    {
        self.sexImageView.image = [UIImage imageNamed:@"Profile_womanIcon"];
    }
    
    self.usernameLabel.text = comment.user.username;
    
    self.contentLabel.text = comment.content;
    
    self.likecountLabel.text = [NSString stringWithFormat:@"%ld",comment.like_count];
    
    //设置语音信息
    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton setTitle:[NSString stringWithFormat:@"%zd''", comment.voicetime] forState:UIControlStateNormal];
    } else {
        self.voiceButton.hidden = YES;
    }
    
}
//播放语音信息
- (IBAction)playVoice:(id)sender {
    
    NSLogFunc;
}

//点赞
- (IBAction)clickCmt:(id)sender {
    NSLogFunc;
}
@end
