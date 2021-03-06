//
//  XWTopicViewController.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/15.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  全部

#import "XWTopicViewController.h"
#import "XWPictureViewController.h"
#import "XWVideoViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "XWTopic.h"
#import <MJExtension/MJExtension.h>
#import <MJRefresh/MJRefresh.h>
#import "XWFooterView.h"
#import "XWTopicCell.h"
#import "XWCommentViewController.h"
#import "XWNewController.h"

@interface XWTopicViewController ()

/**请求管理者*/
@property (nonatomic,strong) AFHTTPSessionManager *manager;

/**保存数据*/
@property (nonatomic,strong) NSMutableArray *arrTopic;

/**苹果自带下拉刷新组件*/
@property (nonatomic,strong) UIRefreshControl *refresh;

/** 用来加载下一页数据 */
@property (nonatomic, copy) NSString *maxtime;

//点语法提示
- (NSString *)aParam;

@end

@implementation XWTopicViewController

//没有实际意义，只是为了消除警告
- (XWTopicType)type { return 0;}

/**< lazy */
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (NSMutableArray *)arrTopic
{
    if(!_arrTopic)
    {
        _arrTopic = [NSMutableArray array];
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

/**cell循环利用标识*/
static NSString * const XWTopicCellId = @"TopicCell";
- (void)setupTableView
{
    self.tableView.backgroundColor = XWGlobalBg;
    self.tableView.contentInset = UIEdgeInsetsMake(XWNavBarMaxY + XWTitleViewH, 0, XWTabBarH, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //指定滚动条在scrollerView中的位置
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XWTopicCell class]) bundle:nil] forCellReuseIdentifier:XWTopicCellId];
}

#pragma  mark - 下拉刷新
- (void)setupRefresh
{
    //下拉刷新
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    
    // 自动改变透明度
    self.tableView.header.automaticallyChangeAlpha = YES;
    
    //立马进入下拉刷新状态
    [self.tableView.header beginRefreshing];
    
    //上拉刷新
    MJRefreshFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    self.tableView.footer = footer;
}

/**精华还是新帖*/
- (NSString *)aParam
{
    
//    XWLog(@"%@",self.parentViewController);
    if ([self.parentViewController isKindOfClass:[XWNewController class]]) {
        return @"newlist";
    }
    
    return @"list";
}


#pragma mark - 请求服务器获取数据(下拉刷新)
- (void)loadNewTopics
{
    //取消以前任务
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //设置请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.aParam;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    
    //请求服务器获取数据
    XWWeakSelf;
    
    [self.manager GET:XWRequestURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //字典转模型
        weakSelf.arrTopic = [XWTopic objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.tableView reloadData];
        
        //储存maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        //结束刷新
        [weakSelf.tableView.header endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        XWLog(@"请求失败..");
        [weakSelf.tableView.header endRefreshing];
    }];
}

#pragma mark - 请求服务器获取数据(上拉刷新)
- (void) loadMoreTopics
{
    //取消以前任务
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //设置请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(XWTopicTypeAll);
    params[@"maxtime"] = self.maxtime;
    
    //请求服务器获取数据
    
    XWWeakSelf;
    
    [self.manager GET:XWRequestURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //字典转模型
        NSArray *moreTopics = [XWTopic objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //将新数据加载到原来数据的后面
        [weakSelf.arrTopic addObjectsFromArray:moreTopics];
        
        [self.tableView reloadData];
        
        //储存maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        //结束刷新
        [weakSelf.tableView.footer endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        XWLog(@"请求失败..");
        [weakSelf.tableView.footer endRefreshing];
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrTopic.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XWTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:XWTopicCellId];
    
    //设置数据
    cell.topic = self.arrTopic[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XWTopic *topic = self.arrTopic[indexPath.row];
    return topic.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //跳转到评论页面
    XWCommentViewController *cmtView = [[XWCommentViewController alloc]init];
    
    cmtView.topic = self.arrTopic[indexPath.row];
    
    [self.navigationController pushViewController:cmtView animated:YES];
}

@end
