//
//  XWRecommendTag.h
//  百思不得姐
//
//  Created by longxianwen on 15/9/6.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  推荐标签数据模型

#import <Foundation/Foundation.h>

@interface XWRecommendTag : NSObject


/**<推荐标签的图片url地址*/
@property (nonatomic,copy) NSString *image_list;

/**<是否是默认的推荐标签*/
@property (nonatomic,assign)int is_default;

/**<此标签的订阅量*/
@property (nonatomic,copy) NSString *sub_number;

/**<标签名称*/
@property (nonatomic,copy) NSString *theme_name;

/**<此标签的id*/
@property (nonatomic,copy) NSString *theme_id;

/**<是否含有子标签*/
@property (nonatomic,assign)int is_sub;

@end
