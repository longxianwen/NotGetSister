//
//  XWMeController.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/1.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  我

#import "XWMeController.h"
#import "XWSettingTableController.h"

@interface XWMeController ()

@end

@implementation XWMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //TableView的初始化
    [self setupTableView];
    
}

#pragma mark -m TableView的初始化
- (void)setupTableView
{
    self.navigationItem.title = @"我的";
    
    //设置背景颜色
    self.tableView.backgroundColor = XWGlobalBg;
    
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    
    //调整组与组之间的距离
    self.tableView.sectionFooterHeight = 10;
    self.tableView.sectionHeaderHeight = 0;
    
    //设置右边两个按钮
    UIBarButtonItem *settingsItem = [UIBarButtonItem buttonItemCreate:self andImage:@"mine-setting-icon" andHighlightedImage:@"mine-setting-icon-click" andAction:@selector(tagClickSetting)];
    
    UIBarButtonItem *moonItem = [UIBarButtonItem buttonItemCreate:self andImage:@"mine-moon-icon" andHighlightedImage:@"mine-moon-icon-click" andAction:@selector(tagClickMoon)];
    
    
    self.navigationItem.rightBarButtonItems = @[settingsItem,moonItem];
    
    //添加footView
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor redColor];
    view.height = 100;
    self.tableView.tableFooterView = view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"me"];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"me"];
    }
    
    
    //设置数据
    if(indexPath.section == 0)
    {
        cell.textLabel.text = @"登录/注册";
        cell.imageView.image = [UIImage imageNamed:@"defaultUserIcon"];
    } else
    {
        cell.textLabel.text = @"离线下载";
    }
    
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    

    
    return cell;
}

#pragma mark - 左上角内容
//点击设置
- (void)tagClickSetting
{
    NSLogFunc
    
    //跳入到设置界面
    XWSettingTableController *settigs = [[XWSettingTableController alloc]init];
    
    settigs.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:settigs animated:YES];
    
}

//点击月亮
- (void)tagClickMoon
{
    NSLogFunc
}

@end
