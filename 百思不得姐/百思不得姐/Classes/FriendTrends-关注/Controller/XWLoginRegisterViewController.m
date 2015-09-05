//
//  XWLoginRegisterViewController.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/4.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  注册登录

#import "XWLoginRegisterViewController.h"
#import "UIView+XWExtension.h"

@interface XWLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIButton *login;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;

/**<登录界面左边约束*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftSpace;

@end

@implementation XWLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

}

#pragma  mark -m 关闭注册登录
- (IBAction)closeRegisterLogin:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//状态栏颜色修改为白色
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

//登录
- (IBAction)login:(id)sender {
    //隐藏键盘
    [self.view endEditing:YES];
}

//登录还是注册?
- (IBAction)loginOrRegister:(UIButton *)button {
    
    //修改约束
    if(self.leftSpace.constant == 0)
    {
        self.leftSpace.constant = - self.view.width;
        button.selected = YES;
    } else{
        self.leftSpace.constant = 0;
        button.selected = NO;
    }
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

//单击屏幕任何地方的时候隐藏键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLogFunc;
    [self.view endEditing:YES];
}

@end
