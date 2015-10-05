//
//  XWPublishViewController.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/9.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  发布模块

#import "XWPublishViewController.h"
#import "XWPublishButton.h"
#import <pop/POP.h>
#import "XWPostWordViewController.h"
#import "XWNavigationController.h"

@interface XWPublishViewController ()
/**标题*/
@property (nonatomic,strong) UIImageView *sloganView;

/** 动画时间 */
@property (nonatomic, strong) NSArray *times;

/** 发布按钮控件 */
@property (nonatomic, strong) NSMutableArray *publishButtons;
@end

@implementation XWPublishViewController


#pragma mark - 懒加载
- (NSArray *)times
{
    if(!_times)
    {
        CGFloat interval = 0.1; // 时间间隔
        _times = @[@(0 * interval),
                   @(1 * interval),
                   @(2 * interval),
                   @(3 * interval),
                   @(4 * interval),
                   @(5 * interval),
                   @(6 * interval)]; // 标语的动画时间
    }
    return _times;
}

- (NSMutableArray *)publishButtons
{
    if (!_publishButtons) {
        _publishButtons = [NSMutableArray array];
    }
    return _publishButtons;
}

#pragma  mark - 初始化控件
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.userInteractionEnabled = NO;
    
    [self setupButtons];
    [self setupSloganView];

}

//为xib添加按钮子控件
- (void)setupButtons
{
    //按钮数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    //总共有多少个子控件
    NSInteger count = images.count;
    //每行有多少个子控件
    NSInteger maxColsCount = 3;
    //总共有多少行--分页公式
    NSInteger maxRowsCount = (count + maxColsCount - 1) / maxColsCount;
    
    //设置按钮的w,h,x,y
    CGFloat bottonW = XWScreenW / maxColsCount;
    CGFloat bottomH = bottonW * 0.85;
    CGFloat bottomStartY = (XWScreenH - maxRowsCount * bottomH ) * 0.5;
    
    for (int i = 0; i < count; i++) {

        CGFloat buttonX = bottonW * (i % maxColsCount);
        CGFloat buttonY = bottomH * (i / maxColsCount) + bottomStartY;
        
        //添加按钮
        XWPublishButton *button = [[XWPublishButton alloc]init];
        button.width = -1; // 按钮的尺寸为0，还是能看见文字缩成一个点，设置按钮的尺寸为负数，那么就看不见文字了
        
        [button addTarget:self action:@selector(publishClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        //设置按钮内容
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        
        
        //添加进按钮进数组
        [self.publishButtons addObject:button];
        
        
        //设置动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonY - XWScreenH, bottonW, bottomH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonY, bottonW, bottomH)];
        anim.springSpeed = 10;
        anim.springBounciness = 10;
        
        //设置定动画执行时间
        anim.beginTime = CACurrentMediaTime() + [self.times[i] doubleValue];
        [button pop_addAnimation:anim forKey:nil];
    }
    
}

//为xib添加标语子控件
- (void)setupSloganView
{
    UIImageView *sloganView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    
    //设置位置
    sloganView.y = XWScreenH * 0.1 - XWScreenH;
    sloganView.centerX = XWScreenW * 0.5;
    
    [self.view addSubview:sloganView];
    self.sloganView = sloganView;
    
    //设置动画
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    anim.toValue = [NSValue valueWithCGRect:CGRectMake(sloganView.x, XWScreenH * 0.1, sloganView.width, sloganView.height)];
    anim.springSpeed = 10;
    anim.springBounciness = 10;
    //设置定动画执行时间
    anim.beginTime = CACurrentMediaTime() + [[self.times lastObject] doubleValue];
    
    XWWeakSelf;
    [anim setCompletionBlock:^(POPAnimation * anim, BOOL finished) {
        weakSelf.view.userInteractionEnabled = YES;
    }];
    [sloganView pop_addAnimation:anim forKey:nil];
}

#pragma mark - 发布按钮点击
/**
 *  结束是否执行任务
 *
 *  @param task block任务
 */
- (void)exit:(void(^)())task
{
    //禁止与用于交互
    self.view.userInteractionEnabled = NO;
    
    //让按钮执行动画
    for (int i = 0; i < self.publishButtons.count; i++) {
        XWPublishButton *button = self.publishButtons[i];
        
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        anim.toValue = @(button.layer.position.y + XWScreenH);
        anim.beginTime = CACurrentMediaTime() + [self.times[i]doubleValue];
        [button pop_addAnimation:anim forKey:nil];
    }
    
    //让标题执行动画
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anim.toValue = @(self.sloganView.layer.position.y + XWScreenH);
    anim.beginTime = CACurrentMediaTime() + [[self.times lastObject] doubleValue];
    
    //动画结束干些什么
    XWWeakSelf;
    [anim setCompletionBlock:^(POPAnimation * anim, BOOL finished) {
        
        //在这里发布控制器已经死了dismiss(不在窗口上)了
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
        
        //执行任务
        !task?:task();
        
    }];
    
    [self.sloganView pop_addAnimation:anim forKey:nil];
}

//发布按钮点击
- (void)publishClick:(XWPublishButton*)button
{
    [self exit:^{
        NSInteger index = [self.publishButtons indexOfObject:button];
        XWPublishButton *button =  self.publishButtons[index];
        switch (index) {
            case 0:
                XWLog(@"%@",button.titleLabel.text);
                break;
            case 1:
                XWLog(@"%@",button.titleLabel.text);
                break;
            case 2:
            {
                //modal发段子控制器
                XWPostWordViewController *pustWord = [[XWPostWordViewController alloc]init];
                
                [self.view.window.rootViewController presentViewController:[[XWNavigationController alloc]initWithRootViewController:pustWord] animated:YES completion:nil];
                break;
            }
            case 3:
                XWLog(@"%@",button.titleLabel.text);
                break;
            case 4:
                XWLog(@"%@",button.titleLabel.text);
                break;
            case 5:
                XWLog(@"%@",button.titleLabel.text);
                break;
            default:
                break;
        }
    }];
}


#pragma mark - 取消
- (IBAction)cancel{
    
    [self exit:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self exit:nil];
    
}

- (void)dealloc{
//    NSLogFunc;
}

@end
