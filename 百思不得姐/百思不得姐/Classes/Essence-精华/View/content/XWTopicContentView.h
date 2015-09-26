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
{
    //了解这句话的含义:
    //@propery 会检测成员变量并会自动生成带下划线的成员变量，并且生成set和get方法
    //如果发现有下划线的成语变量则不会自动生成成员变量，只会生成set或者get方法
    
    //这样写的好处在于：向外界暴露成员变量，但外界不可以修改(调用get/set方法)
    __weak UIImageView *_imageView;
}

/**帖子模型*/
@property (nonatomic,strong) XWTopic *topic;

/**查看大图*/
- (void)seeBigPicture;

@end
