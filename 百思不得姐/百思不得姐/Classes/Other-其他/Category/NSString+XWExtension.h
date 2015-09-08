//
//  NSString+loren.h
//  工具类
//
//  Created by longxianwen on 15/8/23.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XWExtension)


/**<得到资源mimeType类型*/
- (NSString *)getMIMEType:(NSURL *)url;

/**<用于生成文件在cache目录中的路径*/
- (instancetype)cacheDir;

/**<用于生成文件在document目录中的路径*/
- (instancetype)docDir;

/**<用于生成文件在tmp目录中的路径*/
- (instancetype)tmpDir;



@end
