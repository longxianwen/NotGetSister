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
#import <MJRefresh/MJRefresh.h>
#import "XWFooterView.h"
#import "XWTopicCell.h"

@interface XWAllViewController ()

/**请求管理者*/
@property (nonatomic,strong) AFHTTPSessionManager *manager;

/**保存数据*/
@property (nonatomic,strong) NSMutableArray *arrTopic;

/**苹果自带下拉刷新组件*/
@property (nonatomic,strong) UIRefreshControl *refresh;

/** 用来加载下一页数据 */
@property (nonatomic, copy) NSString *maxtime;

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
    //设置背景颜色
    self.tableView.backgroundColor = XWGlobalBg;
    
    //设置内边距
    self.tableView.contentInset = UIEdgeInsetsMake(XWNavBarMaxY + XWTitleViewH, 0, XWTabBarH, 0);
    
    //指定滚动条在scrollerView中的位置
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    //去掉所有分隔线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XWTopicCell class]) bundle:nil] forCellReuseIdentifier:XWTopicCellId];
    
    //设置cell的高度
//    self.tableView.rowHeight = 500;
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
//    MJRefreshFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
//  footer.appearencePercentTriggerAutoRefresh = 0.5;
    
    //自定义上拉刷新:
    
    XWFooterView *footer = [XWFooterView  footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    self.tableView.footer = footer;
}

#pragma mark - 请求服务器获取数据(下拉刷新)
- (void)loadNewTopics
{
    //取消以前任务
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //设置请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @1;
    
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
    params[@"type"] = @1;
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
    NSLogFunc;
    XWTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:XWTopicCellId];
    
    //设置数据
    cell.topic = self.arrTopic[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //顶部内容高度
    CGFloat cellHeight = XWTopicTextY;
    
    //计算文字高度
    XWTopic *topic = self.arrTopic[indexPath.row];
    
    CGFloat textW = XWScreenW - 2 * XWCommMargin;
    
    //第一个参数:限制内容的范围
    //第二个参数:从内容什么位置开始算
    //第三个参数:内容字体大小
    //第四个参数:上下文
    CGFloat textH = [topic.text boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height;
    
    cellHeight += textH + XWCommMargin;
    
    //中间内容的高度
    if(topic.type != XWTopicTypeWord)
    {
        CGFloat contentW = textW;
        // 图片的高度 * 内容的宽度 / 图片的宽度(等比缩放,图片显示真实高度)
        CGFloat contentH = topic.height * contentW / topic.width;
        cellHeight += contentH + XWCommMargin;
    }
    
    //底部工具条的高度
    cellHeight += XWTopicToolbarH + XWCommMargin + XWCommMargin;
    
    return cellHeight;
}

@end
