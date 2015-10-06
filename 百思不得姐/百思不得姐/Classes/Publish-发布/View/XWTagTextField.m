//
//  XWTagTextField.m
//  百思不得姐
//
//  Created by longxianwen on 15/10/6.
//  Copyright © 2015年 longxianwen. All rights reserved.
//

#import "XWTagTextField.h"

@implementation XWTagTextField

//监听键盘的删除键
- (void)deleteBackward
{
    !self.deleteBackwardOperation ? : self.deleteBackwardOperation();
    
    [super deleteBackward];
}

@end
