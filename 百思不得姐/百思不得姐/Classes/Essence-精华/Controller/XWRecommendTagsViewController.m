//
//  XWTagViewController.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/2.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  推荐标签

#import "XWRecommendTagsViewController.h"
#import "XWRecommendTagCell.h"
#import <AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "XWRecommendTag.h"

@interface XWRecommendTagsViewController ()

/**<保存标签数据*/
@property (nonatomic,copy) NSArray *tagArray;

@end

@implementation XWRecommendTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"推荐标签";
    self.view.backgroundColor = XWGlobalBg;
    
    //设置表格分隔线为none
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //设置行高
    self.tableView.rowHeight = 70;
    
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XWRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:@"tag"];
    
    //请求服务器获取数据
    //设置请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        XWLog(@"%@",responseObject);
        
        self.tagArray = [XWRecommendTag objectArrayWithKeyValuesArray:responseObject];
        
        //刷新数据
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        XWLog(@"失败");
    }];

}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tagArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    XWRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tag"];
    
    
    cell.recommendTag = self.tagArray[indexPath.row];
    
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XWRecommendTagCell *cell = (XWRecommendTagCell*)[tableView cellForRowAtIndexPath:indexPath];
    cell.height -= 1;
}

@end
