//
//  XMGEssenceViewController.m
//  01-百思不得姐
//
//  Created by xiaomage on 15/7/22.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "XMGEssenceViewController.h"
#import "XMGALLViewController.h"
#import "XMGVideoViewController.h"
#import "XMGVoiceViewController.h"
#import "XMGPictureViewController.h"
#import "XMGWordViewController.h"


@interface XMGEssenceViewController()<UIScrollViewDelegate>
/* 红色指示器*/
@property (nonatomic, weak) UIView *btoView;

/*选中的按钮 */
@property (nonatomic, weak) UIButton  *selectBtn;

/*顶部的高度 */
@property (nonatomic, weak) UIView  *titlesView;

/*底部所有的内容 */
@property (nonatomic, weak) UIScrollView  *contentView;
@end

@implementation XMGEssenceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNav];
    
     [self setupChildVces];
    
    [self setupTitlesView];
    
    [self setupContentView];
}
-(void)setupChildVces{
    XMGALLViewController *all = [[XMGALLViewController alloc]init];
    [self addChildViewController:all];
    XMGVideoViewController *video = [[XMGVideoViewController alloc]init];
    [self addChildViewController:video];
    XMGVoiceViewController *voice = [[XMGVoiceViewController alloc]init];
    [self addChildViewController:voice];
    XMGPictureViewController *picture = [[XMGPictureViewController alloc]init];
    [self addChildViewController:picture];
    XMGWordViewController *word = [[XMGWordViewController alloc]init];
    [self addChildViewController:word];
}
-(void)setupContentView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *contentView = [[UIScrollView alloc]init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;

//    CGFloat bottom = self.tabBarController.tabBar.height;
//    CGFloat top = CGRectGetMaxY(self.titlesView.frame);
//    contentView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width*self.childViewControllers.count, 0);
    self.contentView = contentView;
    [self scrollViewDidEndScrollingAnimation:contentView];
    
}
-(void)setupTitlesView{
    UIView *indicatorView = [[UIView alloc]init];
    indicatorView.width = self.view.width;
    indicatorView.height = 35;
    indicatorView.y = 64;
    indicatorView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.8];
    [self.view addSubview:indicatorView];
    self.titlesView = indicatorView;

    UIView *btoView = [[UIView alloc]init];
    btoView.backgroundColor = [UIColor redColor];
    btoView.height = 2;
    btoView.tag = -1;
    btoView.y = indicatorView.height - btoView.height;
    [indicatorView addSubview:btoView];
    self.btoView = btoView;

    
    NSArray *title = @[@"全部",@"视频",@"声音",@"图片",@"段子"];

    for (NSInteger i=0; i<title.count; i++) {
       UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        float btnW = indicatorView.width/title.count;
        float btnH = indicatorView.height;
        float btnX = i *btnW;
        float btnY = 0;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        [btn setTitle:title[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [indicatorView addSubview:btn];
        if (i==0) {
            btn.enabled = NO;
            self.selectBtn = btn;
            
            [btn.titleLabel sizeToFit];
            
            self.btoView.width = btn.titleLabel.width;
            self.btoView.centerX = btn.centerX;
        }
       
    }
    [indicatorView addSubview:btoView];
    
}
-(void)titleClick:(UIButton *)button{
    [UIView animateWithDuration:0.25 animations:^{
        self.selectBtn.enabled = YES;
        button.enabled = NO;
        self.selectBtn = button;
        self.btoView.width = button.titleLabel.width;
        self.btoView.centerX = button.centerX;
    }];
    //滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag *self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}
-(void)setupNav{
    // 设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    // 设置背景色
    self.view.backgroundColor = XMGGlobalBg;

}
- (void)tagClick
{
    XMGLogFunc;
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;
    vc.view.height = scrollView.height;
    
        CGFloat bottom = self.tabBarController.tabBar.height;
        CGFloat top = CGRectGetMaxY(self.titlesView.frame);
        vc.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    vc.tableView.scrollIndicatorInsets = vc.tableView.contentInset;
    [scrollView addSubview:vc.view];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titlesView.subviews[index]];
}
@end
