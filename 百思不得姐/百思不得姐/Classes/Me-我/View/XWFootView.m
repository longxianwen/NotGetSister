//
//  XWFootView.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/8.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  我--footerView

#import "XWFootView.h"
#import <AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "XWSquare.h"
#import "XWSquareButton.h"
#import "XWMeController.h"
#import "XWSquareWebViewController.h"

@interface XWFootView ()

/**<方块按钮数据*/
@property (nonatomic,strong) NSArray *squareArr;

@end

@implementation XWFootView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        //向服务器发送请求,获得数据
        //请求参数..
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        
        [params setObject:@"square" forKey:@"a"];
        [params setObject:@"topic" forKey:@"c"];
        
        
        XWWeakSelf;
        [[AFHTTPSessionManager manager]GET:XWRequestURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            
            //字典转模型
            self.squareArr = [XWSquare objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            
            //创建方块按钮
            [weakSelf createSubViews:self.squareArr];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
        
    }
    return self;
}



#pragma mark -m 创建方块按钮
- (void)createSubViews:(NSArray *)squareArr
{
    //每行的列数
    int colsCount = 4;
    
    //设置控件的位置
    CGFloat buttonW = self.width / colsCount;
    CGFloat buttonH = buttonW;
    
    //创建16个按钮
    for (int index = 0; index < squareArr.count; index++) {
        
        CGFloat buttonX = (index % colsCount) * buttonW;
        CGFloat buttony = (index / colsCount) * buttonH;
        
        XWSquareButton *btn = [[XWSquareButton alloc]init];
        btn.tag = index;
        btn.frame = CGRectMake(buttonX, buttony, buttonW, buttonH);
        //监听事件
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
//        btn.backgroundColor = randomColor;
        
        XWSquare *squareButton =  squareArr[index];
        
        //设置数据
        btn.squareButton = squareButton;
        
        //添加按钮
        [self addSubview:btn];
    }
    
    //方案二:通过行数*按钮高度来确定，总高度
    NSUInteger rowsCount = (squareArr.count + colsCount - 1) / colsCount;
    
    self.height = rowsCount * buttonH;
    
    // 重新设置footerView
    UITableView *tableView = (UITableView *)self.superview;
    tableView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.frame));
}

#pragma mark - m 监听按钮点击
- (void)buttonClick:(XWSquareButton *) squareButton
{
    //如果单击按钮不是超链接,则返回
    if ([squareButton.squareButton.url hasPrefix:@"http"] == NO) return;
    
    //跳转到超链接页面
     XWSquareWebViewController *squareWebViewController = [[XWSquareWebViewController alloc]init];
    
    //设置数据
    squareWebViewController.squareButton = squareButton.squareButton;
    
    // 取出当前选中的UITabBarController的子控制器
    UITabBarController *rootVc =  (UITabBarController *)self.window.rootViewController;
    
    UINavigationController *nav = (UINavigationController*)[rootVc selectedViewController];
    
    [nav pushViewController:squareWebViewController animated:YES];
    
}

@end
