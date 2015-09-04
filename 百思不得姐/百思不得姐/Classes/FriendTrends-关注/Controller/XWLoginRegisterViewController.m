//
//  XWLoginRegisterViewController.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/4.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  注册登录

#import "XWLoginRegisterViewController.h"

@interface XWLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIButton *login;

@end

@implementation XWLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //设置按钮圆角
//    self.login.layer.cornerRadius = 5;
//    self.login.layer.masksToBounds = YES;
//    self.login.clipsToBounds = YES;
    
//    [self.login setValue:@5 forKeyPath:@"layer.cornerRadius"];
//    [self.login setValue:@YES forKeyPath:@"layer.masksToBounds"];
    
    
    
    
    
    
    
    
    
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

@end
