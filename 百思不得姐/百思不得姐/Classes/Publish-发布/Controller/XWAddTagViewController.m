//
//  XWAddTagViewController.m
//  百思不得姐
//
//  Created by longxianwen on 15/10/5.
//  Copyright © 2015年 longxianwen. All rights reserved.
//  添加标签

#import "XWAddTagViewController.h"

@interface XWAddTagViewController ()

/** 用来容纳所有按钮和文本框 */
@property (nonatomic, weak) UIView *contentView;

/**文本输入框*/
@property (nonatomic,strong) UITextField *textField;

/** 提醒按钮 */
@property (nonatomic, weak) UIButton *tipButton;

@end

@implementation XWAddTagViewController

- (UIButton *)tipButton
{
    if(!_tipButton)
    {
        UIButton *tipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        tipButton.width = self.contentView.width;
        tipButton.height = XWTagH;
        tipButton.x = 0;
        
        tipButton.backgroundColor = XWTagBgColor;
        tipButton.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [tipButton addTarget:self action:@selector(tipClick) forControlEvents:UIControlEventTouchUpInside];
        
        //设置按钮文字位置
        tipButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        //设置距离左边的间距
        tipButton.contentEdgeInsets = UIEdgeInsetsMake(0, XWCommonSmallMargin, 0, 0);
        
        [self.contentView addSubview:tipButton];
        
        _tipButton = tipButton;
    }
    
    return _tipButton;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置背景色
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNav];
    
    [self setupContentView];
    
    //设置文本输入框
    [self setupTextField];
}

- (void)setupNav
{
    self.title = @"添加标签";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
}

- (void)setupContentView
{
    UIView *contentView = [[UIView alloc]init];
    contentView.x = XWCommonSmallMargin;
    contentView.y = XWNavBarMaxY + XWCommonSmallMargin;
    contentView.width = self.view.width - 2 * contentView.x;
    contentView.height = self.view.height;
    contentView.backgroundColor = [UIColor grayColor];
    
    self.contentView = contentView;
    [self.view addSubview:contentView];
}

- (void)setupTextField
{
    UITextField *textField = [[UITextField alloc]init];
    textField.x = XWCommonSmallMargin;
    textField.width = self.contentView.width - XWCommonSmallMargin;
    textField.height = XWTagH;
    textField.backgroundColor = [UIColor greenColor];
    textField.font = [UIFont systemFontOfSize:15];
    textField.placeholderColor = [UIColor grayColor];
    textField.placeholder = @"多个标签用逗号或者换行隔开";
    
    [textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
    
    self.textField = textField;
    
    [self.contentView addSubview:textField];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //弹出键盘
    [self.textField becomeFirstResponder];
}

- (void)textDidChange
{
    if(self.textField.hasText)
    {
        self.tipButton.hidden = NO;
       //添加标签按钮提示
        self.tipButton.y = CGRectGetMaxY(self.textField.frame) + XWCommonSmallMargin;
        
        [self.tipButton setTitle:[NSString stringWithFormat:@"添加标签：%@", self.textField.text] forState:UIControlStateNormal];
    } else
    {
        self.tipButton.hidden = YES;
    }
}

- (void)tipClick
{
    NSLogFunc;
}

#pragma mark - 导航栏点击

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
