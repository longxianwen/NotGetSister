//
//  XWAllViewController.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/15.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  全部

#import "XWAllViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "XWTopic.h"
#import <MJExtension/MJExtension.h>

@interface XWAllViewController ()

/**请求管理者*/
@property (nonatomic,strong) AFHTTPSessionManager *manager;

/**保存数据*/
@property (nonatomic,strong) NSArray *arrTopic;

/**苹果自带下拉刷新组件*/
@property (nonatomic,strong) UIRefreshControl *refresh;

@end

@implementation XWAllViewController

/**< lazy */
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (NSArray *)arrTopic
{
    if(!_arrTopic)
    {
        _arrTopic = [NSArray array];
    }
    return _arrTopic;
}

#pragma mark - 初始化相关
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self setupRefresh];
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

#pragma  mark - 下拉刷新
- (void)setupRefresh
{
    //具有默认尺寸
    UIRefreshControl *refresh = [[UIRefreshControl alloc]init];
    [self loadNewTopics];
    [refresh addTarget:self action:@selector(loadNewTopics) forControlEvents:UIControlEventValueChanged];
    self.refresh = refresh;
    [self.tableView addSubview:refresh];
}

#pragma mark - 请求服务器获取数据
- (void)loadNewTopics
{
    //设置请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @"1";
    
    //请求服务器获取数据
    
    XWWeakSelf;
    
    [self.manager GET:XWRequestURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
//        XWLog(@"%@",responseObject[@"info"]);
        
        //字典转模型
        weakSelf.arrTopic = [XWTopic objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
         [self.tableView reloadData];
        
        //结束刷新
//        [weakSelf.refresh endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        XWLog(@"请求失败..");
//        [weakSelf.refresh endRefreshing];
    }];
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrTopic.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    //设置数据
    XWTopic *topic =  self.arrTopic[indexPath.row];
    
    cell.textLabel.text = topic.name;
    cell.detailTextLabel.text = topic.text;
    //设置头像
    [cell.imageView setHeaderImage:topic.profile_image] ;
    
    return cell;
}

@end
