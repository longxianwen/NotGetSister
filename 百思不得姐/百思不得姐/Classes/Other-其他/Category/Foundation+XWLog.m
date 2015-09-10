//
//  NSObject+XWLog.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/9.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//

#import <Foundation/Foundation.h>

//分类中方法优先级大于原始类。
//数组中文日志
@implementation NSArray (Log)

- (nonnull NSString *)descriptionWithLocale:(nullable id)locale
{
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

