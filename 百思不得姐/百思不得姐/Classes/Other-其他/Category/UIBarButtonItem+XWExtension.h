//
//  UIBarButtonItem+XWExtension.h
//  百思不得姐
//
//  Created by longxianwen on 15/9/2.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (XWExtension)

+ (instancetype)buttonItemCreate:(id)target andImage: (NSString*)image andHighlightedImage: (NSString*)highImage andAction:(SEL)action;
@end
