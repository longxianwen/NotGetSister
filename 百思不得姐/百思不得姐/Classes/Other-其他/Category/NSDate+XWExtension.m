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
    
//    XWLog(@"%@---%@",self,date);
//    XWLog(@"日期差值--%@",cmps);
    
    return cmps;
}

/**
 *  和本地当前日期进行比较
 *
 *  @return 获得与本地日期之间的时间间隔
 */
- (NSDateComponents*) intervalToNow
{
    return [self intervalToDate:[NSDate date]];
}

/**
 *  判断是否为今年
 *
 *  @return YES/NO
 */
//方案一:
- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //获得日期年份
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    
    //获得比较当前日期年份
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    
    return selfYear == nowYear;
}
 

//方案二:
/*
- (BOOL)isThisYear
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy";
    
    //获得日期年份
    NSString *selfYear = [formatter stringFromDate:self];
    
    //获得比较当前日期年份
    NSString *nowYear = [formatter stringFromDate:[NSDate date]];
    
    return [selfYear isEqualToString:nowYear] ;
}
 */

/**
 *  判断是否为今天
 *
 *  @return YES/NO
 */
//方案一:
/*
- (BOOL)isToday
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    
    NSString *selfString = [formatter stringFromDate:self];
    NSString *nowString = [formatter stringFromDate:[NSDate date]];

    return [selfString isEqualToString:nowString];
}
 */

//方案二:
/*
- (BOOL)isToday
{
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    return [calendar component:NSCalendarUnitYear fromDate:self] == [calendar component:NSCalendarUnitYear fromDate:now] && [calendar component:NSCalendarUnitMonth fromDate:self] == [calendar component:NSCalendarUnitMonth fromDate:now] && [calendar component:NSCalendarUnitDay fromDate:self] == [calendar component:NSCalendarUnitDay fromDate:now];
}
 */

//方案三:
- (BOOL)isToday
{
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    NSDateComponents *nowCmps = [calendar components:unit fromDate:now];
    
    return selfCmps.year == nowCmps.year &&
           selfCmps.month == nowCmps.month &&
           selfCmps.day == nowCmps.day;
}

/**
 *  判断是否为昨天
 *
 *  @return YES/NO
 */
- (BOOL)isYesterday
{
    //核心，去除时分秒。只留取年月日的时间
    //去除原因:不需要用到，如果保留，还会造成多余的逻辑判断
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    
    //取出日期字符串
    NSString *selfDateStr = [formatter stringFromDate:self];
    NSString *nowDateStr = [formatter stringFromDate:[NSDate date]];
    
    //得到只有年与日的日期
    NSDate *selfDate = [formatter dateFromString:selfDateStr];
    NSDate *nowDate = [formatter dateFromString:nowDateStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *cmps =  [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1 ;
}

/**
 *  判断是否为明天
 *
 *  @return YES/NO
 */
- (BOOL)isTomorrow
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    
    //取出日期字符串
    NSString *selfDateStr = [formatter stringFromDate:self];
    NSString *nowDateStr = [formatter stringFromDate:[NSDate date]];
    
    //得到只有年与日的日期
    NSDate *selfDate = [formatter dateFromString:selfDateStr];
    NSDate *nowDate = [formatter dateFromString:nowDateStr];
    
    //比较
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *cmps =  [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    

    return cmps.year == 0 && cmps.month == 0 && cmps.day == -1 ;
}
@end
