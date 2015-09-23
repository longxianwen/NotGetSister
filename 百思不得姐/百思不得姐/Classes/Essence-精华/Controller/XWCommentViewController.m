//
//  XWCommentViewController.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/23.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  评论

#import "XWCommentViewController.h"

@interface XWCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
//底部工具条底部约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
//表格
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation XWCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //导航栏的初始化
    [self setupNav];
    
    [self setupTableView];
    
    //注册通知--监听键盘的弹出和隐藏
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

- (void)setupTableView
{
    
}

- (void)setupNav
{
    self.navigationItem.title = @"评论";
    
    //设置右边内容
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem buttonItemCreate:self andImage:@"comment_nav_item_share_icon" andHighlightedImage:@"comment_nav_item_share_icon_click" andAction:@selector(clickMore)];
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cmt";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    cell.textLabel.text = @"测试数据";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XWLog(@"%ld",indexPath.row);
    //拖拽时隐藏键盘
    [self.view endEditing:YES];
}

#pragma mark - <UITableViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //拖拽时隐藏键盘
    [self.view endEditing:YES];
}

- (void)keyboardWillChangeFrame:(NSNotification*)note
{
    // 工具条平移的距离 == 屏幕高度 - 键盘最终的Y值
    self.bottomSpace.constant = XWScreenH - [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)clickMore
{
    XWLog(@"更多....");
}

- (void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
