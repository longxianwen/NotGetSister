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

@interface XWPublishViewController ()
/**标题*/
@property (nonatomic,strong) UIImageView *sloganView;

/** 动画时间 */
@property (nonatomic, strong) NSArray *times;

/**测试动画控件*/
@property (nonatomic,strong) UISwitch *s;
@end

@implementation XWPublishViewController

/**
 *  lazy
 */
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //为xib添加按钮子控件
    [self setupButtons];
    //为xib添加标语子控件
    [self setupSloganView];
    
    self.s = [[UISwitch alloc]init];
    self.s.on = YES;
    [self.view addSubview:self.s];
    
    NSLog(@"%@",NSStringFromCGRect(self.s.frame));
}

#pragma mark -m xib中间添加子控件按钮
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
        [self.view addSubview:button];
        
        //设置按钮内容
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        
        
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

#pragma mark -m xib上面添加子控件标语
- (void)setupSloganView
{
    UIImageView *sloganView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    
    //设置位置
    sloganView.y = XWScreenH * 0.1 - XWScreenH;
    sloganView.centerX = XWScreenW * 0.5;
    
    [self.view addSubview:sloganView];
    
    //设置动画
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    anim.toValue = [NSValue valueWithCGRect:CGRectMake(sloganView.x, XWScreenH * 0.1, sloganView.width, sloganView.height)];
    anim.springSpeed = 10;
    anim.springBounciness = 10;
    //设置定动画执行时间
    anim.beginTime = CACurrentMediaTime() + [[self.times lastObject] doubleValue];
    [sloganView pop_addAnimation:anim forKey:nil];
}


- (IBAction)cancel:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
    
//    [self dismissViewControllerAnimated:YES completion:nil];
    //利用pop执行动画
//    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
//    anim.fromValue = [NSValue valueWithCGPoint:CGPointZero];
//    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
//    anim.duration = 1.0;
//    
//    [self.s pop_addAnimation:anim forKey:nil ];
//    NSLog(@"%@",NSStringFromCGRect(self.s.frame));
    
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    anim.fromValue = [NSValue valueWithCGPoint:CGPointZero];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
    anim.springSpeed = 10;
    anim.springBounciness = 10;
    [self.s pop_addAnimation:anim forKey:nil];
    NSLog(@"%@",NSStringFromCGRect(self.s.frame));
    
}

@end
