//
//  XWTopic.h
//  百思不得姐
//
//  Created by longxianwen on 15/9/16.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  帖子数据模型(全部，图片，段子，音频，视频)

#import <Foundation/Foundation.h>

@interface XWTopic : NSObject
// 用户 -- 发帖者
/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *created_at;
/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;
@end
