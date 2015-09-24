//
//  XWTopicCommentCell.h
//  百思不得姐
//
//  Created by longxianwen on 15/9/24.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XWComment;

@interface XWTopicCommentCell : UITableViewCell

/** 评论模型数据 */
@property (nonatomic, strong) XWComment  *comment;

@end
