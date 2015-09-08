//
//  XWSquareWebViewController.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/8.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  超链接页面。。

#import "XWSquareWebViewController.h"

@interface XWSquareWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardItem;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation XWSquareWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = self.squareButton.name;
    
    //加载网页
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.squareButton.url]]];
    
    //设置背景色
    self.webView.backgroundColor = XWGlobalBg;
    
    //设置距离上方内边距
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
}

//后退
- (IBAction)back:(UIBarButtonItem *)sender {
    [self.webView goBack];
}

//前进
- (IBAction)forward:(id)sender {
    [self.webView goForward];
}

//刷新
- (IBAction)refresh:(UIBarButtonItem *)sender {
    [self.webView reload];
}

//页面加载完毕会调用
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.backItem.enabled = webView.canGoBack;
    self.forwardItem.enabled = webView.canGoForward;
}



@end
