//
//  XWTopic.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/16.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//

#import "XWTopic.h"

@implementation XWTopic

//拦截获得发帖时间,进行相关设置
- (NSString *)created_at
{
    //日期格式化类
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    //设置日期格式
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    //将字符串日期转换为NSDate,获得发帖时间
    NSDate *createAtDate = [formatter dateFromString:_created_at];
    
    NSDateComponents *cmps = [createAtDate intervalToNow];
    
    NSLog(@"%@",cmps);
    
    return @"刚刚";
}

@end
