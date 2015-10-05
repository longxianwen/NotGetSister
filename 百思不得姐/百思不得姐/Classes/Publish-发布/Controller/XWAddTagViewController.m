//
//  XWAddTagViewController.m
//  百思不得姐
//
//  Created by longxianwen on 15/10/5.
//  Copyright © 2015年 longxianwen. All rights reserved.
//  添加标签

#import "XWAddTagViewController.h"

@interface XWAddTagViewController ()


/**文本输入框*/
@property (nonatomic,strong) UITextField *textField;

@end

@implementation XWAddTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置背景色
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNav];
    
    //设置文本输入框
    [self setupTextField];
}

- (void)setupNav
{
    self.title = @"添加标签";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
}

- (void)setupTextField
{
    UITextField *textField = [[UITextField alloc]init];
    textField.x = XWCommonSmallMargin;
    textField.width = self.view.width - 2 * textField.x;
    textField.height = XWTagH;
    textField.y = XWNavBarMaxY + XWCommonSmallMargin;
    
    textField.font = [UIFont systemFontOfSize:15];
    
    textField.placeholderColor = [UIColor grayColor];
    
    textField.placeholder = @"多个标签用逗号或者换行隔开";
    self.textField = textField;
    
    [self.view addSubview:textField];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //弹出键盘
    [self.textField becomeFirstResponder];
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.textField resignFirstResponder];
}

- (void)done
{
    //添加标签
    NSLogFunc;
}

@end
