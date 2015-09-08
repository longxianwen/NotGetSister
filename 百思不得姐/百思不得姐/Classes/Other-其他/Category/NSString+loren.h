//
//  NSString+loren.h
//  工具类
//
//  Created by longxianwen on 15/8/23.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (loren)


//得到资源mimeType类型
- (NSString *)getMIMEType:(NSURL *)url;

- (instancetype)cacheDir;

- (instancetype)docDir;

- (instancetype)tmpDir;



@end
