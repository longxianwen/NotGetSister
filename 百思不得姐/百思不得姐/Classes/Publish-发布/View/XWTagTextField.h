//
//  XWTagTextField.h
//  百思不得姐
//
//  Created by longxianwen on 15/10/6.
//  Copyright © 2015年 longxianwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWTagTextField : UITextField

/** 点击删除键需要执行的操作 */
@property (nonatomic,copy) void(^deleteBackwardOperation)();

@end
