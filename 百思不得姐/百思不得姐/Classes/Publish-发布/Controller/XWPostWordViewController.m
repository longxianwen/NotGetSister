//
//  XWPostWordViewController.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/12.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  发段子

#import "XWPostWordViewController.h"
#import "XWPlaceholderTextView.h"

@interface XWPostWordViewController ()

/**文本输入框*/
@property (nonatomic,strong) XWPlaceholderTextView *placeholderTextView;

@end

@implementation XWPostWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setupNav];
    
    [self setupTextView];
    
}

//顶部导航栏相关
- (void)setupNav
{
    self.navigationItem.title = @"发表文字";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
}

//设置文本输入框
- (void)setupTextView
{
    XWPlaceholderTextView *placeholderTextView = [[XWPlaceholderTextView alloc]init];
    
    
    placeholderTextView.frame = self.view.bounds;
    //默认占位文字
    placeholderTextView.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    self.placeholderTextView = placeholderTextView;
    
    [self.view addSubview:placeholderTextView];
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
