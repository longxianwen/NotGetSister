//
//  XWMeController.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/1.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  我

#import "XWMeController.h"
#import "XWSettingTableController.h"
#import "XWMeCell.h"

@interface XWMeController ()

@end

@implementation XWMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //导航栏的初始化
    [self setupNav];
    
    //TableView的初始化
    [self setupTableView];
    
}

#pragma mark -m 导航栏的初始化
- (void)setupNav
{
    self.navigationItem.title = @"我的";
    
    //设置右边两个按钮
    UIBarButtonItem *settingsItem = [UIBarButtonItem buttonItemCreate:self andImage:@"mine-setting-icon" andHighlightedImage:@"mine-setting-icon-click" andAction:@selector(tagClickSetting)];
    
    UIBarButtonItem *moonItem = [UIBarButtonItem buttonItemCreate:self andImage:@"mine-moon-icon" andHighlightedImage:@"mine-moon-icon-click" andAction:@selector(tagClickMoon)];
    
    
    self.navigationItem.rightBarButtonItems = @[settingsItem,moonItem];
}

#pragma mark -m TableView的初始化
/**cell循环利用标识*/
static NSString * const XWMeCellId = @"me";
- (void)setupTableView
{
    //设置背景颜色
    self.tableView.backgroundColor = XWGlobalBg;
    
    //注册cell
    [self.tableView registerClass:[XWMeCell class] forCellReuseIdentifier:XWMeCellId];
    
    //距离顶部间距
    self.tableView.contentInset = UIEdgeInsetsMake(XWCommMargin - 35, 0, 0, 0);
    
    //调整组与组之间的距离
    self.tableView.sectionFooterHeight = XWCommMargin;
    self.tableView.sectionHeaderHeight = 0;
    
    //添加footView
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor redColor];
    view.height = 100;
    self.tableView.tableFooterView = view;
}

#pragma mark - <UITableViewDataSource>
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
    
    XWMeCell *cell = [tableView dequeueReusableCellWithIdentifier:XWMeCellId];
    
    //设置数据
    if(indexPath.section == 0)
    {
        cell.textLabel.text = @"登录/注册";
        cell.imageView.image = [UIImage imageNamed:@"defaultUserIcon"];
    } else
    {
        cell.textLabel.text = @"离线下载";
    }    

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
