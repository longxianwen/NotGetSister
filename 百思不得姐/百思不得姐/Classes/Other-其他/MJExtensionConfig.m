//
//  MJExtensionConfig.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/23.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//

#import "MJExtensionConfig.h"
#import <MJExtension/MJExtension.h>
#import "XWTopic.h"
#import "XWComment.h"
#import "XWRecommendCategoryModel.h"

@implementation MJExtensionConfig

+ (void)load
{
    /**
     *  属性名--字典key的映射(key-mapping)
     */
    
//    + (NSDictionary *)replacedKeyFromPropertyName
//    {
//        return @{
//                 @"ID":@"id",
//                 @"small_image":@"image0",
//                 @"large_image":@"image1",
//                 @"middle_image":@"image2",
//                 @"topComment":@"top_cmt[0]"
//                 };
//    }
    
    [XWTopic setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"ID":@"id",
                 @"small_image":@"image0",
                 @"large_image":@"image1",
                 @"middle_image":@"image2",
                 @"topComment":@"top_cmt[0]"
                 };
    }];
    
    [XWComment setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"ID":@"id"
                 };
    }];
    
    [XWRecommendCategoryModel setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"ID":@"id"
                 };
    }];
}

@end
