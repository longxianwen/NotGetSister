//
//  XWVoiceViewController.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/15.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  声音

#import "XWVoiceViewController.h"

@implementation XWVoiceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    NSLogFunc;
    [self setupTableView];
}

- (void)setupTableView
{
    //设置背景颜色
    self.tableView.backgroundColor = XWGlobalBg;
    
    //设置内边距
    self.tableView.contentInset = UIEdgeInsetsMake(XWNavBarMaxY + XWTitleViewH, 0, XWTabBarH, 0);
    
    //指定滚动条在scrollerView中的位置
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %zd -- ", self.title, indexPath.row];
    
    return cell;
}
@end
