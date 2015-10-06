//
//  XWAddTagViewController.m
//  百思不得姐
//
//  Created by longxianwen on 15/10/5.
//  Copyright © 2015年 longxianwen. All rights reserved.
//  添加标签

#import "XWAddTagViewController.h"
#import "XWTagButton.h"

@interface XWAddTagViewController ()<UITextFieldDelegate>

/** 用来容纳所有按钮和文本框 */
@property (nonatomic, weak) UIView *contentView;

/**文本输入框*/
@property (nonatomic,strong) UITextField *textField;

/** 提醒按钮 */
@property (nonatomic, weak) UIButton *tipButton;

/** 存放所有的标签按钮 */
@property (nonatomic, strong) NSMutableArray *tagButtons;

@end

@implementation XWAddTagViewController

- (NSMutableArray *)tagButtons
{
    if (!_tagButtons) {
        _tagButtons = [NSMutableArray array];
    }
    return _tagButtons;
}

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
    textField.width = self.contentView.width;
    textField.height = XWTagH;
    textField.backgroundColor = [UIColor greenColor];
    textField.font = [UIFont systemFontOfSize:15];
    textField.placeholderColor = [UIColor grayColor];
    textField.placeholder = @"多个标签用逗号或者换行隔开";
    textField.delegate = self;
    
    [textField addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
    
    self.textField = textField;
    
    [self.contentView addSubview:textField];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //弹出键盘
    [self.textField becomeFirstResponder];
}

#pragma mark - 标签提示
- (void)textDidChange
{
    if(self.textField.hasText)
    {
        NSString *text = self.textField.text;
        NSString *lastChar = [text substringFromIndex:text.length - 1];
        if([lastChar isEqualToString:@","]||[lastChar isEqualToString:@"，"]) //最后输入的字符是,号
        {
            //去掉最后一个逗号
            self.textField.text = [self.textField.text substringToIndex:text.length - 1];
            // 点击提醒按钮
            [self tipClick];
        } else  //最后输入的字符不是逗号
        {
            //排版文本框
            [self setupTextFieldFrame];
            
            self.tipButton.hidden = NO;
            
            [self.tipButton setTitle:[NSString stringWithFormat:@"添加标签：%@", self.textField.text] forState:UIControlStateNormal];
        }

    } else
    {
        self.tipButton.hidden = YES;
    }
}

#pragma mark - 添加标签
- (void)tipClick
{
    if(self.textField.hasText == NO) return;
        
    //创建一个标签按钮
    XWTagButton *newTagButton = [XWTagButton buttonWithType:UIButtonTypeCustom];
    [newTagButton setTitle:self.textField.text forState:UIControlStateNormal];
    [self.contentView addSubview:newTagButton];
    
    //设置标签按钮位置
    [self setupTagButtonFrame:newTagButton referenceTagButton:self.tagButtons.lastObject];
    
    //添加标签按钮到数组
    [self.tagButtons addObject:newTagButton];
    
    //设置文本框
    self.textField.text = nil;
    [self setupTextFieldFrame];
    
    //隐藏标签提示
    self.tipButton.hidden = YES;
}

#pragma mark - 布局

//排布文本框
-(void)setupTextFieldFrame
{
    CGFloat textW = [self.textField.text sizeWithAttributes:@{NSFontAttributeName:self.textField.font}].width;
    
    textW = MAX(100, textW);
    
    XWTagButton *lastTagButton = self.tagButtons.lastObject;
    CGFloat leftWidth = CGRectGetMaxX(lastTagButton.frame) + XWCommonSmallMargin;
    CGFloat rightWidth = self.contentView.width - leftWidth;
    
    if(rightWidth >= textW )
    {
        self.textField.x = leftWidth;
        self.textField.y = lastTagButton.y;
    } else
    {
        self.textField.x = 0;
        self.textField.y = CGRectGetMaxY(lastTagButton.frame) + XWCommonSmallMargin;
    }
    
    //标签提示按钮位置
    self.tipButton.y = CGRectGetMaxY(self.textField.frame) + XWCommonSmallMargin;
}

//排布标签按钮
- (void)setupTagButtonFrame:(XWTagButton *)tagButton referenceTagButton:(XWTagButton *)referenceTagButton
{
    // 没有参照按钮（tagButton是第一个标签按钮）
    if (referenceTagButton == nil) {
        tagButton.x = 0;
        tagButton.y = 0;
        return;
    }
    
    // tagButton不是第一个标签按钮
    // 左边的总宽度
    CGFloat leftWidth = CGRectGetMaxX(referenceTagButton.frame) + XWCommonSmallMargin;
    CGFloat rightWidth = self.contentView.width - leftWidth;
    
    if(rightWidth >= tagButton.width)  //添加到本行的其他标签按钮的后面
    {
        tagButton.x = leftWidth;
        tagButton.y = referenceTagButton.y;
    } else  //换行
    {
        tagButton.x = 0;
        tagButton.y = CGRectGetMaxY(referenceTagButton.frame) + XWCommonSmallMargin;
    }
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

#pragma mark - <UITextFieldDelegate>
/**
 点击右下角return按钮就会调用这个方法
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self tipClick];
    return YES;
}

@end
