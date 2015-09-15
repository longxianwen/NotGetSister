//
//  XWPictureViewController.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/15.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  图片

#import "XWPictureViewController.h"

@implementation XWPictureViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    NSLogFunc;
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
