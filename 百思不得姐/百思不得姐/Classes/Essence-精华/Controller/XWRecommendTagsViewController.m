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
#import <SVProgressHUD/SVProgressHUD.h>
#import "XWRecommendTag.h"

@interface XWRecommendTagsViewController ()

/**<保存标签数据*/
@property (nonatomic,copy) NSArray *tagArray;

/**<请求管理者*/
@property (nonatomic,weak) AFHTTPSessionManager * manager;

@end

@implementation XWRecommendTagsViewController


/**< lazy */
- (AFHTTPSessionManager *)manager
{
    if(!_manager)
    {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //表格的初始化
    [self setupTableView];
    
    //加载表格数据
    [self loadRecommendTags];

}

/**<cell循环利用标识*/
static NSString * const XWTagCellId = @"tag";
#pragma mark -m 表格的初始化
- (void)setupTableView
{
    self.navigationItem.title = @"推荐标签";
    self.view.backgroundColor = XWGlobalBg;
    
    //设置表格分隔线为none
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //设置行高
    self.tableView.rowHeight = 70;
    
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XWRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:XWTagCellId];
}

#pragma mark -m 加载表格数据
- (void)loadRecommendTags
{
    
    [SVProgressHUD show];
    
    //设置请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    //请求服务器获取数据
     XWWeakSelf
    
    [self.manager GET:XWRequestURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if(responseObject == nil)
        {
            // 关闭弹框
            [SVProgressHUD showErrorWithStatus:@"加载标签数据失败"];
            return ;
        }
        
        weakSelf.tagArray = [XWRecommendTag objectArrayWithKeyValuesArray:responseObject];
        
        //刷新表格数据
        [weakSelf.tableView reloadData];
        
        //关闭弹窗
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        //取消请求
        if(error.code == NSURLErrorCancelled) return ;
        
        //请求超时
        if(error.code == NSURLErrorTimedOut)
        {
            [SVProgressHUD showErrorWithStatus:@"加载标签超时,请稍后再试..!"];
        } else
        {
            //请求失败
            [SVProgressHUD showErrorWithStatus:@"加载标签数据失败!"];
        }
        
    }];
}


- (void)dealloc
{
    XWLog(@"%s",__func__);
    
    // 停止请求
    [self.manager invalidateSessionCancelingTasks:YES];
    
    [SVProgressHUD dismiss];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tagArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    XWRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:XWTagCellId];
    
    cell.recommendTag = self.tagArray[indexPath.row];
    
    return cell;
}

#pragma mark - <UITableViewDelegate>

@end
