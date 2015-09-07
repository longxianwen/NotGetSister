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
/**<左边类别表格*/
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

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
    
    //注册左边category cell
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([XWRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:XWCategoryId];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XWRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:XWCategoryId];
    
    //设置数据
    
    cell.textLabel.text = @"数据";
    
    return cell;
}



@end
