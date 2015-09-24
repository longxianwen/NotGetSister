//
//  XWCommentViewController.h
//  百思不得姐
//
//  Created by longxianwen on 15/9/23.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XWTopic;

@interface XWCommentViewController : UIViewController

/**帖子模型*/
@property (nonatomic,strong) XWTopic *topic;
@end
