//
//  XWRecommendUserCell.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/28.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  推荐关注--右边用户cell

#import "XWRecommendUserCell.h"
#import "XWUserModel.h"

@implementation XWRecommendUserCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUser:(XWUserModel *)user
{
    _user = user;
    
    self.textLabel.text = user.screen_name;
    
     XWLog(@"%@--",user.screen_name);
}

@end
