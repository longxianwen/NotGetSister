//
//  XWSettingTableController.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/2.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  设置

#import "XWSettingTableController.h"
#import <SDWebImage/SDImageCache.h>
#import "XWClearCacheCell.h"

@implementation XWSettingTableController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";
    
    //TableView的初始化
    [self setupTableView];
}

#pragma mark -m TableView的初始化
/**cell循环利用标识*/
static NSString * const XWMeSettingCellId = @"me_setting";
- (void)setupTableView
{
    //设置背景颜色
    self.tableView.backgroundColor = XWGlobalBg;
    
    //距离顶部间距
    self.tableView.contentInset = UIEdgeInsetsMake(XWCommMargin - 35, 0, 0, 0);
    
    //注册cell
    [self.tableView registerClass:[XWClearCacheCell class] forCellReuseIdentifier:XWMeSettingCellId];
}


#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    XWClearCacheCell *cell = [tableView dequeueReusableCellWithIdentifier:XWMeSettingCellId];
    
    return cell;
}

#pragma mark -m <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0 && indexPath.row == 0)
    {
        // 取消选中--时动画效果
        // 选中后的反显颜色即刻消失
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        //拿到选中cell
        XWClearCacheCell *cell = (XWClearCacheCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        
        [cell clearCache];
    }
}

@end
