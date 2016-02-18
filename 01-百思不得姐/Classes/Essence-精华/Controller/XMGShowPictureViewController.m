//
//  XMGShowPictureViewController.m
//  01-百思不得姐
//
//  Created by apple on 16/2/18.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGShowPictureViewController.h"
#import "XMGTopic.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import "XMGProgressView.h"


@interface XMGShowPictureViewController ()

@property (weak, nonatomic) IBOutlet XMGProgressView *progressView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

/*<#注释#> */
@property (nonatomic, weak) UIImageView  *imageView;
@end

@implementation XMGShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back)]];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    
    CGFloat pictureW = screenW;
    CGFloat pictrueH = pictureW *self.topic.height / self.topic.width;
    
    if (pictrueH > screenH) {
        imageView.frame = CGRectMake(0, 0, pictureW, pictrueH);
        self.scrollView.contentSize = CGSizeMake(0, pictrueH);
    }else{
        imageView.size = CGSizeMake(pictureW, pictrueH);
        imageView.centerY = screenH * 00.5;
    }
    [self.progressView setProgress:self.topic.pictureProgress animated:NO];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        [self.progressView setProgress:1.0*receivedSize/expectedSize animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
    
}
- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save {
    if (self.imageView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"图片没有下载完毕"];
        return;
    }
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self,@selector(image:didFinishSavingWithError:contextInfo:), nil);

}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败!"];
    }else{
        [SVProgressHUD showErrorWithStatus:@"保存成功!"];
    }
}
@end
