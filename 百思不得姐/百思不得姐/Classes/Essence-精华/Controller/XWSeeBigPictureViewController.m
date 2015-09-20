//
//  XWSeeBigPictureViewController.m
//  百思不得姐
//
//  Created by longxianwen on 15/9/19.
//  Copyright (c) 2015年 longxianwen. All rights reserved.
//  查看大图

#import "XWSeeBigPictureViewController.h"
#import "XWTopic.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface XWSeeBigPictureViewController ()<UIScrollViewDelegate>

/** 图片 */
@property (nonatomic, weak) UIImageView *imageView;

/**相册库*/
@property (nonatomic,strong) ALAssetsLibrary *library;

@end

@implementation XWSeeBigPictureViewController


- (ALAssetsLibrary *)library
{
    if(!_library)
    {
        _library  = [[ALAssetsLibrary alloc]init];
    }
    return _library;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //滚动控件
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.bounds;
    //查看如果没有下面设置背景色语句效果
    scrollView.backgroundColor = [UIColor blackColor];
    [self.view insertSubview:scrollView atIndex:0];
    
    //图片控件
    UIImageView *imageView = [[UIImageView alloc]init];
    
    //下载大图
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.image1]];
    [scrollView addSubview: imageView];
    scrollView.delegate = self;
    self.imageView = imageView;
    
    
    //设置图片位置
    imageView.x = 0;
    imageView.width = XWScreenW;
    
    //等比拉伸尺寸:根据服务器返回的图片的宽度高度，根据等比例换算成屏幕真实显示的宽度高度
    imageView.height = self.topic.height * imageView.width / self.topic.width;
    
    //设置y值
    if(imageView.height > XWScreenH)
    {
        imageView.y = 0;
        //滚动范围
        scrollView.contentSize = CGSizeMake(0, imageView.height);
    }  else
    {
        imageView.centerY = XWScreenH * 0.5;
    }
    
    //缩放
    //如何做到定点缩放?
    
    //缩放到实际尺寸
    CGFloat maxScale = self.topic.height / imageView.height;
    if (maxScale > 1.0) {
        scrollView.maximumZoomScale = maxScale;
    }
}

#pragma mark - <UIScrollViewDelegate>
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

static NSString * const XWGroupNameKey = @"XWGroupNameKey";
static NSString * const XWDefaultGroupName = @"百思不得姐";

- (NSString *)groupName
{
    // 先从沙盒中取得名字
    NSString *groupName = [[NSUserDefaults standardUserDefaults] stringForKey:XWGroupNameKey];
    if (groupName == nil) { // 沙盒中没有存储任何文件夹的名字
        groupName = XWDefaultGroupName;
        
        // 存储名字到沙盒中
        [[NSUserDefaults standardUserDefaults] setObject:groupName forKey:XWGroupNameKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    return groupName;
}

- (IBAction)save:(id)sender {
    
    // 获得文件夹的名字
    __block NSString *groupName = [self groupName];
    
    // self的弱引用
    XWWeakSelf;
    
    __weak ALAssetsLibrary *weakLibrary = self.library;
    
    //创建一个新的文件夹
    [weakLibrary addAssetsGroupAlbumWithName:groupName resultBlock:^(ALAssetsGroup *group) {
        
        if(group) //新建文件夹
        {
            [weakSelf addImageToGroup:group];
        } else  //新建文件夹已经存在
        {
            //获得新建的文件夹
            [weakLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                
                NSString *name = [group valueForProperty:ALAssetsGroupPropertyName];
            
                if ([name isEqualToString:groupName]) { // 是自己创建的文件夹
                    // 添加图片到文件夹中
                    [weakSelf addImageToGroup:group];
                    
                    *stop = YES; // 停止遍历
                } else if([name isEqualToString:@"Camera Roll"])
                {
                    // 文件夹被用户强制删除了
                    groupName = [groupName stringByAppendingString:@" "];
                    // 存储新的名字
                    [[NSUserDefaults standardUserDefaults] setObject:groupName forKey:XWGroupNameKey];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    //新建文件夹，添加图片
                    [weakLibrary addAssetsGroupAlbumWithName:groupName resultBlock:^(ALAssetsGroup *group) {
                            [weakSelf addImageToGroup:group];
                    } failureBlock:nil];
                }
                
            } failureBlock:nil];
        }
    } failureBlock:nil];
}

/**
 * 添加一张图片到某个文件夹中
 */
- (void) addImageToGroup:(ALAssetsGroup *)group
{
    __weak ALAssetsLibrary *weakLibrary = self.library;
    
    //获得保存的图片
    CGImageRef image = self.imageView.image.CGImage;
    
    //1.先保存图片到系统相册
    [weakLibrary writeImageToSavedPhotosAlbum:image metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
        //2.在系统相册中找到图片,保存到自定义文件夹中
        [weakLibrary assetForURL:assetURL resultBlock:^(ALAsset *asset) {
            [group addAsset:asset];
            [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
        } failureBlock:nil];
    }];
}


@end
