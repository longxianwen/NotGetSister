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
#import <UIButton+WebCache.h>

@interface XWFootView ()

/**<方块按钮数据*/
@property (nonatomic,strong) NSArray *squareArr;

@end

@implementation XWFootView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        NSLogFunc
        
        self.backgroundColor = [UIColor redColor];
        
        
        //向服务器发送请求,获得数据
        //请求参数..
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        
        [params setObject:@"square" forKey:@"a"];
        [params setObject:@"topic" forKey:@"c"];
        
        
        XWWeakSelf;
        [[AFHTTPSessionManager manager]GET:XWRequestURL parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            
            //字典转模型
            self.squareArr = [XWSquare objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            
            [weakSelf createSubViews:self.squareArr];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
        
    }
    return self;
}




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
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake
                         (buttonX, buttony, buttonW, buttonH)];
        
        btn.backgroundColor = randomColor;
        
        XWSquare *square =  squareArr[index];
        
        [btn setTitle:square.name forState:UIControlStateNormal];
        
        [btn sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal];
        
        /*
        //下载图片
        [[SDWebImageManager sharedManager]downloadImageWithURL:[NSURL URLWithString:square.icon] options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            
            [btn setImage:image forState:UIControlStateNormal];
            
        }];
         */
        
        [self addSubview:btn];
    }
}

@end
