//
//  NSArray+Log.m
//  多值参数(字典中文问题)
//
//  Created by longxianwen on 15/8/23.
//  Copyright © 2015年 longxianwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@implementation NSArray (Log)

- (nonnull NSString *)descriptionWithLocale:(nullable id)locale
{
//    NSLog(@"系统会优先调用数组这个方法。。本地化");
    
    //1.定义一个可变的字符串,保存拼接结果
    NSMutableString *strM = [NSMutableString string];
    //开始标志
    [strM appendString:@"(\n"];
    
     // 2.迭代数组中所有的key/value, 将这些值拼接到字符串中
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * stop) {
        
        [strM appendFormat:@"\t%@,\n", obj];
    }];
    
    // 删除最后一个逗号
    if(self.count > 0)
    {
        NSRange range = [strM rangeOfString:@"," options:NSBackwardsSearch];
        [strM deleteCharactersInRange:range];
    }

    //结束标志
    [strM appendFormat:@")\n"];
    
    return strM;
}

@end
