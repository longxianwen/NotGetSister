//
//  XWRecommendUserCell.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/28.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  推荐关注--右边用户cell

#import "XWRecommendUserCell.h"
#import "XWRecommendUserModel.h"

@interface XWRecommendUserCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end

@implementation XWRecommendUserCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUser:(XWRecommendUserModel *)user
{
    _user = user;
    
    [self.headerImageView setHeaderImage:user.header];
    
    self.screenNameLabel.text = user.screen_name;
    
    
    //设置粉丝数
    NSInteger fansCount  = [user.fans_count integerValue];
    
    NSString *fansCountStr = nil;
    
    if(fansCount > 10000)
    {
        fansCountStr = [NSString stringWithFormat:@"%0.1f万人关注",fansCount / 10000.0];
    } else
    {
        fansCountStr = [NSString stringWithFormat:@"%@人关注",user.fans_count];
    }
    
    self.fansCountLabel.text = fansCountStr;
    
}

//关注
- (IBAction)attentionClick {
    NSLogFunc;
}

@end
