//
//  XWTopicContentView.h
//  百思不得姐
//
//  Created by longxianwen on 15/9/26.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XWTopic;

@interface XWTopicContentView : UIView

/**  图片内容*/
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

/**帖子模型*/
@property (nonatomic,strong) XWTopic *topic;

@end
