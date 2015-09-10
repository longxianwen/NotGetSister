//
//  XWClearCacheCell.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/10.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//

#import "XWClearCacheCell.h"
#import <SVProgressHUD/SVProgressHUD.h>

@implementation XWClearCacheCell

/**默认缓存路径*/
#define XWCacheFile [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject] stringByAppendingPathComponent:@"default"]
//#define XWCacheFile @"/Users/longxianwen/Documents"

/**缓存cell默认文字*/
static NSString * const XWDefaultCacheText = @"清除缓存";
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if([super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.textLabel.text = XWDefaultCacheText;
        
        //禁止与用于交互
        self.userInteractionEnabled = NO;
        
        [[[NSOperationQueue alloc]init]addOperationWithBlock:^{
            
            //判断文件大小
            NSInteger size = XWCacheFile.getFileSize;
            
            NSString *sizeText = nil;
            CGFloat unit = 1000.0;
            if (size >= unit * unit * unit) { // >= 1GB
                sizeText = [NSString stringWithFormat:@"%.1fGB", size / unit / unit / unit];
            } else if (size >= unit * unit) { // >= 1MB
                sizeText = [NSString stringWithFormat:@"%.1fMB", size / unit / unit];
            } else if (size >= unit) { // >= 1KB
                sizeText = [NSString stringWithFormat:@"%.1fKB", size / unit];
            } else { // >= 0B
                sizeText = [NSString stringWithFormat:@"%zdB", size];
            }
            
            NSString *clearText = [NSString stringWithFormat:@"%@(%@)",XWDefaultCacheText, sizeText];
            
            //回主线程更新数据
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                self.accessoryView = nil;
                self.textLabel.text = clearText;
                self.userInteractionEnabled = YES;
            }];
        }];
        
        // 右边显示圈圈
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [loadingView startAnimating];
        self.accessoryView = loadingView;
    }
    
    return self;
}

//cell重新显示时,重新让菊花转起来
- (void)updateStatus
{
    if (self.accessoryView == nil) return;
    
    // 让圈圈继续旋转
    UIActivityIndicatorView *loadingView = (UIActivityIndicatorView *)self.accessoryView;
    [loadingView startAnimating];
}

- (void)clearCache
{
    [SVProgressHUD showWithStatus:@"正在清除缓存..." maskType: SVProgressHUDMaskTypeBlack];
    
    [[[NSOperationQueue alloc]init] addOperationWithBlock:^{
        XWLog(@"清除缓存");
        [[NSFileManager defaultManager] removeItemAtPath:XWCacheFile error:nil];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [SVProgressHUD showSuccessWithStatus:@"清除成功"];
            
            self.textLabel.text = XWDefaultCacheText;
            
            self.userInteractionEnabled = NO;
            
        }];
    }];
}

@end
