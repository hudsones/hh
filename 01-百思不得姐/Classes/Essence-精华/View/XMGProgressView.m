//
//  XMGProgressView.m
//  01-百思不得姐
//
//  Created by apple on 16/2/18.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGProgressView.h"

@implementation XMGProgressView

-(void)awakeFromNib{
    self.roundedCorners = 2;
    self.progressLabel.textColor = [UIColor whiteColor];
}

-(void)setProgress:(CGFloat)progress animated:(BOOL)animated{
    [super setProgress:progress animated:YES];
    
    NSString *text = [NSString stringWithFormat:@"%.0f%%",progress*100];
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
}
@end
