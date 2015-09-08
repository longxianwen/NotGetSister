//
//  NSDictionary+Log.m
//  多值参数(字典中文问题)
//
//  Created by longxianwen on 15/8/23.
//  Copyright © 2015年 longxianwen. All rights reserved.
//
#import <Foundation/Foundation.h>

@implementation NSDictionary (Log)

- (nonnull NSString *)descriptionWithLocale:(nullable id)locale
{
    //1.创建一个可变的数组保存数据
    NSMutableString *strM = [NSMutableString string];
    
    //2.添加开始标志
    [strM appendString:@"{\n"];
    
    //3.遍历字典,添加字典中的元素
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL * stop) {
        [strM appendFormat:@"\t%@ = %@\n",key,obj];
    }];
    
    //4.添加结束标志
    [strM appendString:@"}\n"];
    
    //5.取出最后一个空格
    //根据具体格式，具体修改.主要是前面4步
    
    return strM;
}

@end
