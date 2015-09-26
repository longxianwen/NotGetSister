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
//理解下面语句的含义以及好处
//指定类型的type方法，限定了类型
//外界访问不到这个方法,只有子类重写。。限定了使用对象
//子类不可以直接使用..或者通过get或者set方法修改,只能重写改变,然后传值给父类使用
- (XWTopicType)type;

//@property (nonatomic,assign) XWTopicType type;
@end
