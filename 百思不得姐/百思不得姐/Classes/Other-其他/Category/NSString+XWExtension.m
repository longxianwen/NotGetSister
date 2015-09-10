//
//  NSString+loren.m
//  工具类
//
//  Created by longxianwen on 15/8/23.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//
#import "NSString+XWExtension.h"

@implementation NSString (XWExtension)

//用于获取url MIME类型
- (NSString *)getMIMEType:(NSURL *)url
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    return response.MIMEType;
}

//拼接caches目录下文件的路径
- (instancetype)cacheDir
{
    // 1.获取caches目录
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    // 2.生成绝对路径
    return [path stringByAppendingPathComponent:[self lastPathComponent]];
}

//拼接Documents目录下文件的路径
- (instancetype)docDir
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return [path stringByAppendingPathComponent:[self lastPathComponent]];
}

//拼接tmp目录下文件的路径
- (instancetype)tmpDir
{
    NSString *path = NSTemporaryDirectory();
    return [path stringByAppendingPathComponent:[self lastPathComponent]];
}


//获取文件大小
//不完善。。没有考虑到多重目录的情况。
//参照sdWebImage的getSize方法来写完善吧。
- (NSInteger)getfileSize
{
    NSInteger size = 0;
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    BOOL isDirectory = NO;
    //判断文件是文件夹或者文件
    BOOL exits = [mgr fileExistsAtPath:self isDirectory:&isDirectory];
    
    if(exits == NO) return 0;
    
    //是文件夹
    if(isDirectory)
    {
        NSDirectoryEnumerator * enumerator = [mgr enumeratorAtPath:self];
        
        for (NSString *subPaths in enumerator) {
            //得到文件全路径
            NSString *fullPath = [self stringByAppendingPathComponent:subPaths];
            
            //获取文件属性
            size += [mgr attributesOfItemAtPath:fullPath error:nil].fileSize;
        }
        
        return size;
    } else
    {
        //是文件
        return [mgr attributesOfItemAtPath:self error:nil].fileSize ;
    }
}

@end
