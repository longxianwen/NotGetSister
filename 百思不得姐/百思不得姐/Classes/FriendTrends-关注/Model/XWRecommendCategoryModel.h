//
//  XWCategory.h
//  百思不得姐
//
//  Created by longxianwen on 15/9/28.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XWRecommendCategoryModel : NSObject

/** id */
@property (nonatomic, copy) NSString *ID;
/** 名字 */
@property (nonatomic, copy) NSString *name;

/** 当前的页码 */
@property (nonatomic, assign) NSInteger page;

/** 这组的用户总数 */
@property (nonatomic, assign) NSInteger total;

/** 右边用户数据 */
@property (nonatomic, strong) NSMutableArray *usersArr;

@end
