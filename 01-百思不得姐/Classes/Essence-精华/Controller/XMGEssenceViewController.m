//
//  XMGEssenceViewController.m
//  01-百思不得姐
//
//  Created by xiaomage on 15/7/22.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "XMGEssenceViewController.h"

@interface XMGEssenceViewController()
/* 红色指示器*/
@property (nonatomic, weak) UIView *btoView;

/*选中的按钮 */
@property (nonatomic, weak) UIButton  *selectBtn;


@end

@implementation XMGEssenceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNav];
    [self setupTitlesView];
}
-(void)setupTitlesView{
    UIView *indicatorView = [[UIView alloc]init];
    indicatorView.width = self.view.width;
    indicatorView.height = 35;
    indicatorView.y = 64;
    indicatorView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.8];
    [self.view addSubview:indicatorView];

    UIView *btoView = [[UIView alloc]init];
    btoView.backgroundColor = [UIColor redColor];
    btoView.height = 2;
    btoView.y = indicatorView.height - btoView.height;
    [indicatorView addSubview:btoView];
    self.btoView = btoView;

    
    NSArray *title = @[@"全部",@"视频",@"声音",@"图片",@"段子"];

    for (NSInteger i=0; i<title.count; i++) {
       UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
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
    
}
-(void)titleClick:(UIButton *)button{
    [UIView animateWithDuration:0.25 animations:^{
        self.selectBtn.enabled = YES;
        button.enabled = NO;
        self.selectBtn = button;
        self.btoView.width = button.titleLabel.width;
        self.btoView.centerX = button.centerX;
    }];
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


@end
