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
    
    //设置背景颜色
    self.tableView.backgroundColor = XWGlobalBg;
    
    //设置内边距
    //如果有导航控制器，苹果会自动加上64的内边距,前提是要是第一个控件
//    self.tableView.contentInset = UIEdgeInsetsMake(XWNavBarMaxY, 0, XWTabBarH, 0);
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XWTopicCell class]) bundle:nil] forCellReuseIdentifier:@"topic"];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XWTopicCommentCell class]) bundle:nil] forCellReuseIdentifier:@"cmt"];
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0) return 1;
    if(section == 1) return 5;
    return 10;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0) //帖子cell
    {
        return [tableView dequeueReusableCellWithIdentifier:@"topic"];
    } else //评论cell
    {
        return [tableView dequeueReusableCellWithIdentifier:@"cmt"];
    }
}

//设置每行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0) return 200;
    return 50;
}

//设置分组标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section

{
    if(section == 0) return nil;
    if(section == 0) return @"最热评论";
    return @"最新评论";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    XWLog(@"%ld",indexPath.row);
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
    
    //添加动画原因:避免输入框瞬间弹上去。会显示view的背景色
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
