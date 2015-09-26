//
//  XWTopic.h
//  百思不得姐
//
//  Created by longxianwen on 15/9/16.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  帖子数据模型(图片，段子，音频，视频)

#import <Foundation/Foundation.h>
@class XWComment;

//10为图片，29为段子，31为音频，41为视频
typedef enum
{
    /**All*/
    XWTopicTypeAll = 1,
    /**图片*/
    XWTopicTypePicture = 10,
    /**段子*/
    XWTopicTypeWord = 29,
    /**声音*/
    XWTopicTypeVoice = 31,
    /**视频*/
    XWTopicTypeVideo = 41
} XWTopicType;

@interface XWTopic : NSObject

// 用户 -- 发帖者

/**帖子ID*/
@property (nonatomic,copy) NSString *ID;

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

/** 帖子的类型 */
@property (nonatomic,assign)XWTopicType type;

/** 图片的宽度 */
@property (nonatomic, assign) CGFloat width;
/** 图片的高度 */
@property (nonatomic, assign) CGFloat height;

/** 小图 */
@property (nonatomic, copy) NSString *small_image;//image0
/** 大图 */
@property (nonatomic, copy) NSString *large_image;//image1
/** 中图 */
@property (nonatomic, copy) NSString *middle_image;//image2

/** 是否为动态图 */
@property (nonatomic, assign) BOOL is_gif;

/** 视频的时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 音频的时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 播放数量 */
@property (nonatomic, assign) NSInteger playcount;

/** 最热评论 (这个数组中存放的应该是XMGComment模型)*/
//@property (nonatomic, strong) NSArray *top_cmt;
@property (nonatomic, strong) XWComment *topComment;

/***** 额外增加的属性 ******/
/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

/** 中间内容的frame */
@property (nonatomic, assign) CGRect contentFrame;

/** 是否大图片 */
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;

@end
