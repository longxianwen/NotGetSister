//
//  XWSettingTableController.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/2.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  设置

#import "XWSettingTableController.h"
#import <SDWebImage/SDImageCache.h>
#import "NSString+XWExtension.h"

@implementation XWSettingTableController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";
    
    //TableView的初始化
    [self setupTableView];
    
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject];
    
    NSString *file = [caches stringByAppendingPathComponent:@"default"];
//    XWLog(@"%zd",@"/Users/longxianwen/Desktop/第3期(广州)2015年07月08日iOS大神班-0825.xls".getfileSize);
    XWLog(@"%@",file);
    XWLog(@"%zd",file.getfileSize);
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:XWMeSettingCellId];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:XWMeSettingCellId];
        
        cell.textLabel.text = @"清除缓存";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

#pragma mark -m <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0 && indexPath.row == 0)
    {
        XWLog(@"清除缓存");
    }
}

@end
