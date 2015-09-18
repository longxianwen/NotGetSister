//
//  NSDate+XWExtension.h
//  百思不得姐
//
//  Created by longxianwen on 15/9/18.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (XWExtension)

//和指定日期进行比较
- (NSDateComponents*) intervalToDate:(NSDate *)date;

//和当前日期进行比较
- (NSDateComponents*) intervalToNow;
@end
