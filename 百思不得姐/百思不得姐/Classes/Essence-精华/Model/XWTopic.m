//
//  XWTopic.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/16.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//

#import "XWTopic.h"

@implementation XWTopic

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

//拦截计算cell的高度
// 在这个方法中，已经将cell的高度 和 中间内容的frame 计算完毕
- (CGFloat)cellHeight
{
    if(_cellHeight == 0)
    {
        //顶部内容高度
        CGFloat cellHeight = XWTopicTextY;
        
        //计算文字高度
        CGFloat textW = XWScreenW - 2 * XWCommMargin;
        
        //第一个参数:限制内容的范围
        //第二个参数:从内容什么位置开始算
        //第三个参数:内容字体大小
        //第四个参数:上下文
        CGFloat textH = [self.text boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height;
        
        cellHeight += textH + XWCommMargin;
        
        //中间内容的高度
        if(self.type != XWTopicTypeWord)
        {
            CGFloat contentW = textW;
            // 图片的高度 * 内容的宽度 / 图片的宽度(等比缩放,图片显示真实高度)
            CGFloat contentH = self.height * contentW / self.width;
            
            if (contentH >= XWScreenH) {
                contentH = 200;
                self.bigPicture = YES;
            }
            
            CGFloat contentX = XWCommMargin;
            CGFloat contentY = cellHeight;
            self.contentFrame = CGRectMake(contentX, contentY, contentW, contentH);
            
            cellHeight += contentH + XWCommMargin;
        }
        
        //底部工具条的高度
        cellHeight += XWTopicToolbarH + XWCommMargin;
        _cellHeight = cellHeight;
    }
    return _cellHeight;
}

@end
