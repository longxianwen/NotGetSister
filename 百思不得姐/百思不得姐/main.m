//
//  main.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/1.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        /*
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        
        NSDate *date = [fmt dateFromString:@"2015-09-20 23:09:10"];
        
//        今年：1，今天：0，昨天：0，明天：4294967297
//        明天显示不正确..
//        机上下面一句或者将zd改为d,显示就正常
//        XWLog(@"%d",date.isTomorrow);
        
        XWLog(@"今年：%d， 今天：%d，昨天：%d，明天：%d",
               date.isThisYear,
               date.isToday,
               date.isYesterday,
               date.isTomorrow);
         */
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
