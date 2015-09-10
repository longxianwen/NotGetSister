//
//  NSString+loren.h
//  工具类
//
//  Created by longxianwen on 15/8/23.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XWExtension)

/**
*  拼接caches目录下文件的路径
*
*  @return caches目录下文件的路径
*/
- (instancetype)cacheDir;

/**
 *  拼接Documents目录下文件的路径
 *
 *  @return Documents目录下文件的路径
 */
- (instancetype)docDir;

/**
 *  拼接tmp目录下文件的路径
 *
 *  @return tmp目录下文件的路径
 */
- (instancetype)tmpDir;

/**<获取Documents目录路径*/
/**<获取Library-caches目录路径*/
/**<获取Library-Preferences目录路径*/
/**<获取tmp目录路径*/
/**<获取安装目录下指定文件路径*/

/**
 *  得到资源mimeType类型
 *
 *  @param url 资源的url地址
 *
 *  @return mimeType类型
 */
- (NSString *)getMIMEType:(NSURL *)url;

/**
 *  获取文件大小
 *  @return 文件总大小
 */
- (NSInteger)getfileSize;

@end
