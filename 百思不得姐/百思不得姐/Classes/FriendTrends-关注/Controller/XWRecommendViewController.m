//
//  XWRecommendViewController.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/5.

//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  推荐关注页面

#import "XWRecommendViewController.h"
#import "XWRecommendCategoryCell.h"

@interface XWRecommendViewController ()<UITableViewDataSource,UITableViewDelegate>
/**左边类别表格*/
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/**右边用户表格*/
@property (weak, nonatomic) IBOutlet UITableView *userTableView;


@end

@implementation XWRecommendViewController

static NSString* const XWCategoryId = @"categoryCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    // 控件的初始化
    [self setupControllerView];
    
    
}

#pragma mark - 控件的初始化
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
    
    //设置右边表格
    self.userTableView.contentInset = inset;
    self.userTableView.scrollIndicatorInsets = inset;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.categoryTableView)  //如果是左边类别表格
    {
        return 15;
    }
    return 25;  //右边用户表格
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"test"];
    
    //创建cell
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"test"];
    }
    
    if(tableView == self.categoryTableView)
    {
        NSString *str = [NSString stringWithFormat:@"左边%ld",indexPath.row];
        cell.textLabel.text = str;
    } else
    {
        NSString *str = [NSString stringWithFormat:@"右边%ld",indexPath.row];
        cell.textLabel.text = str;
    }
    
    return cell;
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
