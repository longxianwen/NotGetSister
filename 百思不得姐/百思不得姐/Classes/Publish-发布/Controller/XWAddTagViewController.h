//
//  XWAddTagViewController.h
//  百思不得姐
//
//  Created by longxianwen on 15/10/5.
//  Copyright © 2015年 longxianwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWAddTagViewController : UIViewController

/**保存的标签数据*/
@property (nonatomic,copy) void(^tagButtonData)(NSArray *);

/** 从上一个界面传递过来的标签数据 */
@property (nonatomic, strong) NSArray *tags;

@end
