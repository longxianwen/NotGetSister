//
//  NSString+loren.m
//  工具类
//
//  Created by longxianwen on 15/8/23.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//
#import "NSString+loren.h"

@implementation NSString (loren)

//用于获取url MIME类型
- (NSString *)getMIMEType:(NSURL *)url
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    return response.MIMEType;
}

- (instancetype)cacheDir
{
    // 1.获取caches目录
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    // 2.生成绝对路径
    return [path stringByAppendingPathComponent:[self lastPathComponent]];
}

// 用于生成文件在document目录中的路径
- (instancetype)docDir
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return [path stringByAppendingPathComponent:[self lastPathComponent]];
}

// 用于生成文件在tmp目录中的路径
- (instancetype)tmpDir
{
    NSString *path = NSTemporaryDirectory();
    return [path stringByAppendingPathComponent:[self lastPathComponent]];
}

@end
