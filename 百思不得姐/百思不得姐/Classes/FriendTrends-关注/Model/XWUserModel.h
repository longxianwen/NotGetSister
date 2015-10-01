//
//  XWUserModel.h
//  百思不得姐
//
//  Created by longxianwen on 15/10/1.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XWUserModel : NSObject


/**header图片*/
@property (nonatomic,copy) NSString *header;

/**姓名*/
@property (nonatomic,copy) NSString *screen_name;

/**粉丝人数*/
@property (nonatomic,copy) NSString *fans_count;

@end
