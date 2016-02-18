//
//  XMGTopicPictureView.m
//  01-百思不得姐
//
//  Created by apple on 16/2/17.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGTopicPictureView.h"
#import "XMGTopic.h"
#import <UIImageView+WebCache.h>
#import "XMGProgressView.h"
#import "XMGShowPictureViewController.h"
@interface XMGTopicPictureView()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIImageView *gifView;

@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;


@property (weak, nonatomic) IBOutlet XMGProgressView *progressView;

@end

@implementation XMGTopicPictureView

+(instancetype)pictureView{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}
-(void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPicture)]];
}

-(void)showPicture{
    XMGShowPictureViewController *showPicture = [[XMGShowPictureViewController alloc]init];
    showPicture.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
}
-(void)setTopic:(XMGTopic *)topic{
    _topic = topic;
    
    [self.progressView setProgress:topic.pictureProgress animated:NO];
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//        self.progressView.hidden = NO;
//        CGFloat progress = 1.0 * receivedSize / expectedSize;
//        [self.progressView setProgress:progress animated:NO];
//    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        self.progressView.hidden = YES;
//    }];
    // 设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        // 计算进度值
        topic.pictureProgress = 1.0 * receivedSize / expectedSize;
        // 显示进度值
        [self.progressView setProgress:topic.pictureProgress animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        if (topic.isBigPicture == NO) return ;
        
        CGFloat width = topic.pictureF.size.width;
        CGFloat height = width *image.size.height / image.size.width;
        [image drawInRect:CGRectMake(0, 0, width, height)];
        
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
    }];

    
    NSString *extension = topic.large_image.pathExtension;
    self.gifView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    
    if (topic.isBigPicture) {
        self.seeBigButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }else{
        self.seeBigButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
    }
}
@end
