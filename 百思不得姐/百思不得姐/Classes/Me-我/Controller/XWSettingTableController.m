//
//  XWSettingTableController.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/2.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  设置

#import "XWSettingTableController.h"

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
static NSString * const XWMeCellId = @"me";
- (void)setupTableView
{
    //设置背景颜色
    self.tableView.backgroundColor = XWGlobalBg;
    
    //距离顶部间距
    self.tableView.contentInset = UIEdgeInsetsMake(XWCommMargin - 35, 0, 0, 0);
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"me_setting"];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"me_setting"];
        
        cell.textLabel.text = @"清除缓存";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

@end
