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
#import "XWCategoryModel.h"

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
    self.userTableView.contentInset = inset;
    self.userTableView.scrollIndicatorInsets = inset;
    //注册右边user cell
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([XWRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:XWUserId];
    self.userTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
        
//        XWWriteToPlist(responseObject, @"catagory");
        
        weakSelf.categoriesArr = [XWCategoryModel objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.categoryTableView reloadData];
        
        //默认选中
        [weakSelf.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma mark -<UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.categoryTableView)  //如果是左边类别表格
    {
        return self.categoriesArr.count;
    }
    return 25;  //右边用户表格
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //创建cell
    if(tableView == self.categoryTableView)  //左边类别cell
    {
        XWRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:XWCategoryId];
        cell.textLabel.text = [NSString stringWithFormat:@"---%zd", indexPath.row];
        
        cell.category = self.categoriesArr[indexPath.row];
        
        return cell;
    } else  //右边用户cell
    {
        XWRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:XWUserId];
        cell.textLabel.text = [NSString stringWithFormat:@"---%zd", indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.categoryTableView)
    {
        XWLog(@"左边%ld行被点击",indexPath.row);
    } else
    {
        XWLog(@"右边%ld行被点击",indexPath.row);
    }
}
@end
