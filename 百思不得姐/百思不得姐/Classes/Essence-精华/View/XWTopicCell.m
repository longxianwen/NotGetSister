//
//  XWTopicCell.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/18.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  自定义帖子cell(图片，段子，音频，视频)

#import "XWTopicCell.h"
#import "XWTopicPictureView.h"
#import "XWTopicVideoView.h"
#import "XWTopicVoiceView.h"
#import "XWTopic.h"
#import "XWComment.h"

@interface XWTopicCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

/**图片*/
@property (nonatomic,weak) XWTopicPictureView * pictureView;

/**视频*/
@property (nonatomic,weak) XWTopicVideoView * videoView;

/**声音*/
@property (nonatomic,weak) XWTopicVoiceView * voiceView;

/**最热评论*/
@property (weak, nonatomic) IBOutlet UIView *topCmtView;

/**最热评论内容*/
@property (weak, nonatomic) IBOutlet UILabel *topCmtLabel;


@end

@implementation XWTopicCell

#pragma mark - lazy
- (XWTopicPictureView *)pictureView
{
    if (!_pictureView) {
        NSArray * arr = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([XWTopicPictureView class]) owner:nil options:nil];
        
        XWTopicPictureView *pictureView = arr.firstObject;
        //加载中间内容
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (XWTopicVideoView *)videoView
{
    if(!_videoView)
    {
        XWTopicVideoView *videoView = [XWTopicVideoView viewFromXib];
        
        //加载中间内容
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

- (XWTopicVoiceView *)voiceView
{
    if(!_voiceView)
    {
        XWTopicVoiceView *voiceView = [XWTopicVoiceView viewFromXib];
        
        //加载中间内容
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

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

#pragma mark - 设置数据(调用频繁)
- (void)setTopic:(XWTopic *)topic
{
    _topic = topic;
    
    //设置顶部内容
    //头像
    [self.profileImageView setHeaderImage:topic.profile_image];
    self.nameLabel.text = topic.name;
    //日期处理,重写created_at属性的get方法进行拦截
    self.createAtLabel.text = topic.created_at;
    
    //设置文字内容
    self.text_label.text = topic.text;
    
    //设置中间内容
    if(topic.type == XWTopicTypePicture)
    {
        self.pictureView.hidden = NO;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        //设置位置
        self.pictureView.frame = topic.contentFrame;
        //设置数据
        self.pictureView.topic = topic;
    } else if(topic.type == XWTopicTypeVideo)
    {
        self.pictureView.hidden = YES;
        self.videoView.hidden = NO;
        self.voiceView.hidden = YES;
        
        //设置位置
        self.videoView.frame = topic.contentFrame;

        //设置数据
        self.videoView.topic = topic;
        
//        XWLog(@"%@,%@",topic.name,NSStringFromCGRect(topic.contentFrame));
        
    } else if(topic.type == XWTopicTypeVoice)
    {
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = NO;
        
        //设置位置
        self.voiceView.frame = topic.contentFrame;
        //设置数据
        self.voiceView.topic = topic;
        
    } else if(topic.type == XWTopicTypeWord)
    {
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
    }
    
    //最热评论内容
    if(topic.topComment)
    {
        self.topCmtView.hidden = NO;
        
        XWComment *cmt = topic.topComment;
        
        //评论人
        NSString *username = cmt.user.username;
        //评论内容
        NSString *content  = cmt.content;
        
        NSString *topCmtStr = [NSString stringWithFormat:@"%@:%@",username,content];
        
        self.topCmtLabel.text = topCmtStr;
    } else
    {
        self.topCmtView.hidden = YES;
    }
    
  
    //设置工具条底部内容
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
