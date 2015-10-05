//
//  XWPostWordViewController.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/12.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  发段子--发表文字

#import "XWPostWordViewController.h"
#import "XWPlaceholderTextView.h"
#import "XWPostWordToolbar.h"

@interface XWPostWordViewController ()<UITextViewDelegate>

/**文本输入框*/
@property (nonatomic,strong) XWPlaceholderTextView *textView;

/** 工具条 */
@property (nonatomic, weak) XWPostWordToolbar *toolbar;

@end

@implementation XWPostWordViewController

#pragma  mark - 初始化控件
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNav];
    
    [self setupTextView];
    
    //设置底部工具条
    [self setupBottomToolBar];
    
//    //立刻弹出键盘
//    [self.textView becomeFirstResponder];
}

//顶部导航栏相关
- (void)setupNav
{
    self.navigationItem.title = @"发表文字";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    //强制刷新(解决导航条右边按钮设置无效情况)
    [self.navigationController.navigationBar layoutIfNeeded];
}

//设置文本输入框
- (void)setupTextView
{
    XWPlaceholderTextView *textView = [[XWPlaceholderTextView alloc]init];
    
    textView.frame = self.view.bounds;
    //默认占位文字
    textView.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    //使一个控件可以竖直方向可以拖拽
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    
    self.textView = textView;
    
    [self.view addSubview:textView];
}

//设置底部工具条
- (void)setupBottomToolBar
{
    //从xib加载自定义view
    XWPostWordToolbar *toolBar = [XWPostWordToolbar viewFromXib];
    
    //设置自定义view的位置
    toolBar.x = 0;
    toolBar.y = self.view.height - toolBar.height;
    toolBar.width = self.view.width;
    [self.view addSubview:toolBar];
    self.toolbar = toolBar;
    
    //监听键盘的显示或者隐藏
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark - 键盘相关
- (void)keyboardWillChange:(NSNotification *)note
{
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        //底部工具条平移的y值
        CGFloat ty = [note.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue].origin.y - XWScreenH;
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, ty);
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

//控件显示完毕之后在弹出键盘
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //立刻弹出键盘
    [self.textView becomeFirstResponder];
}

#pragma mark - <UITextViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}

#pragma mark - 导航条内容点击
- (void)post
{
    NSLogFunc;
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.textView resignFirstResponder];
}

@end
