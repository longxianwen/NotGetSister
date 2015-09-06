//
//  XWTagViewController.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/2.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  推荐标签

#import "XWRecommendTagsViewController.h"

@interface XWRecommendTagsViewController ()

@end

@implementation XWRecommendTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"推荐标签";
    self.view.backgroundColor = XWGlobalBg;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = @"测试数据";
    
    return cell;
}

@end
