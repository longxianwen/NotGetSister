//
//  NSDate+XWExtension.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/18.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//

#import "NSDate+XWExtension.h"

@implementation NSDate (XWExtension)

/**
 *  当前日期和指定日期进行比较
 *
 *  @param date 比较日期
 *
 *  @return 两个日期的时间间隔
 */
- (NSDateComponents*) intervalToDate:(NSDate *)date
{
    //通过日历类比较发帖时间和当前时间
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //(ˇˍˇ） 想～比较哪些元素
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    
    NSDateComponents *cmps = [calendar components:unit fromDate:self toDate:date options:0];
    
    return cmps;
}

/**
 *  和本地日期进行比较
 *
 *  @return 获得与本地日期之间的时间间隔
 */
- (NSDateComponents*) intervalToNow
{
    return [self intervalToDate:[NSDate date]];
}
@end
