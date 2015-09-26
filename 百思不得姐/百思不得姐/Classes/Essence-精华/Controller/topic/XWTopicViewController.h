//
//  XWTopicViewController.h
//  百思不得姐
//
//  Created by longxianwen on 15/9/26.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XWTopic.h"

@interface XWTopicViewController : UITableViewController

/**帖子的类型*/
@property (nonatomic,assign) XWTopicType type;
@end
