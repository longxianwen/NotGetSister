//
//  XWRecommendViewController.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/5.

//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  推荐关注页面

#import "XWRecommendViewController.h"
#import "XWRecommendCategoryCell.h"
#import "XWRecommendUserCell.h"
#import <AFNetworking/AFNetworking.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <MJExtension/MJExtension.h>
#import "XWRecommendCategoryModel.h"
#import <MJRefresh/MJRefresh.h>
#import "XWRecommendUserModel.h"

@interface XWRecommendViewController ()<UITableViewDataSource,UITableViewDelegate>
/**左边类别表格*/
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/**右边用户表格*/
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

/** 请求管理者 */
@property (nonatomic, weak) AFHTTPSessionManager *manager;

/** 左边类别数据 */
@property (nonatomic, strong) NSArray *categoriesArr;

@end

@implementation XWRecommendViewController

static NSString* const XWCategoryId = @"categoryCell";
static NSString* const XWUserId = @"userCell";

#pragma mark - lazy(懒加载)
- (AFHTTPSessionManager *)manager
{
    if(!_manager)
    {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // UITableView的初始化
    [self setupControllerView];
    
    //设置刷新
    [self setupRefresh];
    
    //加载左边类别数据
    [self loadCategories];
}

- (void)setupControllerView
{
    //设置标题
    self.navigationItem.title = @"推荐关注";
    
    //设置背景颜色
    self.view.backgroundColor = XWGlobalBg;
    
    //设置左边表格
    //取消系统自动更改内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIEdgeInsets inset = UIEdgeInsetsMake(XWNavBarMaxY, 0, 0, 0);
    self.categoryTableView.contentInset = inset;
    //指定滚动条在scrollerView中的位置
    self.categoryTableView.scrollIndicatorInsets = inset;
    //注册左边category cell
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([XWRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:XWCategoryId];
    self.categoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //设置右边表格
    self.userTableView.rowHeight = 70;
    self.userTableView.contentInset = inset;
    self.userTableView.scrollIndicatorInsets = inset;
    //注册右边user cell
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([XWRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:XWUserId];
    self.userTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setupRefresh
{
    //设置下拉刷新
    self.userTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    //设置上拉刷新
    self.userTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
}

#pragma mark - 加载左边类别数据
- (void)loadCategories
{
    //弹框提示
    [SVProgressHUD show];
    
    //设置请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    //请求服务器获取数据
    XWWeakSelf;
    [self.manager GET:XWRequestURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        
        XWWriteToPlist(responseObject, @"catagory");
        
        weakSelf.categoriesArr = [XWRecommendCategoryModel objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.categoryTableView reloadData];
        
        //默认选中
        [weakSelf.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        //刷新右边数据
        [self.userTableView.header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //如果请求失败,则关闭对话框
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - 加载右边用户数据(下拉)
- (void)loadNewUsers
{
    //设置请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    
    XWRecommendCategoryModel *selectedCategory = self.categoriesArr[self.categoryTableView.indexPathForSelectedRow.row];
    // 左边选中的类别的ID
    params[@"category_id"] = selectedCategory.ID;
    
    //请求服务器获取数据
    XWWeakSelf;
    [self.manager GET:XWRequestURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        // 重置页码为1（设置默认页码）
        selectedCategory.page = 1;
  
        //存储右边表格数据
        selectedCategory.usersArr = [XWRecommendUserModel objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //存储总数
        selectedCategory.total = [responseObject[@"total"] integerValue];
        
        //刷新右边表格
        [weakSelf.userTableView reloadData];
//        XWWriteToPlist(responseObject, @"users下");
        
        //结束刷新
        [weakSelf.userTableView.header endRefreshing];
        
        if (selectedCategory.usersArr.count >= selectedCategory.total) {
            // 这组的所有用户数据已经加载完毕
            weakSelf.userTableView.footer.hidden = YES;
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [weakSelf.userTableView.header endRefreshing];
    }];
}

- (void)loadMoreUsers
{
    
    //设置请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    
    XWRecommendCategoryModel *selectedCategory = self.categoriesArr[self.categoryTableView.indexPathForSelectedRow.row];
    // 左边选中的类别的ID
    params[@"category_id"] = selectedCategory.ID;
    
    //设置局部变量保存下一页页码
    NSInteger page = selectedCategory.page + 1;
    params[@"page"] = @(page);
    
    //请求服务器获取数据
    XWWeakSelf;
    [self.manager GET:XWRequestURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        // 设置当前的最新页码
        selectedCategory.page = page;
        
//        XWWriteToPlist(responseObject, @"users上");
        
        NSArray *newArr = [XWRecommendUserModel objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //存储总数
         selectedCategory.total = [responseObject[@"total"] integerValue];
        
        //在原来数据基础上追加上新数据
        [selectedCategory.usersArr addObjectsFromArray:newArr];
        
        [weakSelf.userTableView reloadData];
        
        if(selectedCategory.usersArr.count >= selectedCategory.total)
        {
            //这组数据已经加载完毕
            self.userTableView.footer.hidden = YES;
        } else //还有下一页数据
        {
            //结束刷新
            [weakSelf.userTableView.footer endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [weakSelf.userTableView.footer endRefreshing];
    }];
    
}


#pragma mark -<UITableViewDataSource>
//tableView参数用于区分不同的表格
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.categoryTableView)  //如果是左边类别表格
    {
        return self.categoriesArr.count;
    }
    
    //确定左边选中类别
    NSInteger row =  self.categoryTableView.indexPathForSelectedRow.row;
    XWRecommendCategoryModel *category = self.categoriesArr[row];
    
    return category.usersArr.count;  //右边用户表格行数
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //创建cell
    if(tableView == self.categoryTableView)  //左边类别cell
    {
        XWRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:XWCategoryId];
        
        cell.category = self.categoriesArr[indexPath.row];
        
        return cell;
    } else  //右边用户cell
    {
        XWRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:XWUserId];
        
        //确定左边选中类别
        NSInteger selectedCategoryRow =  self.categoryTableView.indexPathForSelectedRow.row;
        XWRecommendCategoryModel *category = self.categoriesArr[selectedCategoryRow];
        
        //设置右边用户表格数据
        cell.user = category.usersArr[indexPath.row];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    if(tableView == self.categoryTableView)
    {
        //得到当前选中的类别
        XWRecommendCategoryModel *selectedCategory =  self.categoriesArr[indexPath.row];
        
        // 刷新右边的用户表格 👉 →
        // （MJRefresh的默认做法：表格有数据，就会自动显示footer，表格没有数据，就会自动隐藏footer）
        [self.userTableView reloadData];
        
        // 判断footer是否应该显示
        if (selectedCategory.usersArr.count >= selectedCategory.total) {
            // 这组的所有用户数据已经加载完毕
            self.userTableView.footer.hidden = YES;
        }
        
        if(selectedCategory.usersArr.count == 0)  //从未加载过用户数据
        {
            //加载右边数据
            [self.userTableView.header beginRefreshing];
        }
        
    } else
    {
        XWLog(@"右边%ld行被点击",indexPath.row);
    }
}
@end
