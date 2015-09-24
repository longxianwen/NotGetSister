//
//  XWComment.h
//  百思不得姐
//
//  Created by longxianwen on 15/9/23.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XWUser.h"

@interface XWComment : NSObject

/** 文字内容 */
@property (nonatomic, copy) NSString *content;

/** 用户 */
@property (nonatomic, strong) XWUser *user;

/** 点赞数 */
@property (nonatomic, assign) NSInteger like_count;

/** 语音文件的路径 */
@property (nonatomic, copy) NSString *voiceuri;

/** 语音文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;

@end
