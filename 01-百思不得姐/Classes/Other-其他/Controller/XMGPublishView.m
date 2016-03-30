//
//  XMGPublishView.m
//  01-百思不得姐
//
//  Created by apple on 16/2/19.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGPublishView.h"
#import "XMGVerticalButton.h"
#import <POP.h>

#define XMGRootView [UIApplication sharedApplication].keyWindow.rootViewController.view
static CGFloat const XMGSpringFactor = 10;
static CGFloat const XMGAnimationDelay = 0.1;
@interface XMGPublishView ()

@end

@implementation XMGPublishView

+ (instancetype)publishView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
- (void)awakeFromNib {
       // Do any additional setup after loading the view from its nib.
    XMGRootView.userInteractionEnabled = NO;
    self.userInteractionEnabled = NO;
    
    
    
    // 数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartY = (XMGScreenH - 2*buttonH)*0.5;
    CGFloat buttonStartX = 20;
    CGFloat xMargin = (XMGScreenW - 2*buttonStartX -maxCols * buttonW)/(maxCols-1);
    
//    for (int i=0; i<images.count; i++) {
//        XMGVerticalButton *button = [[XMGVerticalButton alloc]init];
//        
//        button.titleLabel.font = [UIFont systemFontOfSize:14];
//        [button setTitle:titles[i] forState:UIControlStateNormal];
//        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
//        
//        button.width = buttonW;
//        button.height = buttonH;
//        
//        int row = i / maxCols;
//        int col = i % maxCols;
//        CGFloat buttonX = buttonStartX + col * (xMargin +buttonW);
//        CGFloat buttonEndY = buttonStartY + row * buttonH;
//        CGFloat buttonBeginY = buttonEndY - XMGScreenH;
    
    for (int i = 0; i<images.count; i++) {
        XMGVerticalButton *button = [[XMGVerticalButton alloc] init];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        // 设置内容
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        // 计算X\Y
        int row = i / maxCols;
        int col = i % maxCols;
        CGFloat buttonX = buttonStartX + col * (xMargin + buttonW);
        CGFloat buttonEndY = buttonStartY + row * buttonH;
        CGFloat buttonBeginY = buttonEndY - XMGScreenH;
    
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        anim.springBounciness = XMGSpringFactor;
        anim.springSpeed = XMGSpringFactor;
        anim.beginTime = CACurrentMediaTime() + XMGAnimationDelay * i;
        [button pop_addAnimation:anim forKey:nil];
        
    }
        //添加biaoyu
        
        UIImageView *sloganView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
         [self addSubview:sloganView];
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerEndY  = XMGScreenH * 0.2;
        CGFloat centerX = XMGScreenW *0.5;
        CGFloat centerBeginY = centerEndY - XMGScreenH;
        anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerBeginY)];
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
        anim.beginTime = CACurrentMediaTime() + images.count * XMGAnimationDelay;
        anim.springBounciness = XMGSpringFactor;
        anim.springSpeed = XMGSpringFactor;
        
        [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
              XMGRootView.userInteractionEnabled = YES;
            self.userInteractionEnabled = YES;
        }];
        [sloganView pop_addAnimation:anim forKey:nil];
    }

- (IBAction)cancel {
    [self cancelWithCompletionBlock:nil];
}
    
    

-(void)buttonClick:(UIButton *)button{
    [self cancelWithCompletionBlock:^{
        if (button.tag == 0) {
            XMGLog(@"发视频");
        }else if(button.tag == 1){
            XMGLog(@"发tup");
        }
    }];
}

-(void)cancelWithCompletionBlock:(void(^)())completionBlock{
    self.userInteractionEnabled = NO;
    
    int beginIndes = 2;
    for (int i=beginIndes; i<self.subviews.count; i++) {
        UIView *subView = self.subviews[i];
        
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerY = subView.centerY + XMGScreenH;
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subView.centerX, centerY)];
        anim.beginTime = CACurrentMediaTime() + (i - beginIndes) * XMGAnimationDelay;
        
        [subView pop_addAnimation:anim forKey:nil];
        
        if (i == self.subviews.count - 1) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                [self removeFromSuperview];
                !completionBlock ? :completionBlock();
            }];
        }
    }
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
