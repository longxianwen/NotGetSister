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
//    _created_at = @"2015-09-19 15:13:12";
    //日期格式化类
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    //设置日期格式
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    //将字符串日期转换为NSDate,获得发帖时间
    NSDate *createAtDate = [formatter dateFromString:_created_at];
    
    // 比较【发帖时间】和【手机当前时间】的差值
    NSDateComponents *cmps = [createAtDate intervalToNow];
    
    if(createAtDate.isThisYear)
    {
        if(createAtDate.isToday) //今天
        {
            if(cmps.hour >= 1)  //大于一小时
            {
                return [NSString stringWithFormat:@"%zd小时前",cmps.hour];
            } else if(cmps.minute >= 1)  //1分钟<=当前时间<1小时
            {
                return [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
            }
            else
            {
                return @"刚刚";
            }
        } else if(createAtDate.isYesterday) //昨天
        {
            formatter.dateFormat = @"昨天 HH:mm:ss";
            return [formatter stringFromDate:createAtDate];
        } else //今年其他时间
        {
            formatter.dateFormat = @"MM-dd HH:mm:ss";
            return [formatter stringFromDate:createAtDate];
        }
    } else  //非今年
    {
        return _created_at;
    }
}

/*
 一、今年
 1.今天
 1> 时间差距 < 1分钟
 * 刚刚
 
 2> 1分钟 =< 时间差距 <= 59分钟
 * xx分钟前
 
 3> 时间差距 >= 1小时
 * xx小时前
 
 2.昨天
 * 昨天 18:06:56
 
 3.其它
 * 08-07 18:06:56
 
 二、非今年
 * 2014-08-07 18:06:56
 */

@end
