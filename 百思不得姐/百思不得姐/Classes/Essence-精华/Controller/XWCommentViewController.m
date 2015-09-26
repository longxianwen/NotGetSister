//
//  XWCommentViewController.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/23.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  评论

#import "XWCommentViewController.h"
#import "XWTopicCell.h"
#import "XWTopicCommentCell.h"
#import "XWTopic.h"
#import <MJRefresh/MJRefresh.h>
#import <MJExtension/MJExtension.h>
#import <AFNetworking.h>
#import "XWComment.h"
#import "XWTopicCommentCell.h"
#import "XWCommentHeaderFooterView.h"


@interface XWCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
//底部工具条底部约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
//表格
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/**暂时存储最热评论*/
@property (nonatomic,strong) XWComment *topComment;

/**请求管理者*/
@property (nonatomic,strong) AFHTTPSessionManager *manager;

/**帖子最新评论数据*/
@property (nonatomic,strong) NSMutableArray *latestComments;

/**帖子最热评论数据*/
@property (nonatomic,strong) NSMutableArray *hotComments;

@end

@implementation XWCommentViewController

#pragma mark - lazy
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (NSMutableArray *)latestComments
{
    if (!_latestComments) {
        _latestComments = [NSMutableArray array];
    }
    return _latestComments;
}

- (NSMutableArray *)hotComments
{
    if (!_hotComments) {
        _hotComments = [NSMutableArray array];
    }
    return _hotComments;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupNav];
    
    [self setupTableView];
    
    [self setupRefresh];
    
    //注册通知--监听键盘
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

static NSString * const XWCommentCellId = @"comment";
static NSString * const XWSectionHeader = @"header";
//tableView的初始化相关
- (void)setupTableView
{
    //注册评论cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XWTopicCommentCell class]) bundle:nil] forCellReuseIdentifier:XWCommentCellId];
    
    //注册section--header
    [self.tableView registerClass:[XWCommentHeaderFooterView class] forHeaderFooterViewReuseIdentifier:XWSectionHeader];
    
    //动态计算cell的高度
    self.tableView.estimatedRowHeight = 100; //估算高度
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.backgroundColor = XWGlobalBg;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //处理模型数据,隐藏最热评论
    if(self.topic.topComment)
    {
        self.topComment = self.topic.topComment;
        
        //不显示最热评论
        self.topic.topComment = nil;
        
        //重新计算cellHeight
        self.topic.cellHeight = 0;
    }
    
    //添加headerView
    XWTopicCell *cell = [XWTopicCell viewFromXib];
    cell.frame = CGRectMake(0, 0, XWScreenW, self.topic.cellHeight);
    cell.topic = self.topic;
    
    //包装cell
    UIView *headerView = [[UIView alloc]init];
    headerView.height = cell.height + 2 * XWCommMargin;
    [headerView addSubview:cell];
    
    self.tableView.tableHeaderView = headerView;
}

//导航栏的初始化
- (void)setupNav
{
    self.navigationItem.title = @"评论";
    
    //设置右边内容
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem buttonItemCreate:self andImage:@"comment_nav_item_share_icon" andHighlightedImage:@"comment_nav_item_share_icon_click" andAction:@selector(clickMore)];
}

#pragma  mark - 下拉/上拉刷新相关
- (void)setupRefresh
{
    //下拉刷新
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    
    // 自动改变透明度
    self.tableView.header.automaticallyChangeAlpha = YES;
    
    [self.tableView.header beginRefreshing];
    
    //上拉刷新
    MJRefreshAutoFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    
    self.tableView.footer = footer;
}

//下拉刷新加载数据
- (void)loadNewTopics
{
    //取消以前任务
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //设置请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @1;
    
    //请求服务器获取数据
    XWWeakSelf;
    
    [self.manager GET:XWRequestURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //字典转模型
//        XWWriteToPlist(responseObject, @"cmt下");
        
        //没有评论数据
        if([responseObject isKindOfClass:[NSArray class]])
        {
            [weakSelf.tableView.header endRefreshing];
            return ;
        }
        
        // 最热评论
        weakSelf.hotComments = [XWComment objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        //最新评论
        weakSelf.latestComments = [XWComment objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        
        [weakSelf.tableView reloadData];
        
        //结束刷新
        [weakSelf.tableView.header endRefreshing];
        
        //如果一页就加载完毕评论数据，就隐藏下拉刷新
        if(self.latestComments.count >= [responseObject[@"total"] intValue])
        {
            weakSelf.tableView.footer.hidden = YES;
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        XWLog(@"请求失败..");
        [weakSelf.tableView.header endRefreshing];
    }];
}

//上拉刷新加载数据
- (void)loadMoreTopics
{
    //发送请求给服务器，获取数据
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    //设置请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"lastcid"] = [self.latestComments.lastObject ID];
    
    XWWeakSelf;
    [manager GET:XWRequestURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
//        XWWriteToPlist(responseObject, @"cmt上");
        NSArray *moreArr = [XWComment objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        //把下一页的数据加到上一页数据的后面
        [weakSelf.latestComments addObjectsFromArray:moreArr];
        
        [weakSelf.tableView reloadData];
        
        //到最后一条数据后，就不需要请求服务器了
        if(self.latestComments.count >= [responseObject[@"total"] intValue])
        {
            //如果到最后一条数据了,就结束刷新
            weakSelf.tableView.footer.hidden = YES;
//            [weakSelf.tableView.footer noticeNoMoreData];
        } else
        {
            //继续刷新
            [weakSelf.tableView.footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        XWLog(@"请求失败..");
        [weakSelf.tableView.header endRefreshing];
    }];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(self.hotComments.count) return 2;
    if(self.latestComments.count) return 1;
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0 && self.hotComments.count)
    {
        return self.hotComments.count;
    }
    return self.latestComments.count;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XWTopicCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:XWCommentCellId];
    
    //设置评论数据
    NSArray *comments = self.latestComments;
    if(indexPath.section == 0 && self.hotComments.count) //最热评论数据
    {
        comments =  self.hotComments;
    }
    cell.comment = comments[indexPath.row];
    
    return cell;
}

//设置分组标题
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //从缓存池中取出组首
    XWCommentHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:XWSectionHeader];
    
    if (section == 0 && self.hotComments.count) {
        header.text = @"最热评论";
    } else {
        header.text = @"最新评论";
    }
    
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //单击时隐藏键盘
    [self.view endEditing:YES];
}

#pragma mark - <UITableViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //拖拽时隐藏键盘
    [self.view endEditing:YES];
}

//监听键盘弹出或者隐藏
- (void)keyboardWillChangeFrame:(NSNotification*)note
{
    self.bottomSpace.constant = XWScreenH - [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //注意动画时间,应该是系统弹出键盘时间
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - 更多
- (void)clickMore
{
    XWLog(@"更多....");
}

- (void)dealloc
{
//    恢复数据
    if (self.topComment) {
        self.topic.topComment = self.topComment;
        self.topic.cellHeight = 0;
    }
    
    //移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
