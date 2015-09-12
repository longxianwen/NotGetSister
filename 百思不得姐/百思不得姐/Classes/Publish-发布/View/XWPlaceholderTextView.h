//
//  XWPlaceholderTextView.h
//  百思不得姐
//
//  Created by longxianwen on 15/9/12.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWPlaceholderTextView : UITextView

/**占位文字*/
@property (nonatomic,copy) NSString *placeholder;

/**占位文字颜色*/
@property (nonatomic,strong) UIColor *placeholderColor;
@end
